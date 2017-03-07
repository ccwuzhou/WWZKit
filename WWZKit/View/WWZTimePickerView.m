//
//  WWZTimePickerView.m
//  wwz
//
//  Created by wwz on 16/8/9.
//  Copyright © 2016年 cn.szwwz. All rights reserved.
//

#import "WWZTimePickerView.h"

#define kDefaultTextFont [UIFont systemFontOfSize:17]
#define kDefaultTextColor [UIColor blackColor]
#define kDefaultRowHeight 44

#define kAccessoryTFont [UIFont systemFontOfSize:17]
#define kAccessoryTColor [UIColor blackColor]

static const int kCircleCount = 10;

@interface WWZTimePickerView ()<UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) NSArray *components;

@property (nonatomic, strong) NSMutableDictionary *mDict;

@property (nonatomic, copy) void (^selectedDictBlock)(NSMutableDictionary *);

@property (nonatomic, strong) UILabel *hourLabel;

@end

@implementation WWZTimePickerView

/**
 *  自定义pickerView
 *
 *  @param frame          frame
 *  @param components     @[@[],@[]...]
 *  @param block          选中回调@{@(component):text}
 *
 *  @return pickerView
 */
+ (instancetype)wwz_pickerViewWithFrame:(CGRect)frame components:(NSArray *)components didSelectedBlock:(void(^)(NSDictionary *result))block{
    
    return [[self alloc] initWithFrame:frame components:components didSelectedBlock:block];
}

- (instancetype)initWithFrame:(CGRect)frame components:(NSArray *)components didSelectedBlock:(void(^)(NSDictionary *result))block{
    
    if (self = [super initWithFrame:frame]) {
        
        self.delegate = self;
        self.dataSource = self;
        
        _components = components;
        _selectedDictBlock = block;
        
        _componentWidth = frame.size.width/components.count;
        _rowHeight = kDefaultRowHeight;
        _textColor = kDefaultTextColor;
        _textFont = kDefaultTextFont;
        
        _mDict = [NSMutableDictionary dictionary];
        
    }
    return self;
}



- (void)selectRow:(NSInteger)row inComponent:(NSInteger)component animated:(BOOL)animated{
    
    NSArray *rows = _components[component];
    
    row = !_isCircle ? row : row%rows.count + rows.count*(kCircleCount/2);
    
    [super selectRow:row inComponent:component animated:animated];
}
- (void)setIsCircle:(BOOL)isCircle{
    _isCircle = isCircle;
    for (int i = 0; i < self.components.count; i++) {
        NSArray *rows = self.components[i];
        [self selectRow:rows.count inComponent:i animated:YES];
    }
}
#pragma mark - pickerView delegate DataSource
//控件有几列
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return _components.count;
}
//列中有几行
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    
    if (![_components[component] isKindOfClass:[NSArray class]]) {
        NSLog(@"components 格式不正确");
        return 0;
    }
    NSArray *rows = _components[component];
    return !_isCircle ? rows.count : rows.count*kCircleCount;
}

//每行内容是什么
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    if (![_components[component] isKindOfClass:[NSArray class]]) {
        return nil;
    }
    NSArray *rows = _components[component];
    
    row = !_isCircle ? row : row % rows.count;
    
    if (rows.count -1 < row) {
        return nil;
    }
    if (![rows[row] isKindOfClass:[NSString class]]) {
        return nil;
    }
    
    return rows[row];
    
}
// 复写行内容
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    
    UILabel* pickerLabel = (UILabel*)view;
    
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.textColor = _textColor;
        pickerLabel.font = _textFont;
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        pickerLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    pickerLabel.text= [NSString stringWithFormat:@"%@",[self pickerView:pickerView titleForRow:row forComponent:component]];
    
    return pickerLabel;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    return _componentWidth;
}
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component{
    return _rowHeight;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    [self selectRow:row inComponent:component animated:NO];
    
    NSString *text = [self pickerView:pickerView titleForRow:row forComponent:component];
    
    if (!text) {
        return;
    }
    
    _mDict[@(component)] = text;
    
    if (_selectedDictBlock) {
        _selectedDictBlock(_mDict);
    }
}

#pragma mark - setter

- (void)setComponentWidth:(CGFloat)componentWidth{
    if (componentWidth > 0) {
        _componentWidth = componentWidth;
    }
}

- (void)setRowHeight:(CGFloat)rowHeight{
    if (rowHeight > 0) {
        _rowHeight = rowHeight;
    }
}

- (void)setTextFont:(UIFont *)textFont{
    if (textFont) {
        _textFont = textFont;
    }
}

- (void)setTextColor:(UIColor *)textColor{
    if (textColor) {
        _textColor = textColor;
    }
}

- (void)setComonentTitles:(NSArray *)comonentTitles{
    
    if (!comonentTitles||comonentTitles.count == 0) {
        
        return;
    }
    
    if (_components.count == 1) {
    
        UILabel *midLabel = [self labelInPikerViewWithTitle:comonentTitles[0]];
        CGRect midLabelFrame = midLabel.frame;
        midLabelFrame.origin.x = self.frame.size.width+30;
        midLabel.frame = midLabelFrame;
        [self addSubview:midLabel];
        
    }else if (_components.count == 2){
    
        UILabel *leftHourLabel = [self labelInPikerViewWithTitle:comonentTitles[0]];
        CGRect hourLFrame = leftHourLabel.frame;
        hourLFrame.origin.x = self.frame.size.width*0.5-2.5-30;
        leftHourLabel.frame = hourLFrame;
        [self addSubview:leftHourLabel];
        
        UILabel *rightMinuteLabel = [self labelInPikerViewWithTitle:comonentTitles[1]];
        CGRect minuteLFrame = rightMinuteLabel.frame;
        minuteLFrame.origin.x = self.frame.size.width*0.5+2.5+self.componentWidth-30;
        rightMinuteLabel.frame = minuteLFrame;
        [self addSubview:rightMinuteLabel];
    }
}
/**
 *  时间label
 */
- (UILabel *)labelInPikerViewWithTitle:(NSString *)title{
    
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.font = _textFont;
    label.textColor = _textColor;
    label.textAlignment = NSTextAlignmentRight;
    label.numberOfLines = 1;
    
    [label sizeToFit];
    
    label.center = CGPointMake(0, self.frame.size.height*0.5);
    return label;
}


- (void)dealloc{
    NSLog(@"%s", __func__);
}

@end

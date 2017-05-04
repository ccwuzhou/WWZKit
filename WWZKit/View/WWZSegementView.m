//
//  WWZSegementView.m
//  Pods
//
//  Created by apple on 2017/5/4.
//
//

#import "WWZSegementView.h"
#import "UIView+WWZ.h"
#import "UIButton+WWZ.h"


@interface WWZSegementButton : UIButton

@end

@implementation WWZSegementButton

- (void)setHighlighted:(BOOL)highlighted{}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    [self.titleLabel sizeToFit];
    
    [self.titleLabel wwz_alignCenter];
    
    [self.imageView wwz_alignCenter];
}

@end

@interface WWZSegementView ()

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) UIButton *selButton;

@property (nonatomic, strong) UIView *lineView;

@end

@implementation WWZSegementView

static int const SEGEMENT_BUTTON_TAG = 99;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titles = titles;
        
        [self setContentView];
        
    }
    return self;
}

- (void)setContentView{

    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.contentSize = self.size;
    self.scrollEnabled = NO;
    
    self.lineHeight = 2;
    
    [self addTitleButtons];
}


- (void)addTitleButtons{

    CGFloat buttonW = self.width / self.titles.count;
    
    for (int i = 0; i < self.titles.count; i++) {
        
        NSString *title = self.titles[i];
        
        WWZSegementButton *button = [WWZSegementButton wwz_buttonWithFrame:CGRectMake(i*buttonW, 0, buttonW, self.height) nTitle:title sTitle:title tFont:[UIFont systemFontOfSize:15] nColor:[UIColor blackColor] sColor:[UIColor redColor]];
        
        button.tag = SEGEMENT_BUTTON_TAG + i;
        [button addTarget:self action:@selector(clickButtonAtIndex:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
        
        if (i == 0) {
            
            button.selected = YES;
            _selButton = button;
        }
    }
}

- (void)setFrame:(CGRect)frame{

    [super setFrame:frame];
    
    [self reloadContentView];
}


- (void)reloadContentView{

    for (int i = 0; i < self.titles.count; i++) {
        
        UIButton *sender = [self viewWithTag:i+SEGEMENT_BUTTON_TAG];
        
        sender.frame = CGRectMake(i*self.cellWidth, 0, self.cellWidth, self.height);
        
        if (i == 0) {
            
            if (self.segementType == WWZSegementTypeBottomLine) {
                _lineView.frame = CGRectMake((sender.width-self.lineView.width)*0.5, sender.height-8, self.lineView.width, self.lineHeight);
            }
        }
    }
}

- (void)clickButtonAtIndex:(UIButton *)sender{

    if (sender == _selButton) {
        return;
    }
    
    _selButton.selected = NO;
    
    sender.selected = YES;
    
    _selButton = sender;
    
    if (self.segementType == WWZSegementTypeBottomLine) {
    
        [UIView animateWithDuration:0.3 animations:^{
            self.lineView.x = _selButton.x+(_selButton.width-self.lineView.width)*0.5;
        }];
    }
    
    if ([self.segementDelegate respondsToSelector:@selector(segementView:clickButtonAtIndex:)]) {
        [self.segementDelegate segementView:self clickButtonAtIndex:(int)sender.tag - SEGEMENT_BUTTON_TAG];
    }
}


#pragma mark - 公有方法
/**
 *  设置类型
 */
- (void)setSegementType:(WWZSegementType)segementType{

    _segementType = segementType;
    
    if (self.segementType == WWZSegementTypeBottomLine) {
        
        CGFloat stringW = [self p_stringSizeWithString:_selButton.titleLabel.text font:_selButton.titleLabel.font maxSize:_selButton.size].width;
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake((_selButton.width-stringW)*0.5, _selButton.height-8, stringW, self.lineHeight)];
        lineView.backgroundColor = [UIColor redColor];
        [self addSubview:lineView];
        
        _lineView = lineView;
    }
}

/**
 *  单个cell宽
 */
- (void)setCellWidth:(CGFloat)cellWidth{
    
    _cellWidth = cellWidth;
    
    CGFloat contentWidth = self.titles.count*cellWidth;
    
    self.contentSize = CGSizeMake(contentWidth, self.height);
    
    self.scrollEnabled = self.width < contentWidth;
    
    [self reloadContentView];
}

- (void)setLineHeight:(CGFloat)lineHeight{

    _lineHeight = lineHeight;
    
    if (self.segementType == WWZSegementTypeBottomLine) {
        _lineView.height = self.lineHeight;
    }
}
/**
 *  选中按钮
 */
- (void)selectCellAtIndex:(int)index{

    UIButton *sender = [self viewWithTag:index+SEGEMENT_BUTTON_TAG];
    
    if (sender == _selButton) {
        return;
    }
    
    _selButton.selected = NO;
    
    sender.selected = YES;
    
    _selButton = sender;
    
    if (self.segementType == WWZSegementTypeBottomLine) {
        
        [UIView animateWithDuration:0.3 animations:^{
            self.lineView.x = _selButton.x+(_selButton.width-self.lineView.width)*0.5;
        }];
    }
}

/**
 *  设置文字属性
 */
- (void)setTitleFont:(UIFont *)font nColor:(UIColor *)nColor sColor:(UIColor *)sColor{

    for (int i = 0; i < self.titles.count; i++) {
    
        UIButton *sender = [self viewWithTag:i+SEGEMENT_BUTTON_TAG];
        
        [sender wwz_setNColor:nColor sColor:sColor];
        [sender wwz_setTitleFont:font];
    }
    
    if (self.segementType == WWZSegementTypeBottomLine) {
    
        self.lineView.backgroundColor = sColor;
    }
}

/**
 *  设置背景图片，仅当WWZSegementTypeCustom时可用
 */
- (void)setNBImage:(UIImage *)nBImage sBImage:(UIImage *)sBImage{

    if (self.segementType != WWZSegementTypeCustom) {
        
        return;
    }
    
    for (int i = 0; i < self.titles.count; i++) {
        
        UIButton *sender = [self viewWithTag:i+SEGEMENT_BUTTON_TAG];
        
        [sender setImage:nBImage forState:UIControlStateNormal];
        [sender setImage:sBImage forState:UIControlStateSelected];
    }
}


#pragma mark - getter



#pragma mark - help
- (CGSize)p_stringSizeWithString:(NSString *)string font:(UIFont *)font maxSize:(CGSize)maxSize{
    
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rectToFit = [string boundingRectWithSize:maxSize options:options attributes:@{NSFontAttributeName:font} context:nil];
    
    // 向上取整
    return CGSizeMake(ceilf(rectToFit.size.width), ceilf(rectToFit.size.height));
}
@end

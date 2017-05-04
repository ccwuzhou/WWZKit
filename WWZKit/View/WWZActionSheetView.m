//
//  WWZActionSheetView.m
//  wwz
//
//  Created by wwz on 16/11/15.
//  Copyright © 2016年 cn.szwwz. All rights reserved.
//

#import "WWZActionSheetView.h"


#define kLineColor [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0]

@interface WWZActionSheetView ()

@property (nonatomic, weak) UILabel *titleLabel;
@property (nonatomic, weak) UIButton *cancelButton;
@property (nonatomic, weak) UIView *selectView;
@property (nonatomic, copy) void(^block)(int);

@end

@implementation WWZActionSheetView

static int const BUTTON_TAG = 99;


+ (void)showActionSheetViewWithTitle:(NSString *)title
                   cancelButtonTitle:(NSString *)cancelButtonTitle
                   otherButtonTitles:(NSArray *)otherButtonTitles
                    clickButtonBlock:(void(^)(int index))clickButtonBlock
{
    WWZActionSheetView *sheetView = [[self alloc] initWithTitle:title cancelButtonTitle:cancelButtonTitle otherButtonTitles:otherButtonTitles clickButtonBlock:clickButtonBlock];
    [sheetView show];
}

- (instancetype)initWithTitle:(NSString *)title
            cancelButtonTitle:(NSString *)cancelButtonTitle
            otherButtonTitles:(NSArray *)otherButtonTitles
             clickButtonBlock:(void(^)(int index))clickButtonBlock
{
    CGFloat leftX = 10;
    CGFloat spaceY = 10;
    CGFloat buttonH = 50;
    CGFloat titleLH = 60;
    self = [super initWithFrame:CGRectMake(leftX, 0, [UIScreen mainScreen].bounds.size.width-2*leftX, spaceY*3+titleLH+buttonH*(otherButtonTitles.count+1))];
    if (self) {
        
        _block = clickButtonBlock;
        
        // select view
        UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(0, spaceY, self.frame.size.width, titleLH+buttonH*otherButtonTitles.count)];
        selectView.layer.masksToBounds = YES;
        selectView.layer.cornerRadius = 15;
        selectView.backgroundColor = [UIColor whiteColor];
        [self addSubview:selectView];
        _selectView = selectView;
        
        // title label
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(leftX, 0, selectView.frame.size.width-2*leftX, titleLH)];
        titleLabel.text = title;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.textColor = [UIColor blackColor];
        titleLabel.font = [UIFont boldSystemFontOfSize:17];
        [selectView addSubview:titleLabel];
        _titleLabel = titleLabel;
        
        // select button
        for (int i = 0; i < otherButtonTitles.count; i++) {
            
            UIButton *button = [self buttonWithFrame:CGRectMake(0, titleLH+buttonH*i, selectView.frame.size.width, buttonH) title:otherButtonTitles[i] tag:i];
            [selectView addSubview:button];
        }
        
        // cancel button
        UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelBtn.frame = CGRectMake(0, self.frame.size.height-spaceY-buttonH, self.frame.size.width, buttonH);
        [cancelBtn setTitle:cancelButtonTitle forState:UIControlStateNormal];
        [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [cancelBtn setBackgroundImage:[self imageWithColor:kLineColor size:cancelBtn.frame.size alpha:0.8] forState:UIControlStateHighlighted];
        cancelBtn.titleLabel.font = [UIFont boldSystemFontOfSize:16];
        cancelBtn.tag = BUTTON_TAG+otherButtonTitles.count;
        cancelBtn.layer.masksToBounds = YES;
        cancelBtn.layer.cornerRadius = 15;
        cancelBtn.backgroundColor = [UIColor whiteColor];
        [cancelBtn addTarget:self action:@selector(clickButtonAtIndex:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:cancelBtn];
        _cancelButton = cancelBtn;
        
    }
    return self;
}

- (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title tag:(int)tag{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[self imageWithColor:kLineColor size:frame.size alpha:0.5] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    btn.tag = BUTTON_TAG+tag;
    
    [btn addTarget:self action:@selector(clickButtonAtIndex:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 0.5)];
    lineView.backgroundColor = kLineColor;
    [btn addSubview:lineView];
    
    return btn;
}
/**
 *  点击btn
 */
- (void)clickButtonAtIndex:(UIButton *)sender{
    
    if (_block) {
        _block((int)sender.tag-BUTTON_TAG);
    }
    [self dismiss];
}



#pragma mark - setter

/**
 *  title color
 */
- (void)setTitleColor:(UIColor *)titleColor{

    if (!titleColor) {
        return;
    }
    self.titleLabel.textColor = titleColor;
}

/**
 *  title font
 */
- (void)setTitleFont:(UIFont *)titleFont{
    
    if (!titleFont) {
        return;
    }
    self.titleLabel.font = titleFont;
}

/**
 *  button color
 */
- (void)setOtherButtonTitleColor:(UIColor *)buttonTitleColor{
    
    if (!buttonTitleColor) {
        return;
    }
    for (UIView *subView in self.selectView.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            
            UIButton *btn = (UIButton *)subView;
            [btn setTitleColor:buttonTitleColor forState:UIControlStateNormal];
        }
    }
}

/**
 *  cancel button color
 */
- (void)setCancelButtonTitleColor:(UIColor *)buttonTitleColor{
    
    if (!buttonTitleColor) {
        return;
    }
    [_cancelButton setTitleColor:buttonTitleColor forState:UIControlStateNormal];
}

/**
 *  button font
 */
- (void)setOtherButtonTitleFont:(UIFont *)buttonTitleFont{
    
    if (!buttonTitleFont) {
        return;
    }
    for (UIView *subView in self.selectView.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            
            UIButton *btn = (UIButton *)subView;
            btn.titleLabel.font = buttonTitleFont;
        }
    }
    
}

- (void)setCancelButtonTitleFont:(UIFont *)buttonTitleFont{

    if (!buttonTitleFont) {
        return;
    }
    _cancelButton.titleLabel.font = buttonTitleFont;
}
/**
 *  button back color
 */
- (void)setButtonNBColor:(UIColor *)nBColor hBColor:(UIColor *)hBColor{
    
    for (UIView *subView in self.selectView.subviews) {
        
        if ([subView isKindOfClass:[UIButton class]]) {
            
            UIButton *btn = (UIButton *)subView;
            if (nBColor) {
                [btn setBackgroundImage:[self imageWithColor:hBColor size:btn.frame.size alpha:1] forState:UIControlStateNormal];
            }
            if (hBColor) {
                [btn setBackgroundImage:[self imageWithColor:hBColor size:btn.frame.size alpha:1] forState:UIControlStateHighlighted];
            }
        }
    }
    if (nBColor) {
        [_cancelButton setBackgroundImage:[self imageWithColor:hBColor size:_cancelButton.frame.size alpha:1] forState:UIControlStateNormal];
    }
    if (hBColor) {
        [_cancelButton setBackgroundImage:[self imageWithColor:hBColor size:_cancelButton.frame.size alpha:1] forState:UIControlStateHighlighted];
    }
}


#pragma mark - show/hide
- (void)show{
    
    // 背景view
    UIButton *containButton = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
    containButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.3];
    [containButton addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [containButton addSubview:self];
    
    // 添加到window上
    [[UIApplication sharedApplication].keyWindow addSubview:containButton];
    
    containButton.alpha = 0;
    
    __block CGRect selfFrame = self.frame;
    
    selfFrame.origin.y = CGRectGetMaxY(containButton.frame);
    self.frame = selfFrame;
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         
                         containButton.alpha = 1;
                         
                         selfFrame.origin.y = CGRectGetMaxY(containButton.frame)-selfFrame.size.height;
                         
                         self.frame = selfFrame;
                     }
                     completion:nil];

}

- (void)dismiss{
    
    [UIView animateWithDuration:0.3
                     animations:^{
                         
                         CGRect selfFrame = self.frame;
                         
                         selfFrame.origin.y = CGRectGetMaxY(self.superview.frame);
                         
                         self.frame = selfFrame;
                         
                         self.superview.alpha = 0;
                     }
                     completion:^(BOOL finished) {
                         
                         [self.superview removeFromSuperview];
                         [self removeFromSuperview];
                         
                     }];
}

#pragma mark - help

- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size alpha:(float)alpha{
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAlpha(context, alpha);
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

//- (void)dealloc{
//    NSLog(@"%s", __func__);
//}
@end

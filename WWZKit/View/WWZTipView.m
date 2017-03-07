//
//  WWZTipView.m
//  BCSmart
//
//  Created by wwz on 16/11/14.
//  Copyright © 2016年 cn.zgkjd. All rights reserved.
//

#import "WWZTipView.h"

#define kColorFromRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define kLineColor [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0]

@interface WWZTipView ()

@property (nonatomic, strong) UIButton *containButton;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, copy) void(^block)(int);

@property (nonatomic, strong) NSMutableParagraphStyle *mParagraphStyle;

@property (nonatomic, strong) NSMutableAttributedString *mAttributedString;
@end

@implementation WWZTipView

static int const BUTTON_TAG = 99;

+ (void)showTipViewWithTitle:(NSString *)title
                   titleFont:(UIFont *)titleFont
                 lineSpacing:(CGFloat)lineSpacing
                buttonTitles:(NSArray *)buttonTitles
            clickButtonBlock:(void(^)(int index))block
{
    WWZTipView *tipView = [[self alloc] initWithTitle:title titleFont:titleFont lineSpacing:lineSpacing buttonTitles:buttonTitles clickButtonBlock:block];
    [tipView show];
}

- (instancetype)initWithTitle:(NSString *)title
                    titleFont:(UIFont *)titleFont
                  lineSpacing:(CGFloat)lineSpacing
                 buttonTitles:(NSArray *)buttonTitles
             clickButtonBlock:(void(^)(int index))block
{
    self = [super init];
    
    if (self) {
        
        if (buttonTitles.count > 2) {
            return nil;
        }
        _block = block;
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 15;
        
        self.backgroundColor = [UIColor whiteColor];
        
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        
        CGRect frame = CGRectZero;
        
        CGFloat tipViewX = 0;
        
        if (screenSize.width == 320) {
            tipViewX = 30;
        }else if (screenSize.width == 375){
            tipViewX = 45;
        }else{
            tipViewX = 60;
        }
        frame.origin.x = tipViewX;
        frame.size.width = screenSize.width-2*tipViewX;
        
        // label
        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.numberOfLines = 0;
        
        self.mParagraphStyle.lineSpacing = lineSpacing;
        
        self.mAttributedString = [[NSMutableAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName: titleFont, NSForegroundColorAttributeName: [UIColor blackColor], NSParagraphStyleAttributeName: self.mParagraphStyle}];
        
        titleLabel.attributedText = self.mAttributedString;
        
        CGFloat titleLX = 20;
        CGFloat titleLY = 20;
        CGFloat titleLW = frame.size.width-titleLX*2;
        CGFloat titleLH = [titleLabel textRectForBounds:CGRectMake(0, 0, titleLW, FLT_MAX) limitedToNumberOfLines:0].size.height;
        
        titleLY = titleLH < 30 ? titleLY + 2.5 : titleLY;
        
        titleLabel.frame = CGRectMake(titleLX, titleLY, titleLW, titleLH);
        
        // btn
        CGFloat buttonH = 45;
        frame.size.height = 2*titleLY + titleLH + buttonH;
        frame.origin.y = (screenSize.height-frame.size.height)*0.5;
        
        self.frame = frame;
        
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;
        
        // contain button
        _containButton = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _containButton.backgroundColor = kColorFromRGBA(0, 0, 0, 0.3);
        [_containButton addSubview:self];
        
        if (buttonTitles.count == 1) {
            
            UIButton *btn = [self buttonWithFrame:CGRectMake(0, self.frame.size.height-buttonH, self.frame.size.width, buttonH) title:buttonTitles[0] tag:0];
            [self addSubview:btn];
            
        }else{
            
            for (int i = 0; i < buttonTitles.count; i++) {
                
                UIButton *btn = [self buttonWithFrame:CGRectMake(0+i*self.frame.size.width*0.5, self.frame.size.height-buttonH, self.frame.size.width*0.5, buttonH) title:buttonTitles[i] tag:i];
                [self addSubview:btn];
            }
            
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width*0.5-0.25, self.frame.size.height-buttonH, 0.5, buttonH)];
            lineView.backgroundColor = kLineColor;
            [self addSubview:lineView];
        }
    }
    return self;
}



- (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title tag:(int)tag{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[self imageWithColor:kLineColor size:frame.size alpha:1] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    btn.tag = BUTTON_TAG+tag;
    
    
    [btn addTarget:self action:@selector(clickButtonAtIndex:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 0.5)];
    lineView.backgroundColor = kLineColor;
    [btn addSubview:lineView];
    
    return btn;
}

- (void)clickButtonAtIndex:(UIButton *)sender{

    if (_block) {
        _block((int)sender.tag - BUTTON_TAG);
    }
    [self dismiss];
}

/**
 *  title color
 */
- (void)setTitleColor:(UIColor *)titleColor{
    
    if (!titleColor) {
        return;
    }
    
    [self.mAttributedString addAttribute:NSForegroundColorAttributeName value:titleColor range:NSMakeRange(0, self.mAttributedString.string.length)];
    self.titleLabel.attributedText = self.mAttributedString;
}

/**
 *  button color
 */
- (void)setButtonTitleColor:(UIColor *)buttonTitleColor{

    if (!buttonTitleColor) {
        return;
    }
    
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            
            UIButton *btn = (UIButton *)subView;
            [btn setTitleColor:buttonTitleColor forState:UIControlStateNormal];
        }
    }
}

/**
 *  button font
 */
- (void)setButtonTitleFont:(UIFont *)buttonTitleFont{
    
    if (!buttonTitleFont) {
        return;
    }
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            
            UIButton *btn = (UIButton *)subView;
            btn.titleLabel.font = buttonTitleFont;
        }
    }
}
/**
 *  button high back color
 */
- (void)setButtonHighlightedBackgroundColor:(UIColor *)backgroundColor{

    if (!backgroundColor) {
        return;
    }
    
    for (UIView *subView in self.subviews) {
        if ([subView isKindOfClass:[UIButton class]]) {
            
            UIButton *btn = (UIButton *)subView;
            [btn setBackgroundImage:[self imageWithColor:backgroundColor size:btn.frame.size alpha:1] forState:UIControlStateHighlighted];
        }
    }
}

- (NSMutableParagraphStyle *)mParagraphStyle{
    
    if (!_mParagraphStyle) {
    
        _mParagraphStyle = [[NSMutableParagraphStyle alloc] init];
        _mParagraphStyle.firstLineHeadIndent = 0;
        _mParagraphStyle.alignment = NSTextAlignmentCenter;
        _mParagraphStyle.lineSpacing = 5;
    }
    return _mParagraphStyle;
}


- (void)show{
    
    _containButton.alpha = 0.0;
    [[UIApplication sharedApplication].keyWindow addSubview:_containButton];
    
    [UIView animateWithDuration:0.3 animations:^{
        _containButton.alpha = 1.0;
    }completion:^(BOOL finished) {
        
    }];
}

- (void)dismiss{
    
    [UIView animateWithDuration:0.3 animations:^{
        _containButton.alpha = 0.0;
    }completion:^(BOOL finished) {
        [_containButton removeFromSuperview];
        _containButton = nil;
    }];
}


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

- (void)dealloc{
    NSLog(@"%s", __func__);
}
@end

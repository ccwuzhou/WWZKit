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

static CGFloat const TIP_BUTTON_HTIGHT = 45.0;
static int const BUTTON_TAG = 99;
static CGFloat TIP_TITLE_LABEL_X = 20.0;

@interface WWZTipView ()

@property (nonatomic, strong) UIButton *containButton;

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, copy) void(^block)(int);

@property (nonatomic, strong) NSMutableParagraphStyle *mParagraphStyle;

@property (nonatomic, strong) NSMutableAttributedString *mAttributedString;

@property (nonatomic, assign) CGFloat tipLabelY;
@end

@implementation WWZTipView



+ (void)showTipViewWithTitle:(NSString *)title
                   titleFont:(UIFont *)titleFont
                 lineSpacing:(CGFloat)lineSpacing
                buttonTitles:(NSArray *)buttonTitles
            clickButtonBlock:(void(^)(int index))block
{
    WWZTipView *tipView = [[self alloc] initWithTitle:title titleFont:titleFont lineSpacing:lineSpacing buttonTitles:buttonTitles clickButtonBlock:block];
    [tipView wwz_showCompletion:nil];
}

- (instancetype)initWithTitle:(NSString *)title
                    titleFont:(UIFont *)titleFont
                  lineSpacing:(CGFloat)lineSpacing
                 buttonTitles:(NSArray *)buttonTitles
             clickButtonBlock:(void(^)(int index))block
{
    self = [super initWithFrame:CGRectZero showType:WWZShowViewTypeNone];
    
    if (self) {
        
        if (buttonTitles.count == 0 || buttonTitles.count > 2) {
            return self;
        }
        _block = block;
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 15;
        
        self.backgroundColor = [UIColor whiteColor];
        
        self.tapEnabled = NO;
        
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
        self.frame = frame;
        // label
        [self p_addTitleLabelWithTitle:title font:titleFont lineSpace:lineSpacing];
        
        frame.size.height = 2*self.tipLabelY + self.titleLabel.frame.size.height + TIP_BUTTON_HTIGHT;
        frame.origin.y = (screenSize.height-frame.size.height)*0.5;
        
        self.frame = frame;
        
        // buttons
        [self p_addBottomButtons:buttonTitles];
    }
    return self;
}

- (void)p_addTitleLabelWithTitle:(NSString *)title font:(UIFont *)font lineSpace:(CGFloat)lineSpace{

    self.tipLabelY = 20.0;
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.numberOfLines = 0;
    
    self.mParagraphStyle.lineSpacing = lineSpace;
    
    self.mAttributedString = [[NSMutableAttributedString alloc] initWithString:title attributes:@{NSFontAttributeName: font, NSForegroundColorAttributeName: [UIColor blackColor], NSParagraphStyleAttributeName: self.mParagraphStyle}];
    
    titleLabel.attributedText = self.mAttributedString;
    
    CGFloat titleLW = self.frame.size.width-TIP_TITLE_LABEL_X*2;
    CGFloat titleLH = [titleLabel textRectForBounds:CGRectMake(0, 0, titleLW, FLT_MAX) limitedToNumberOfLines:0].size.height;
    
    self.tipLabelY = titleLH < 30 ? self.tipLabelY + 2.5 : self.tipLabelY;
    
    titleLabel.frame = CGRectMake(TIP_TITLE_LABEL_X, self.tipLabelY, titleLW, titleLH);
    
    [self addSubview:titleLabel];
    _titleLabel = titleLabel;
}

- (void)p_addBottomButtons:(NSArray *)buttonTitles{

    for (int i = 0; i < buttonTitles.count; i++) {
        
        CGFloat buttonW = self.frame.size.width/buttonTitles.count;
        
        UIButton *btn = [self buttonWithFrame:CGRectMake(0+i*buttonW, self.frame.size.height-TIP_BUTTON_HTIGHT, buttonW, TIP_BUTTON_HTIGHT) title:buttonTitles[i] tag:i];
        [self addSubview:btn];
        
        if (i == 1) {
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(self.frame.size.width*0.5-0.25, self.frame.size.height-TIP_BUTTON_HTIGHT, 0.5, TIP_BUTTON_HTIGHT)];
            lineView.backgroundColor = kLineColor;
            [self addSubview:lineView];
        }
    }
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
    [self wwz_dismiss];
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

//
//  WWZTipView.m
//  BCSmart
//
//  Created by wwz on 16/11/14.
//  Copyright © 2016年 cn.zgkjd. All rights reserved.
//

#import "WWZTipView.h"
#import "UIView+WWZ.h"

#define WWZ_TIPVIEW_LINE_COLOR [UIColor colorWithRed:204/255.0 green:204/255.0 blue:204/255.0 alpha:1.0]

#define WWZ_TIPVIEW_X ([UIScreen mainScreen].bounds.size.width == 320 ? 30 : ([UIScreen mainScreen].bounds.size.width == 375 ? 45 : 60))

static CGFloat const TIP_BUTTON_HTIGHT = 45.0;

static int const BUTTON_TAG = 99;

@interface WWZTipView ()

@property (nonatomic, weak) UILabel *titleLabel;

@property (nonatomic, copy) void(^block)(int);

@end

@implementation WWZTipView

- (instancetype)initWithAttributedText:(NSAttributedString *)attributedText
                          buttonTitles:(NSArray *)buttonTitles
                      clickButtonBlock:(void(^)(int index))block
{
    self = [super initWithFrame:CGRectMake(WWZ_TIPVIEW_X, 0, [UIScreen mainScreen].bounds.size.width-2*WWZ_TIPVIEW_X, 0)];
    
    if (self) {
        
        if (buttonTitles.count == 0 || buttonTitles.count > 2) {
            return self;
        }
        
        self.block = block;
        self.tapEnabled = NO;
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 15;
        
        // label
        [self p_addTitleLabelWithAttributedText:attributedText];
        
        self.height = 2*self.titleLabel.y + self.titleLabel.height + TIP_BUTTON_HTIGHT;
        self.y = ([UIScreen mainScreen].bounds.size.height-self.height)*0.5;
        
        // buttons
        [self p_addBottomButtons:buttonTitles];
    }
    return self;
}

- (void)p_addTitleLabelWithAttributedText:(NSAttributedString *)attributedText{
    
    UILabel *titleLabel = [[UILabel alloc] init];
    
    titleLabel.numberOfLines = 0;
    
    // 文本内容
    titleLabel.attributedText = attributedText;

    // frame
    CGFloat tipLabelY = 20.0;
    titleLabel.x = 20.0;
    titleLabel.width = self.width-titleLabel.x*2;
    titleLabel.height = [titleLabel textRectForBounds:CGRectMake(0, 0, titleLabel.width, FLT_MAX) limitedToNumberOfLines:0].size.height;
    titleLabel.y = titleLabel.height < 30 ? tipLabelY + 2.5 : tipLabelY;

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
            lineView.backgroundColor = WWZ_TIPVIEW_LINE_COLOR;
            [self addSubview:lineView];
        }
    }
}

- (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title tag:(int)tag{
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    btn.frame = frame;
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn setBackgroundImage:[self imageWithColor:WWZ_TIPVIEW_LINE_COLOR size:frame.size alpha:1] forState:UIControlStateHighlighted];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    btn.tag = BUTTON_TAG+tag;
    
    [btn addTarget:self action:@selector(clickButtonAtIndex:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, 0.5)];
    lineView.backgroundColor = WWZ_TIPVIEW_LINE_COLOR;
    [btn addSubview:lineView];
    
    return btn;
}

- (void)clickButtonAtIndex:(UIButton *)sender{

    if (_block) {
        _block((int)sender.tag - BUTTON_TAG);
    }
    [self wwz_dismissCompletion:nil];
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

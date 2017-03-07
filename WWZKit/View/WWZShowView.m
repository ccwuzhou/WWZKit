//
//  BCShowView.m
//  wwz
//
//  Created by wwz on 16/8/9.
//  Copyright © 2016年 cn.szwwz. All rights reserved.
//

#import "WWZShowView.h"

static NSTimeInterval kAnimationDuration = 0.3;


@interface WWZShowView ()

@property (nonatomic, assign) WWZShowViewType showType;

@end

@implementation WWZShowView

- (instancetype)initWithFrame:(CGRect)frame showType:(WWZShowViewType)showType
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        self.showType = showType;
        self.tapEnabled = YES;
    }
    return self;
}

#pragma mark - 显示

- (void)wwz_showCompletion:(void (^)(BOOL finished))completion{
    
    // 背景view
    UIButton *containButton = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
    containButton.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    
    if (self.isTapEnabled) {
        [containButton addTarget:self action:@selector(wwz_dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [containButton addSubview:self];
    
    // 添加到window上
    [[UIApplication sharedApplication].keyWindow addSubview:containButton];
    
    containButton.alpha = 0;
    
    [self p_originalTransform:self.showType];
    
    [UIView animateWithDuration:kAnimationDuration
                     animations:^{
                         
                         [self p_endTransform:self.showType];
                     }
                     completion:completion];
    
}


#pragma mark - 隐藏

- (void)wwz_dismiss{

    [UIView animateWithDuration:kAnimationDuration
                     animations:^{
                         
                         [self p_originalTransform:self.showType];
                     }
                     completion:^(BOOL finished) {
                         
                         [self.superview removeFromSuperview];
                         [self removeFromSuperview];

                     }];
}

#pragma mark - 私有方法
- (void)p_originalTransform:(WWZShowViewType)showType{

    self.superview.alpha = 0.0;
    
    switch (showType) {
        case WWZShowViewTypeNone:
            self.alpha = 0.0;
            break;
        case WWZShowViewTypeTop:
            self.transform = CGAffineTransformMakeTranslation(0, -self.frame.size.height);
            break;
        case WWZShowViewTypeLeft:
            self.transform = CGAffineTransformMakeTranslation(-self.frame.size.width, 0);
            break;
        case WWZShowViewTypeBottom:
            self.transform = CGAffineTransformMakeTranslation(0, self.superview.frame.size.height);
            break;
        case WWZShowViewTypeRight:
            self.transform = CGAffineTransformMakeTranslation(self.superview.frame.size.width, 0);
            break;
        default:
            break;
    }
}

- (void)p_endTransform:(WWZShowViewType)showType{
    
    self.superview.alpha = 1.0;
    
    switch (showType) {
        case WWZShowViewTypeNone:
            self.alpha = 1.0;
            break;
        default:
            self.transform = CGAffineTransformIdentity;
            break;
    }
}
- (void)dealloc{
    NSLog(@"%s", __func__);
}

@end

//
//  BCShowView.m
//  wwz
//
//  Created by wwz on 16/8/9.
//  Copyright © 2016年 cn.szwwz. All rights reserved.
//

#import "WWZShowView.h"

@implementation WWZShowView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self p_initSetup];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self p_initSetup];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self p_initSetup];
    }
    return self;
}

- (void)p_initSetup{

    self.backgroundColor = [UIColor whiteColor];
    self.animateType = WWZShowViewAnimateTypeAlpha;
    self.tapEnabled = YES;
    self.backColor = [UIColor colorWithWhite:0 alpha:0.1];
    self.animateDuration = 0.3;
}

#pragma mark - 显示

- (void)wwz_showCompletion:(void (^)(BOOL finished))completion{
    
    // 背景view
    UIButton *containButton = [[UIButton alloc] initWithFrame:[UIScreen mainScreen].bounds];
    containButton.backgroundColor = self.backColor;
    
    if (self.isTapEnabled) {
        [containButton addTarget:self action:@selector(wwz_dismiss) forControlEvents:UIControlEventTouchUpInside];
    }
    
    [containButton addSubview:self];
    
    // 添加到window上
    [[UIApplication sharedApplication].keyWindow addSubview:containButton];
    
    containButton.alpha = 0;
    
    [self p_originalTransform:self.animateType];
    
    [UIView animateWithDuration:self.animateDuration
                     animations:^{
                         
                         [self p_endTransform:self.animateType];
                     }
                     completion:completion];
    
}


#pragma mark - 隐藏

- (void)wwz_dismissCompletion:(void (^)(BOOL finished))completion{

    [UIView animateWithDuration:self.animateDuration
                     animations:^{
                         
                         [self p_originalTransform:self.animateType];
                     }
                     completion:^(BOOL finished) {
                         
                         [self.superview removeFromSuperview];
                         [self removeFromSuperview];
                         
                         if (completion) {
                             completion(finished);
                         }
                     }];
}

#pragma mark - 私有方法
- (void)p_originalTransform:(WWZShowViewAnimateType)animateType{

    self.superview.alpha = 0.0;
    
    switch (animateType) {
        case WWZShowViewAnimateTypeAlpha:
            self.alpha = 0.0;
            break;
        case WWZShowViewAnimateTypeFromTop:
            self.transform = CGAffineTransformMakeTranslation(0, -self.frame.size.height);
            break;
        case WWZShowViewAnimateTypeFromLeft:
            self.transform = CGAffineTransformMakeTranslation(-self.frame.size.width, 0);
            break;
        case WWZShowViewAnimateTypeFromBottom:
            self.transform = CGAffineTransformMakeTranslation(0, self.superview.frame.size.height);
            break;
        case WWZShowViewAnimateTypeFromRight:
            self.transform = CGAffineTransformMakeTranslation(self.superview.frame.size.width, 0);
            break;
        default:
            break;
    }
}

- (void)p_endTransform:(WWZShowViewAnimateType)animateType{
    
    self.superview.alpha = 1.0;
    
    switch (animateType) {
        case WWZShowViewAnimateTypeAlpha:
            self.alpha = 1.0;
            break;
        default:
            self.transform = CGAffineTransformIdentity;
            break;
    }
}
//- (void)dealloc{
//    NSLog(@"%s", __func__);
//}

@end

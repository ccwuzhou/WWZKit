//
//  UIVisualEffectView+WWZ.m
//  WWZKit
//
//  Created by wwz on 17/3/8.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import "UIVisualEffectView+WWZ.h"

@implementation UIVisualEffectView (WWZ)


/**
 *  毛玻璃效果视图对象
 */
+ (instancetype)wwz_defaultBlurEffectViewWithFrame:(CGRect)frame{
    
    return [self wwz_blurEffectViewWithFrame:frame alpha:0.9];
}
/**
 *  毛玻璃效果视图对象
 */
+ (instancetype)wwz_blurEffectViewWithFrame:(CGRect)frame alpha:(CGFloat)alpha{
    
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView *blurEffectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    blurEffectView.alpha = alpha;
    blurEffectView.frame = frame;
    return blurEffectView;
}

@end

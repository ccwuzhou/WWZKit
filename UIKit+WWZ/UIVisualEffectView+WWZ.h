//
//  UIVisualEffectView+WWZ.h
//  WWZKit
//
//  Created by wwz on 17/3/8.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIVisualEffectView (WWZ)

/**
 *  默认毛玻璃效果视图
 */
+ (instancetype)wwz_defaultBlurEffectViewWithFrame:(CGRect)frame;

/**
 *  毛玻璃效果视图
 */
+ (instancetype)wwz_blurEffectViewWithFrame:(CGRect)frame alpha:(CGFloat)alpha;

@end

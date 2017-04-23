//
//  UINavigationBar+WWZ.h
//  WWZKit
//
//  Created by wwz on 17/3/7.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationBar (WWZ)

/**
 *  设置标题
 */
- (void)wwz_setTitleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont;

/**
 *  设置背景颜色
 */
- (void)wwz_setBackgroundColor:(UIColor *)color;

/**
 *  是否隐藏下面线
 */
- (void)wwz_setShadowImage:(BOOL)isHidden;

/**
 *  还原，viewWillDisAppear调用
 */
- (void)wwz_reset;

/**
 *  设置tabbar内所有视图的alpha
 */
- (void)wwz_setElementAlpha:(CGFloat)alpha;

@end

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
 *  设置背景颜色
 */
- (void)wwz_setBackgroundColor:(UIColor *)color;

/**
 *  设置文本颜色和字体
 */
- (void)wwz_setTitleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont;

/**
 *  去除导航栏下黑线
 */
- (void)wwz_noShadowImage;

@end

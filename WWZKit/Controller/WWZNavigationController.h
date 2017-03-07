//
//  WWZNavigationController.h
//  wwz
//
//  Created by wwz on 16/8/4.
//  Copyright © 2016年 cn.szwwz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WWZNavigationController : UINavigationController

/**
 *  设置导航栏相关属性
 *
 *  @param backgroundColor 背景颜色
 *  @param titleFont       标题字体大小
 *  @param titleColor      标题颜色
 *  @param tintColor       tintColor
 *  @param itemFont        UIBarButtonItem 字体大小
 */
- (void)wwz_setBackgroundColor:(UIColor *)backgroundColor
                     titleFont:(UIFont *)titleFont
                    titleColor:(UIColor *)titleColor
                     tintColor:(UIColor *)tintColor
                      itemFont:(UIFont *)itemFont;

@end

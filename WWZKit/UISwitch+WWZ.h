//
//  UISwitch+WWZ.h
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISwitch (WWZ)
/**
 *  system switch
 */
+ (UISwitch *)wwz_defaultSwitch;

/**
 *  custom switch
 */
+ (UISwitch *)wwz_switchWithOnTintColor:(UIColor *)onTintColor tintColor:(UIColor *)tintColor thumbTintColor:(UIColor *)thumbTintColor;

/**
 *  方法
 */
- (void)wwz_setTarget:(id)target action:(SEL)action;
@end

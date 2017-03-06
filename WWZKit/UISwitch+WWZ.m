//
//  UISwitch+WWZ.m
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import "UISwitch+WWZ.h"

@implementation UISwitch (WWZ)
/**
 *  system switch
 */
+ (UISwitch *)wwz_defaultSwitch{
    
    return [self wwz_switchWithOnTintColor:nil tintColor:nil thumbTintColor:nil];
}

/**
 *  custom switch
 */
+ (UISwitch *)wwz_switchWithOnTintColor:(UIColor *)onTintColor tintColor:(UIColor *)tintColor thumbTintColor:(UIColor *)thumbTintColor{
    
    UISwitch *switchOn = [[UISwitch alloc] init];
    
    if (onTintColor) {
        switchOn.onTintColor = onTintColor;
    }
    if (tintColor) {
        switchOn.tintColor = tintColor;
    }
    if (thumbTintColor) {
        switchOn.thumbTintColor = thumbTintColor;
    }
    
    return switchOn;
}

/**
 *  方法
 */
- (void)wwz_setTarget:(id)target action:(SEL)action{
    [self addTarget:target action:action forControlEvents:UIControlEventValueChanged];
}
@end

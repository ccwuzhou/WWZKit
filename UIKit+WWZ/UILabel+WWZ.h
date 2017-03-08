//
//  UILabel+WWZ.h
//  WWZKit
//
//  Created by wwz on 17/3/7.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (WWZ)

/**
 *  自适应尺寸的label
 */
+ (UILabel *)wwz_labelWithText:(NSString *)text font:(UIFont *)font tColor:(UIColor *)tColor alignment:(NSTextAlignment)alignment numberOfLines:(NSInteger)numberOfLines;

/**
 *  给定frame的label
 */
+ (UILabel *)wwz_labelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font tColor:(UIColor *)tColor alignment:(NSTextAlignment)alignment numberOfLines:(NSInteger)numberOfLines;

@end

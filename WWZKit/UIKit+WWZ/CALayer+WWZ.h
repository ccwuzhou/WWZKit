//
//  CALayer+WWZ.h
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>
@interface CALayer (WWZ)

/**
 *  设置圆角半径
 */
- (void)wwz_setCornerRadius:(CGFloat)radius;
/**
 *  设置圆形描边
 */
- (void)wwz_setMasksBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
/**
 *  设置描边
 */
- (void)wwz_setCornerRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;

/**
 *  设置阴影
 */
- (void)wwz_setShadowWithColor:(UIColor *)shadowColor offset:(CGSize)offset;
- (void)wwz_setShadowOffsetY:(CGFloat)offsetY;


/**
 *  暂停动画
 */
- (void)wwz_pauseAnimation;
/**
 *  恢复动画
 */
- (void)wwz_resumeAnimation;
@end

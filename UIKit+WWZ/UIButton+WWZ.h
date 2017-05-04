//
//  UIButton+WWZ.h
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (WWZ)
/**
 *  设置title
 */
- (void)wwz_setNTitle:(NSString *)nTitle;
- (void)wwz_setSTitle:(NSString *)sTitle;
- (void)wwz_setNTitle:(NSString *)nTitle sTitle:(NSString *)sTitle;

/**
 *  设置title color
 */
- (void)wwz_setNColor:(UIColor *)nColor;
- (void)wwz_setSColor:(UIColor *)sColor;
- (void)wwz_setNColor:(UIColor *)nColor hColor:(UIColor *)hColor;
- (void)wwz_setNColor:(UIColor *)nColor sColor:(UIColor *)sColor;
- (void)wwz_setNColor:(UIColor *)nColor hColor:(UIColor *)hColor sColor:(UIColor *)sColor;

/**
 *  设置image
 */
- (void)wwz_setNImage:(NSString *)nImage;
- (void)wwz_setSImage:(NSString *)sImage;
- (void)wwz_setNImage:(NSString *)nImage hImage:(NSString *)hImage;
- (void)wwz_setNImage:(NSString *)nImage sImage:(NSString *)sImage;
- (void)wwz_setNImage:(NSString *)nImage hImage:(NSString *)hImage sImage:(NSString *)sImage;

/**
 *  设置背景image
 */
- (void)wwz_setNBImage:(NSString *)nBImage;
- (void)wwz_setHBImage:(NSString *)hBImage;
- (void)wwz_setNBImage:(NSString *)nBImage hBImage:(NSString *)hBImage;
- (void)wwz_setNBImage:(NSString *)nBImage sBImage:(NSString *)sBImage;
- (void)wwz_setNBImage:(NSString *)nBImage hBImage:(NSString *)hBImage sBImage:(NSString *)sBImage;
/**
 *  文字（正常）
 */
+ (instancetype)wwz_buttonWithFrame:(CGRect)frame nTitle:(NSString *)nTitle nColor:(UIColor *)nColor tFont:(UIFont *)tFont;
/**
 *  文字（正常和选中）
 */
+ (instancetype)wwz_buttonWithFrame:(CGRect)frame nTitle:(NSString *)nTitle sTitle:(NSString *)sTitle tFont:(UIFont *)tFont nColor:(UIColor *)nColor sColor:(UIColor *)sColor;

/**
 *  只含图片（button大小与图片大小一样）
 */
+ (instancetype)wwz_buttonWithNImage:(NSString *)nImage sImage:(NSString *)sImage;
/**
 *  只含图片（button大小与图片大小一样）
 */
+ (instancetype)wwz_buttonWithNImage:(NSString *)nImage hImage:(NSString *)hImage sImage:(NSString *)sImage;
/**
 *  只含图片（指定button frame）
 */
+ (instancetype)wwz_buttonWithFrame:(CGRect)frame nImage:(NSString *)nImage hImage:(NSString *)hImage sImage:(NSString *)sImage;
/**
 *  文字和图片（正常）
 */
+ (instancetype)wwz_buttonWithFrame:(CGRect)frame nTitle:(NSString *)nTitle tFont:(UIFont *)tFont nColor:(UIColor *)nColor nImage:(NSString *)nImage;
/**
 *  文字和图片（正常和选中）
 */
+ (instancetype)wwz_buttonWithFrame:(CGRect)frame nTitle:(NSString *)nTitle sTitle:(NSString *)sTitle tFont:(UIFont *)tFont nColor:(UIColor *)nColor sColor:(UIColor *)sColor nImage:(NSString *)nImage sImage:(NSString *)sImage;

/**
 *  设置字体大小
 */
-(void)wwz_setTitleFont:(UIFont *)titleFont;

/**
 *  设置image与title间距
 */
- (void)wwz_setLeftRightInset:(CGFloat)inset;

/**
 *  button 方法
 */
- (void)wwz_setTarget:(id)target action:(SEL)action;
@end

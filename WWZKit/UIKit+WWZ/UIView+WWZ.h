//
//  UIView+WWZ.h
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import <UIKit/UIKit.h>

#pragma mark - 手势
@interface UIView (GestureRecognizer)

/**
 *  tap
 */
- (void)wwz_tapPeformBlock:(void(^)())block;

/**
 *  swipe
 */
- (void)wwz_swipeDirection:(UISwipeGestureRecognizerDirection)direction peformBlock:(void(^)(UISwipeGestureRecognizer *swipe))block;
/**
 *  longPress
 */
- (void)wwz_longPressPeformBlock:(void(^)(UILongPressGestureRecognizer *longPress))block;
/**
 *  pan
 */
- (void)wwz_panPeformBlock:(void(^)(UIPanGestureRecognizer *pan))block;

#pragma mark - launch image

/**
 *  获取启动图片并保持
 *
 *  @param duration duration后启动图片消失
 *
 *  @return 启动图片
 */
+ (UIImageView *)wwz_launchImageAnimateWithDuration:(NSTimeInterval)duration;
/**
 *  启动图片消失动画
 *
 *  @param launchView 启动图片
 */
+ (void)wwz_dismissLaunchImageView:(UIView *)launchView;
@end


@interface UITableView (WWZ)

+ (instancetype)wwz_tableViewWithFrame:(CGRect)frame dataSource:(id <UITableViewDataSource>)dataSource delegate:(id <UITableViewDelegate>)delegate;

@end

@interface UIScrollView (WWZ)

+ (UIScrollView *)wwz_scrollViewWithFrame:(CGRect)frame contentSize:(CGSize)contentSize;

@end


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

@interface UIImageView (WWZ)

+ (instancetype)wwz_imageViewWithImageName:(NSString *)imageName contentMode:(UIViewContentMode)contentMode;

+ (instancetype)wwz_imageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName contentMode:(UIViewContentMode)contentMode;

/**
 *  圆形imageView
 *
 *  @param frame       frame
 *  @param imageName   imageName
 *  @param borderWidth borderWidth
 *  @param borderColor borderColor
 *
 *  @return 圆形imageView
 */
+ (instancetype)wwz_imageViewWithFrame:(CGRect)frame
                             imageName:(NSString *)imageName
                           borderWidth:(CGFloat)borderWidth
                           borderColor:(UIColor *)borderColor;
@end

@interface UILabel (WWZ)

/**
 *  自适应尺寸的label
 */
+ (UILabel *)wwz_labelWithText:(NSString *)text font:(UIFont *)font tColor:(UIColor *)tColor alignment:(NSTextAlignment)alignment numberOfLines:(NSInteger)numberOfLines;

/**
 *  给定frame的一行label
 */
+ (UILabel *)wwz_labelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font tColor:(UIColor *)tColor alignment:(NSTextAlignment)alignment;

/**
 *  给定frame的label
 */
+ (UILabel *)wwz_labelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font tColor:(UIColor *)tColor alignment:(NSTextAlignment)alignment numberOfLines:(NSInteger)numberOfLines;

/**
 *  自适应
 */
- (void)wwz_sizeToFitWithMaxSize:(CGSize)maxSize;

@end

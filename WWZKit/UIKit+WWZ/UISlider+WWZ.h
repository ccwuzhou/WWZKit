//
//  UISlider+WWZ.h
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UISlider (WWZ)
/**
 *  自定义slider，实现左右切片(传图片名)
 */
+ (UISlider *)wwz_sliderWithFrame:(CGRect)frame minImageName:(NSString *)minImageName maxImageName:(NSString *)maxImageName thumbImageName:(NSString *)thumbImageName;

/**
 *  自定义slider，实现左右切片(传图片)
 */
+ (UISlider *)wwz_sliderWithFrame:(CGRect)frame minTrackImage:(UIImage *)minTrackImage maxTrackImage:(UIImage *)maxTrackImage thumbImage:(UIImage *)thumbImage;

/**
 *  滑动结束事件
 */
- (void)wwz_setEndTarget:(id)target action:(SEL)action;

/**
 *  滑动改变事件
 */
- (void)wwz_setChangeTarget:(id)target action:(SEL)action;

@end

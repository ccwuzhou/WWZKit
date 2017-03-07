//
//  UISlider+WWZ.m
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import "UISlider+WWZ.h"

@implementation UISlider (WWZ)
/**
 *  自定义slider，实现左右切片
 */
+ (UISlider *)wwz_sliderWithFrame:(CGRect)frame minImageName:(NSString *)minImageName maxImageName:(NSString *)maxImageName thumbImageName:(NSString *)thumbImageName{
    
    return [self wwz_sliderWithFrame:frame minTrackImage:[UIImage imageNamed:minImageName] maxTrackImage:[UIImage imageNamed:maxImageName] thumbImage:[UIImage imageNamed:thumbImageName]];
}
/**
 *  自定义slider，实现左右切片
 */
+ (UISlider *)wwz_sliderWithFrame:(CGRect)frame minTrackImage:(UIImage *)minTrackImage maxTrackImage:(UIImage *)maxTrackImage thumbImage:(UIImage *)thumbImage{
    
    UISlider *slider = [[UISlider alloc] initWithFrame:frame];
    
    // 左边图片
    if (minTrackImage) {
        [slider setMinimumTrackImage:[self stretchImageWithImage:minTrackImage] forState:UIControlStateNormal];
    }
    
    // 右边图片
    if (maxTrackImage) {
        [slider setMaximumTrackImage:[self stretchImageWithImage:maxTrackImage] forState:UIControlStateNormal];
    }
    
    // 圆
    if (thumbImage) {
        [slider setThumbImage:thumbImage forState:UIControlStateNormal];
    }
    
    return slider;
    
}
+ (UIImage *)stretchImageWithImage:(UIImage *)image
{
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(0, image.size.width * 0.5, 0, image.size.width * 0.5) resizingMode:UIImageResizingModeStretch];
}
/**
 *  添加滑动结束事件
 */
- (void)wwz_setEndTarget:(id)target action:(SEL)action{
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [self addTarget:target action:action forControlEvents:UIControlEventTouchUpOutside];
    [self addTarget:target action:action forControlEvents:UIControlEventTouchCancel];
}
/**
 *  添加滑动改变事件
 */
- (void)wwz_setChangeTarget:(id)target action:(SEL)action{
    [self addTarget:target action:action forControlEvents:UIControlEventValueChanged];
}
@end

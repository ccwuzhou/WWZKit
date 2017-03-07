//
//  UIImageView+WWZ.h
//  WWZKit
//
//  Created by wwz on 17/3/7.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import <UIKit/UIKit.h>

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

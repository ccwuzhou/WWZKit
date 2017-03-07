//
//  UIImageView+WWZ.m
//  WWZKit
//
//  Created by wwz on 17/3/7.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import "UIImageView+WWZ.h"

@implementation UIImageView (WWZ)


+ (instancetype)wwz_imageViewWithImageName:(NSString *)imageName contentMode:(UIViewContentMode)contentMode{
    
    return [self wwz_imageViewWithFrame:CGRectZero imageName:imageName contentMode:contentMode];
    
}


+ (instancetype)wwz_imageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName contentMode:(UIViewContentMode)contentMode{
    
    UIImageView *imageView = [[self alloc] initWithImage:[UIImage imageNamed:imageName]];
    
    if (!CGRectEqualToRect(frame, CGRectZero)) {
        imageView.frame = frame;
    }
    imageView.contentMode = contentMode;
    
    return imageView;
}

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
+ (instancetype)wwz_imageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    UIImageView *imageView = [self wwz_imageViewWithFrame:frame imageName:imageName contentMode:UIViewContentModeScaleAspectFit];
    
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = MIN(imageView.frame.size.width, imageView.frame.size.height)*0.5;
    imageView.layer.borderWidth = borderWidth;
    imageView.layer.borderColor = borderColor.CGColor;
    
    
    return imageView;
}
@end

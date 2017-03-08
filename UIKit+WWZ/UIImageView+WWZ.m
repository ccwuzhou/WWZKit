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


#pragma mark - launch image

/**
 *  获取启动图片并保持
 *
 *  @param duration duration后启动图片消失
 *
 *  @return 启动图片
 */
+ (UIImageView *)wwz_launchImageAnimateWithDuration:(NSTimeInterval)duration{
    
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    
    NSString *viewOrientation = @"Portrait";    //横屏请设置成 @"Landscape"
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        viewOrientation = @"Landscape";
        viewSize = CGSizeMake(viewSize.height, viewSize.width);
    }
    NSString *launchImage = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    
    for (NSDictionary* dict in imagesDict){
        
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]){
            
            launchImage = dict[@"UILaunchImageName"];
        }
    }
    UIImageView *launchView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:launchImage]];
    launchView.frame = [UIScreen mainScreen].bounds;
    launchView.contentMode = UIViewContentModeScaleAspectFill;
    [[UIApplication sharedApplication].keyWindow addSubview:launchView];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self wwz_dismissLaunchImageView:launchView];
    });
    return launchView;
}

/**
 *  启动图片消失动画
 *
 *  @param launchView 启动图片
 */
+ (void)wwz_dismissLaunchImageView:(UIView *)launchView{
    
    [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        launchView.alpha = 0.0f;
        launchView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.2, 1.2, 1);
        
    } completion:^(BOOL finished) {
        
        [launchView removeFromSuperview];
    }];
    
}
@end

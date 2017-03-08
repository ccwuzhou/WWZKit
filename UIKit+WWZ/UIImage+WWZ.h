//
//  UIImage+WWZ.h
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (WWZ)
/**
 *  bundle 中的图片
 *
 *  @param imageName imageName
 *
 *  @return UIImage
 */
+ (instancetype)wwz_imageWithContentImageName:(NSString *)imageName;
/**
 * 根据指定图片的文件名获取一张圆型的图片对象,并加边框
 * @paran imageName 图片名称
 * @param borderWidth 边框的宽
 * @param borderColor 边框的颜色
 * @return 切好的圆型图片
 */
+ (instancetype)wwz_circleImageWithImageName:(NSString *)imageName borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor;
/**
 *  虚线图片
 *
 *  @param size      图片size
 *  @param lineColor 线颜色
 *
 *  @return dash image
 */
+ (instancetype)wwz_dashImageWithSize:(CGSize)size lineColor:(UIColor *)lineColor;
/**
 *  图片按比例压缩到指定大小
 *
 *  @param targetSize 指定大小
 *
 *  @return UIImage
 */
- (UIImage *)wwz_scaleToTargetSize:(CGSize)targetSize;
/**
 *  启动图片
 */
+ (UIImage *)wwz_launchImageWithOrientation:(UIInterfaceOrientation)orientation;

#pragma mark - 九切片

+ (instancetype)wwz_stretchImageWithImageName:(NSString *)imageName;
+ (instancetype)wwz_tileImageWithImageName:(NSString *)imageName;

+ (instancetype)wwz_stretchLeftRightWithImageName:(NSString *)imageName;
+ (instancetype)wwz_stretchUpDownWithImageName:(NSString *)imageName;

+ (instancetype)wwz_tileLeftRightWithImageName:(NSString *)imageName;
+ (instancetype)wwz_tileUpDownWithImageName:(NSString *)imageName;

- (instancetype)wwz_stretchImageWithCapInsets:(UIEdgeInsets)capInsets;
- (instancetype)wwz_tileImageWithCapInsets:(UIEdgeInsets)capInsets;


#pragma mark - 图片不透明区渲染

- (instancetype)wwz_imageMaskWithColor:(UIColor *)maskColor;

/**
 *  得到按比例适应图片的rect
 */
- (CGRect)wwz_aspectFitRectForSize:(CGSize)size;

#pragma mark - 得到图片尺寸

+ (CGSize)wwz_imageSizeWithImageName:(NSString *)imageName;

#pragma mark - 背景转换成图片

+ (instancetype)wwz_backgroundGradientImageWithSize:(CGSize)size;

/**
 *  UIColor ==> UIImage
 *
 *  @param color color
 *  @param size  size
 *  @param alpha alpha
 *
 *  @return UIImage
 */
+ (instancetype)wwz_imageWithColor:(UIColor *)color size:(CGSize)size alpha:(float)alpha;

/**
 *  压缩图片到指定文件大小byte
 *
 *  @param maxFileSize 指定大小
 *
 *  @return image
 */
- (UIImage *)wwz_compressedImageToMaxFileSize:(NSInteger)maxFileSize;

/**
 *  压缩图片到指定文件大小byte
 *
 *  @param maxFileSize 指定大小
 *
 *  @return image data
 */
- (NSData *)wwz_compressedDataToMaxFileSize:(NSInteger)maxFileSize;

#pragma mark - 图片扩展名
/**
 *  通过图片Data数据第一个字节 来获取图片扩展名
 *
 *  @param data image data
 *
 *  @return image type
 */
+ (NSString *)wwz_contentTypeForImageData:(NSData *)data;

/**
 *  由二维码生成图片
 */
+ (UIImage *)wwz_imageWithQRCode:(NSString *)qrcode size:(CGSize)size;
/**
 *  从图片中获取url
 */
+ (NSString *)wwz_imageMessageString:(UIImage *)image;
@end

@interface UIImage (Blur)

/**
 *  图片模糊
 */
- (UIImage *)wwz_blurredImage;

/**
 *  blurred image
 *
 *  @param radius     半径:默认30,推荐值 3   半径值越大越模糊 ,值越小越清楚
 *  @param iterations 色彩饱和度(浓度)因子:  0是黑白灰, 9是浓彩色, 1是原色  默认1.8
 “彩度”，英文是称Saturation，即饱和度。将无彩色的黑白灰定为0，最鲜艳定为9s，这样大致分成十阶段，让数值和人的感官直觉一致。
 *  @param tintColor  白色参数
 *
 *  @return blurred image
 */
- (UIImage *)wwz_blurredImageWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations whiteValue:(CGFloat)whiteValue;

@end

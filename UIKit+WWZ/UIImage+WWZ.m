//
//  UIImage+WWZ.m
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import "UIImage+WWZ.h"

#import <Accelerate/Accelerate.h>

@implementation UIImage (WWZ)

+ (instancetype)wwz_imageWithContentImageName:(NSString *)imageName{
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
    
    return [[UIImage alloc] initWithContentsOfFile:filePath];
}

+ (instancetype)wwz_circleImageWithImageName:(NSString *)imageName borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    // 获取要裁剪的图片
    UIImage *image = [UIImage imageNamed:imageName];
    
    //1. 开启图片上下文
    CGFloat imageWidth = image.size.width + 2 * borderWidth;
    CGFloat imageHeigh = image.size.height + 2 * borderWidth;
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageWidth, imageHeigh), NO, 0.0);
    //2. 获取上下文
    UIGraphicsGetCurrentContext();
    //3. 画圆
    CGFloat radius = MIN(image.size.width * 0.5, image.size.height * 0.5);
    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:CGPointMake(imageWidth * 0.5, imageHeigh * 0.5) radius:radius startAngle:0 endAngle:M_PI * 2 clockwise:YES];
    bezierPath.lineWidth = borderWidth;
    [borderColor setStroke];
    [bezierPath stroke];
    //4. 使用BezierPath进行剪切
    [bezierPath addClip];
    //5. 画图
    [image drawInRect:CGRectMake(borderWidth, borderWidth, image.size.width, image.size.height)];
    //6. 从内存中创建新图片对象
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    //7. 结束图片上下文
    UIGraphicsEndImageContext();
    return newImage;
}
/**
 *  虚线图片
 *
 *  @param size      图片size
 *  @param lineColor 线颜色
 *
 *  @return dash image
 */
+ (instancetype)wwz_dashImageWithSize:(CGSize)size lineColor:(UIColor *)lineColor{
    
    // 使用位图上下文
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    
    CGContextRef bitmapContext =  UIGraphicsGetCurrentContext();
    
    // 设置虚线每一段距离长度
    CGFloat lengths[2] = {10,5};
    // 设置颜色
    [lineColor set];
    // 设置线宽
    CGContextSetLineWidth(bitmapContext, size.height);
    // 设置虚线
    CGContextSetLineDash(bitmapContext, 0, lengths, 2);
    
    CGPoint points[2] = {{0,0},{size.width,0}};
    CGContextAddLines(bitmapContext, points, 2);
    
    CGContextStrokePath(bitmapContext);
    // 获取背景图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    // 结束编辑
    UIGraphicsEndImageContext();
    
    return newImage;
}
/**
 *  启动图片
 */
+ (UIImage *)wwz_launchImageWithOrientation:(UIInterfaceOrientation)orientation{

    CGSize viewSize = CGSizeZero;
    
    NSString *viewOrientation = @"";
    
    switch (orientation) {
        case UIInterfaceOrientationPortrait:
        case UIInterfaceOrientationPortraitUpsideDown:{
        
            viewSize = [UIScreen mainScreen].bounds.size;
            
            viewOrientation = @"Portrait";
        }
            break;
        case UIInterfaceOrientationLandscapeLeft:
        case UIInterfaceOrientationLandscapeRight:{
        
            viewSize = CGSizeMake([UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width);
            
            viewOrientation = @"Landscape";
        }
            break;
        default:
            break;
    }

    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    
    for (NSDictionary* dict in imagesDict){
        
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]){

            return [UIImage imageNamed:dict[@"UILaunchImageName"]];
        }
    }
    return nil;
}
#pragma mark - 九切片
+ (instancetype)wwz_stretchImageWithImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image wwz_stretchImageWithCapInsets:UIEdgeInsetsMake(image.size.height * 0.5, image.size.width * 0.5, image.size.height * 0.5, image.size.width * 0.5)];
}
+ (instancetype)wwz_tileImageWithImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image wwz_tileImageWithCapInsets:UIEdgeInsetsMake(image.size.height * 0.5, image.size.width * 0.5, image.size.height * 0.5, image.size.width * 0.5)];
}

#pragma mark -
+ (instancetype)wwz_stretchLeftRightWithImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image wwz_stretchImageWithCapInsets:UIEdgeInsetsMake(0, image.size.width * 0.5, 0, image.size.width * 0.5)];
}
+ (instancetype)wwz_stretchUpDownWithImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image wwz_stretchImageWithCapInsets:UIEdgeInsetsMake(image.size.height * 0.5, 0, image.size.height * 0.5, 0)];
}
+ (instancetype)wwz_tileLeftRightWithImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image wwz_tileImageWithCapInsets:UIEdgeInsetsMake(0, image.size.width * 0.5, 0, image.size.width * 0.5)];
}
+ (instancetype)wwz_tileUpDownWithImageName:(NSString *)imageName
{
    UIImage *image = [UIImage imageNamed:imageName];
    return [image wwz_tileImageWithCapInsets:UIEdgeInsetsMake(image.size.height * 0.5, 0, image.size.height * 0.5, 0)];
}

#pragma mark -
- (instancetype)wwz_stretchImageWithCapInsets:(UIEdgeInsets)capInsets
{
    return [self resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeStretch];
}
- (instancetype)wwz_tileImageWithCapInsets:(UIEdgeInsets)capInsets
{
    return [self resizableImageWithCapInsets:capInsets resizingMode:UIImageResizingModeTile];
}




#pragma mark - 图片不透明区渲染

- (instancetype)wwz_imageMaskWithColor:(UIColor *)maskColor {
    if (!maskColor) {
        return nil;
    }
    
    UIImage *newImage = nil;
    
    CGRect imageRect = (CGRect){CGPointZero,self.size};
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, self.scale);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextScaleCTM(context, 1.0, -1.0);
    CGContextTranslateCTM(context, 0.0, -(imageRect.size.height));
    
    CGContextClipToMask(context, imageRect, self.CGImage);//选中选区 获取不透明区域路径
    CGContextSetFillColorWithColor(context, maskColor.CGColor);//设置颜色
    CGContextFillRect(context, imageRect);//绘制
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();//提取图片
    
    UIGraphicsEndImageContext();
    return newImage;
}

/**
 *  得到按比例适应图片的rect
 */
- (CGRect)wwz_aspectFitRectForSize:(CGSize)size {
    
    CGFloat targetAspect = size.width / size.height;
    CGFloat sourceAspect = self.size.width / self.size.height;
    CGRect rect = CGRectZero;
    
    if (targetAspect > sourceAspect) {
        rect.size.height = size.height;
        rect.size.width = ceilf(rect.size.height * sourceAspect);
        rect.origin.x = ceilf((size.width - rect.size.width) * 0.5);
    }else {
        rect.size.width = size.width;
        rect.size.height = ceilf(rect.size.width / sourceAspect);
        rect.origin.y = ceilf((size.height - rect.size.height) * 0.5);
    }
    
    return rect;
}

#pragma mark - 得到图片尺寸

+ (CGSize)wwz_imageSizeWithImageName:(NSString *)imageName{
    
    return [UIImage imageNamed:imageName].size;
}

#pragma mark - 背景转换成图片

+ (instancetype)wwz_backgroundGradientImageWithSize:(CGSize)size
{
    CGPoint center = CGPointMake(size.width * 0.5, size.height * 0.5);
    CGFloat innerRadius = 0;
    CGFloat outerRadius = sqrtf(size.width * size.width + size.height * size.height) * 0.5;
    
    BOOL opaque = NO;
    UIGraphicsBeginImageContextWithOptions(size, opaque, [[UIScreen mainScreen] scale]);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    const size_t locationCount = 2;
    CGFloat locations[locationCount] = { 0.0, 1.0 };
    CGFloat components[locationCount * 4] = {
        0.0, 0.0, 0.0, 0.1, // More transparent black
        0.0, 0.0, 0.0, 0.7  // More opaque black
    };
    
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorspace, components, locations, locationCount);
    
    CGContextDrawRadialGradient(context, gradient, center, innerRadius, center, outerRadius, 0);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    CGColorSpaceRelease(colorspace);
    CGGradientRelease(gradient);
    
    return image;
}

/**
 *  UIColor ==> UIImage
 *
 *  @param color color
 *  @param size  size
 *  @param alpha alpha
 *
 *  @return UIImage
 */
+ (instancetype)wwz_imageWithColor:(UIColor *)color size:(CGSize)size alpha:(float)alpha{
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAlpha(context, alpha);
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}


/**
 *  图片按比例压缩到指定大小
 *
 *  @param targetSize 指定大小
 *
 *  @return UIImage
 */
- (UIImage *)wwz_scaleToTargetSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(targetSize); // this will crop
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

- (UIImage *)wwz_compressedImageToMaxFileSize:(NSInteger)maxFileSize{
    
    return [UIImage imageWithData:[self wwz_compressedDataToMaxFileSize:maxFileSize]];
}

- (NSData *)wwz_compressedDataToMaxFileSize:(NSInteger)maxFileSize{
    
    CGFloat compression = 0.9f;
    CGFloat maxCompression = 0.1f;
    
    NSData *imageData = UIImageJPEGRepresentation(self, compression);
    
    while ([imageData length] > maxFileSize && compression > maxCompression) {
        compression -= 0.1;
        imageData = UIImageJPEGRepresentation(self, compression);
    }
    return imageData;
}

#pragma mark - 图片扩展名
/**
 *  通过图片Data数据第一个字节 来获取图片扩展名
 *
 *  @param data image data
 *
 *  @return image type
 */
+ (NSString *)wwz_contentTypeForImageData:(NSData *)data{
    
    uint8_t c;
    
    [data getBytes:&c length:1];
    
    switch (c) {
        case 0xFF:
            return @"jpeg";
        case 0x89:
            return @"png";
        case 0x47:
            return @"gif";
        case 0x49:
        case 0x4D:
            return @"tiff";
        case 0x52:
            if ([data length] < 12) {
                return nil;
            }
            NSString *testString = [[NSString alloc] initWithData:[data subdataWithRange:NSMakeRange(0, 12)] encoding:NSASCIIStringEncoding];
            if ([testString hasPrefix:@"RIFF"] && [testString hasSuffix:@"WEBP"]) {
                return @"webp";
            }
            return nil;
    }
    return nil;
}
+ (UIImage *)wwz_imageWithQRCode:(NSString *)qrcode size:(CGSize)size{
    
    // 1、创建滤镜对象
    CIFilter *filter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    
    // 恢复滤镜的默认属性
    [filter setDefaults];
    
    // 将字符串转换成
    NSData *infoData = [qrcode dataUsingEncoding:NSUTF8StringEncoding];
    
    // 通过KVC设置滤镜inputMessage数据
    [filter setValue:infoData forKeyPath:@"inputMessage"];
    
    // 3、获得滤镜输出的图像
    CIImage *outputImage = [filter outputImage];
    
    // 4、将CIImage转换成UIImage，并放大显示
    return [UIImage wwz_imageWithCIImage:outputImage size:size];
    
}

/** 将CIImage转换成UIImage */
+ (UIImage *)wwz_imageWithCIImage:(CIImage *)ciimage size:(CGSize)size {
    
    CGRect extent = CGRectIntegral(ciimage.extent);
    CGFloat scale = MIN(size.width/CGRectGetWidth(extent), size.height/CGRectGetHeight(extent));
    
    // 1.创建bitmap;
    size_t width = CGRectGetWidth(extent) * scale;
    size_t height = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:ciimage fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    // 2.保存bitmap到图片
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    return [UIImage imageWithCGImage:scaledImage];
}

+ (NSString *)wwz_imageMessageString:(UIImage *)image{
    
    CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:@{CIDetectorAccuracy : CIDetectorAccuracyHigh}];
    
    // 取得识别结果
    NSArray *features = [detector featuresInImage:[CIImage imageWithCGImage:image.CGImage]];
    
    if (features.count>0) {
        
        CIQRCodeFeature *feature = features[0];
        return feature.messageString;
    }
    return @"";
}
@end



@implementation UIImage (Blur)

/**
 *  图片模糊
 */
- (UIImage *)wwz_blurredImage{
    
    return [self wwz_blurredImageWithRadius:30 iterations:5 whiteValue:0.11];
}

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
- (UIImage *)wwz_blurredImageWithRadius:(CGFloat)radius iterations:(NSUInteger)iterations whiteValue:(CGFloat)whiteValue{
    
    //image must be nonzero size
    if (floorf(self.size.width) * floorf(self.size.height) <= 0.0f) return self;
    
    //boxsize must be an odd integer
    uint32_t boxSize = (uint32_t)(radius * self.scale);
    
    if (boxSize % 2 == 0) boxSize ++;
    
    //create image buffers
    CGImageRef imageRef = self.CGImage;
    
    vImage_Buffer buffer1, buffer2;
    
    buffer1.width = buffer2.width = CGImageGetWidth(imageRef);
    
    buffer1.height = buffer2.height = CGImageGetHeight(imageRef);
    
    buffer1.rowBytes = buffer2.rowBytes = CGImageGetBytesPerRow(imageRef);
    
    size_t bytes = buffer1.rowBytes * buffer1.height;
    
    buffer1.data = malloc(bytes);
    
    buffer2.data = malloc(bytes);
    
    //create temp buffer
    
    void *tempBuffer = malloc((size_t)vImageBoxConvolve_ARGB8888(&buffer1, &buffer2, NULL, 0, 0, boxSize, boxSize,
                                                                 
                                                                 NULL, kvImageEdgeExtend + kvImageGetTempBufferSize));
    
    //copy image data
    
    CFDataRef dataSource = CGDataProviderCopyData(CGImageGetDataProvider(imageRef));
    memcpy(buffer1.data, CFDataGetBytePtr(dataSource), bytes);
    CFRelease(dataSource);
    
    for (NSUInteger i = 0; i < iterations; i++){
        
        //perform blur
        vImageBoxConvolve_ARGB8888(&buffer1, &buffer2, tempBuffer, 0, 0, boxSize, boxSize, NULL, kvImageEdgeExtend);
        
        //swap buffers
        void *temp = buffer1.data;
        
        buffer1.data = buffer2.data;
        
        buffer2.data = temp;
        
    }
    
    //free buffers
    free(buffer2.data);
    
    free(tempBuffer);
    
    //create image context from buffer
    CGContextRef ctx = CGBitmapContextCreate(buffer1.data, buffer1.width, buffer1.height,
                                             
                                             8, buffer1.rowBytes, CGImageGetColorSpace(imageRef),
                                             
                                             CGImageGetBitmapInfo(imageRef));
    
    //apply tint
    if (whiteValue > 0.0f) {
        
        CGContextSetFillColorWithColor(ctx, [UIColor colorWithWhite:whiteValue alpha:0.25].CGColor);
        
        CGContextSetBlendMode(ctx, kCGBlendModePlusLighter);
        
        CGContextFillRect(ctx, CGRectMake(0, 0, buffer1.width, buffer1.height));
        
    }
    
    //create image from context
    imageRef = CGBitmapContextCreateImage(ctx);
    
    UIImage *image = [UIImage imageWithCGImage:imageRef scale:self.scale orientation:self.imageOrientation];
    
    CGImageRelease(imageRef);
    
    CGContextRelease(ctx);
    
    free(buffer1.data);
    
    return image;
    
}

@end

//
//  UIColor+WWZ.m
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import "UIColor+WWZ.h"
#pragma mark - C 颜色

#define UNDEFINED 0

inline WZRGBType WZRGBTypeMake(float r, float g, float b){
    WZRGBType rgb = {r, g, b};
    return rgb;
}

inline WZHSVType WZHSVTypeMake(float h, float s, float v){
    WZHSVType hsv = {h, s, v};
    return hsv;
}

WZHSVType WZHSV_From_RGB(WZRGBType RGB){
    // RGB are each on [0, 1]. S and V are returned on [0, 1] and H is
    // returned on [0, 1]. Exception: H is returned UNDEFINED if S==0.
    float R = RGB.r, G = RGB.g, B = RGB.b, v, x, f;
    int i;
    
    x = fminf(R, G);
    x = fminf(x, B);
    
    v = fmaxf(R, G);
    v = fmaxf(v, B);
    
    if(v == x)
        return WZHSVTypeMake(UNDEFINED, 0, v);
    
    f = (R == x) ? G - B : ((G == x) ? B - R : R - G);
    i = (R == x) ? 3 : ((G == x) ? 5 : 1);
    
    return WZHSVTypeMake(((i - f /(v - x))/6), (v - x)/v, v);
}

WZRGBType WZRGB_From_HSV(WZHSVType HSV){
    // H is given on [0, 1] or UNDEFINED. S and V are given on [0, 1].
    // RGB are each returned on [0, 1].
    float h = HSV.h * 6, s = HSV.s, v = HSV.v, m, n, f;
    int i;
    
    if (h == 0) h=.01;
    if(h == UNDEFINED)
        return WZRGBTypeMake(v, v, v);
    i = floorf(h);
    f = h - i;
    if(!(i & 1)) f = 1 - f; // if i is even
    m = v * (1 - s);
    n = v * (1 - s * f);
    switch (i){
        case 0: return WZRGBTypeMake(v, n, m);
        case 1: return WZRGBTypeMake(n, v, m);
        case 2: return WZRGBTypeMake(m, v, n);
        case 3: return WZRGBTypeMake(m, n, v);
        case 4: return WZRGBTypeMake(n, m, v);
        case 5: return WZRGBTypeMake(v, m, n);
        default: return WZRGBTypeMake(v, m, n);
    }
    return WZRGBTypeMake(0, 0, 0);
}

@implementation UIColor (WWZ)
- (WZRGBType)wwz_rgbType{
    
    const CGFloat *components = CGColorGetComponents(self.CGColor);
    
    CGFloat r,g,b;
    
    switch (CGColorSpaceGetModel(CGColorGetColorSpace(self.CGColor)))
    {
        case kCGColorSpaceModelMonochrome:
            r = g = b = components[0];
            break;
        case kCGColorSpaceModelRGB:
            r = components[0];
            g = components[1];
            b = components[2];
            break;
        default:	// We don't know how to handle this model
            return WZRGBTypeMake(0, 0, 0);
    }
    
    return WZRGBTypeMake(r, g, b);
}


- (WZHSVType)wwz_hsvType{
    return WZHSV_From_RGB(self.wwz_rgbType);
}

/**
 *  当前色值的透明度
 */
- (float)wwz_colorAlpha{
    
    const CGFloat *c = CGColorGetComponents(self.CGColor);
    
    return c[CGColorGetNumberOfComponents(self.CGColor)-1]/255.0;
}



+ (instancetype)wwz_colorWithRgbType:(WZRGBType)rgbType{
    
    return [UIColor colorWithRed:rgbType.r green:rgbType.g blue:rgbType.b alpha:1];
}

+ (instancetype)wwz_colorWithHsvType:(WZHSVType)hsvType{
    
    return [UIColor colorWithHue:hsvType.h saturation:hsvType.s brightness:hsvType.v alpha:1];
}

/**
 *  随机色
 */
+ (instancetype)wwz_randomColor{
    
    CGFloat hue = ( arc4random() % 256 / 256.0 );
    CGFloat saturation = ( arc4random() % 128 / 256.0 ) + 0.5;
    CGFloat brightness = ( arc4random() % 128 / 256.0 ) + 0.5;
    return [UIColor colorWithHue:hue saturation:saturation brightness:brightness alpha:1];
    
}
/**
 *  反转颜色
 */
- (instancetype)wwz_reverseColor{
    
    float r = 1 - self.wwz_rgbType.r;
    float g = 1 - self.wwz_rgbType.g;
    float b = 1 - self.wwz_rgbType.b;
    float alpha = self.wwz_colorAlpha;
    
    return [UIColor colorWithRed:r green:g blue:b alpha:alpha];
}

/**
 *  单个颜色调整
 *
 *  @param type WZColorType
 *  @param num  调整数值0～255
 *
 *  @return UIColor
 */
- (instancetype)wwz_colorWithType:(WZColorType)type isUp:(BOOL)isUp num:(NSInteger)num{
    
    num = isUp ? num : -num;
    
    float r = self.wwz_rgbType.r * 255.0;
    float g = self.wwz_rgbType.g * 255.0;
    float b = self.wwz_rgbType.b * 255.0;
    float a = self.wwz_colorAlpha * 255.0;
    
    switch (type) {
        case 1:
            return kColorFromRGBA(r+num, g, b, a);
            break;
        case 2:
            return kColorFromRGBA(r, g+num, b, a);
            break;
        case 3:
            return kColorFromRGBA(r, g, b+num, a);
            break;
        case 4:
            return kColorFromRGBA(r, g, b, a+num/255.0);
            break;
        default:
            return self;
            break;
    }
}

/**
 *  图片上点的颜色
 *
 *  @param point 点
 *  @param image  image
 *
 *  @return uicolor
 */
+ (instancetype)wwz_colorAtPixel:(CGPoint)point inImage:(UIImage *)image{
    
    // Cancel if point is outside image coordinates
    if (!CGRectContainsPoint(CGRectMake(0.0f, 0.0f, image.size.width, image.size.height), point)) {
        return nil;
    }
    
    // Create a 1x1 pixel byte array and bitmap context to draw the pixel into.
    // Reference: http://stackoverflow.com/questions/1042830/retrieving-a-pixel-alpha-value-for-a-uiimage
    NSInteger pointX = trunc(point.x);
    NSInteger pointY = trunc(point.y);
    CGImageRef cgImage = image.CGImage;
    NSUInteger width = image.size.width;
    NSUInteger height = image.size.height;
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    int bytesPerPixel = 4;
    int bytesPerRow = bytesPerPixel * 1;
    NSUInteger bitsPerComponent = 8;
    unsigned char pixelData[4] = { 0, 0, 0, 0 };
    CGContextRef context = CGBitmapContextCreate(pixelData,
                                                 1,
                                                 1,
                                                 bitsPerComponent,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big);
    CGColorSpaceRelease(colorSpace);
    CGContextSetBlendMode(context, kCGBlendModeCopy);
    
    // Draw the pixel we are interested in onto the bitmap context
    CGContextTranslateCTM(context, -pointX, pointY-(CGFloat)height);
    CGContextDrawImage(context, CGRectMake(0.0f, 0.0f, (CGFloat)width, (CGFloat)height), cgImage);
    CGContextRelease(context);
    
    // Convert color values [0..255] to floats [0.0..1.0]
    CGFloat red   = (CGFloat)pixelData[0] / 255.0f;
    CGFloat green = (CGFloat)pixelData[1] / 255.0f;
    CGFloat blue  = (CGFloat)pixelData[2] / 255.0f;
    CGFloat alpha = (CGFloat)pixelData[3] / 255.0f;
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
    
}

/**
 *  将图片变成color
 */
+ (instancetype)wwz_colorWithBackgroundImage:(UIImage *)image size:(CGSize)size{
    
    UIGraphicsBeginImageContext(size);
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    [image drawInRect:rect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    return [UIColor colorWithPatternImage:newImage];
}


/**
 *  由字符串得到color
 */
+ (instancetype)wwz_colorWithColorSixteenString:(NSString *)string{
    
    float r = 0;
    float g = 0;
    float b = 0;
    float l = 255.0;
    
    if (string.length >= 2) {
        r = [self wwz_tenTypeValueWithString:[string substringWithRange:NSMakeRange(0, 2)]];
    }
    if (string.length >= 4) {
        g = [self wwz_tenTypeValueWithString:[string substringWithRange:NSMakeRange(2, 2)]];
    }
    if (string.length >= 6) {
        b = [self wwz_tenTypeValueWithString:[string substringWithRange:NSMakeRange(4, 2)]];
    }
    if (string.length >= 8) {
        l = [self wwz_tenTypeValueWithString:[string substringWithRange:NSMakeRange(6, 2)]];
    }
    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:l/255.0];
}
/**
 *  由color得到rgb字符串
 */
- (NSString *)wwz_rgbSixteenTypeString{
    
    WZRGBType rgbType = [self wwz_rgbType];
    // 四舍五入
    int r = (int)roundf(255.0 * rgbType.r);
    int g = (int)roundf(255.0 * rgbType.g);
    int b = (int)roundf(255.0 * rgbType.b);
    
    return [NSString stringWithFormat:@"%02x%02x%02x", r, g, b];
}
/**
 *  字符串 ==> WZRGBType
 */
+ (WZRGBType)wwz_rgbTypeWithColorSixteenString:(NSString *)string{
    
    return [[self wwz_colorWithColorSixteenString:string] wwz_rgbType];
}
/**
 *  WZRGBType ==> 字符串
 */
+ (NSString *)wwz_rgbSixteenTypeStringWithRgbType:(WZRGBType)rgbType{
    
    return [[self wwz_colorWithRgbType:rgbType] wwz_rgbSixteenTypeString];
}

#pragma mark - 私有方法

+ (float)wwz_tenTypeValueWithString:(NSString *)string{
    
    return (float)strtoul([string UTF8String], 0, 16);
}

@end

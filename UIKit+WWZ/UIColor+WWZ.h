//
//  UIColor+WWZ.h
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef WWZColor_h
#define WWZColor_h

// color
#define kColorFromRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define WZUIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define WZUIColorFromRGBA(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF000000) >> 24))/255.0 \
green:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
blue:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
alpha:((float)(rgbValue & 0xFF))/255.0]

#endif

typedef struct {float r, g, b;} WZRGBType;
typedef struct {float h, s, v;} WZHSVType;

WZRGBType WZRGBTypeMake(float r, float g, float b);
WZHSVType WZHSVTypeMake(float h, float s, float v);

WZHSVType WZHSV_From_RGB(WZRGBType RGB);
WZRGBType WZRGB_From_HSV(WZHSVType HSV);

typedef NS_ENUM(NSInteger, WZColorType) {
    
    WZColorTypeRed = 1,
    WZColorTypeGreen = 2,
    WZColorTypeBlue = 3,
    WZColorTypeAlpha = 4
};

@interface UIColor (WWZ)

/**
*  WZRGBType <==> UIColor
*/
+ (instancetype)wwz_colorWithRgbType:(WZRGBType)rgbType;

/**
 *  UIColor <==> WZRGBType
 */
- (WZRGBType)wwz_rgbType;

/**
 *  WZHSVType <==> UIColor
 */
+ (instancetype)wwz_colorWithHsvType:(WZHSVType)hsvType;

/**
 *  UIColor <==> WZHSVType
 */
- (WZHSVType)wwz_hsvType;

/**
 *  当前色值的透明度
 */
- (float)wwz_colorAlpha;

/**
 *  随机色
 */
+ (instancetype)wwz_randomColor;

/**
 *  反转颜色
 */
- (instancetype)wwz_reverseColor;

/**
 *  单个颜色调整
 *
 *  @param type WZColorType
 *  @param isUp 上调或下调
 *  @param num  调整数值0～255
 *
 *  @return UIColor
 */
- (instancetype)wwz_colorWithType:(WZColorType)type isUp:(BOOL)isUp num:(NSInteger)num;

/**
 *  图片上点的颜色
 *
 *  @param point 点
 *  @param image  image
 *
 *  @return uicolor
 */
+ (instancetype)wwz_colorAtPixel:(CGPoint)point inImage:(UIImage *)image;

/**
 *  将图片变成color
 */
+ (instancetype)wwz_colorWithBackgroundImage:(UIImage *)image size:(CGSize)size;


#pragma mark - color <==> 字符串

/**
 *  字符串 <==> UIColor
 */
+ (instancetype)wwz_colorWithColorSixteenString:(NSString *)string;

/**
 *  UIColor <==> 字符串
 */
- (NSString *)wwz_rgbSixteenTypeString;

/**
 *  字符串 ==> RGBType
 */
+ (WZRGBType)wwz_rgbTypeWithColorSixteenString:(NSString *)string;

/**
 *  RGBType ==> 字符串
 */
+ (NSString *)wwz_rgbSixteenTypeStringWithRgbType:(WZRGBType)rgbType;

@end

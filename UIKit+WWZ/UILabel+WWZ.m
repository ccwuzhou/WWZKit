//
//  UILabel+WWZ.m
//  WWZKit
//
//  Created by wwz on 17/3/7.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import "UILabel+WWZ.h"

@implementation UILabel (WWZ)

/**
 *  自适应尺寸的label
 */
+ (UILabel *)wwz_labelWithText:(NSString *)text font:(UIFont *)font tColor:(UIColor *)tColor alignment:(NSTextAlignment)alignment numberOfLines:(NSInteger)numberOfLines{
    
    UILabel *label = [self wwz_labelWithFrame:CGRectZero text:text font:font tColor:tColor alignment:alignment numberOfLines:numberOfLines];
    [label sizeToFit];
    return label;
}

/**
 *  给定frame的label
 */
+ (UILabel *)wwz_labelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font tColor:(UIColor *)tColor alignment:(NSTextAlignment)alignment numberOfLines:(NSInteger)numberOfLines{
    
    UILabel *label = [[self alloc] initWithFrame:frame];
    label.text = text;
    label.font = font;
    label.textColor = tColor;
    label.textAlignment = alignment;
    label.numberOfLines = numberOfLines;
    
    return label;
}
/**
 *  自适应
 */
- (void)wwz_sizeToFitWithMaxSize:(CGSize)maxSize{
    
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rectToFit = [self.text boundingRectWithSize:maxSize options:options attributes:@{NSFontAttributeName:self.font} context:nil];
    CGSize sizeToFit = CGSizeMake(ceilf(rectToFit.size.width)+2, ceilf(rectToFit.size.height));
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, sizeToFit.width, sizeToFit.height*0.6);
}

@end

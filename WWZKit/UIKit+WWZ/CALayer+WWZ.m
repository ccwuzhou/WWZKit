//
//  CALayer+WWZ.m
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import "CALayer+WWZ.h"

@implementation CALayer (WWZ)
/**
 *  设置圆角半径
 */
- (void)wwz_setCornerRadius:(CGFloat)radius{
    [self wwz_setCornerRadius:radius borderWidth:0 borderColor:[UIColor blackColor]];
}

/**
 *  设置圆形描边
 */
- (void)wwz_setMasksBorderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    
    [self wwz_setCornerRadius:MIN(self.frame.size.width, self.frame.size.height)*0.5 borderWidth:borderWidth borderColor:borderColor];
}

/**
 *  设置描边
 */
- (void)wwz_setCornerRadius:(CGFloat)radius borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor{
    self.masksToBounds = YES;
    self.cornerRadius = radius;
    self.borderWidth = borderWidth;
    self.borderColor = borderColor.CGColor;
}

/**
 *  设置阴影
 */
- (void)wwz_setShadowWithColor:(UIColor *)shadowColor offset:(CGSize)offset{
    
    self.shadowColor = [shadowColor CGColor];
    self.shadowOffset = offset;
    self.shadowOpacity = 1;
    self.shadowRadius = 0;
    
    //    UIBezierPath *path = [UIBezierPath bezierPath];
    //    [path moveToPoint:CGPointMake(10, 10)];
    //    [path addLineToPoint:CGPointMake(100, 100)];
    //    self.shadowPath = path.CGPath;
    
}

- (void)wwz_setShadowOffsetY:(CGFloat)offsetY{
    
    [self wwz_setShadowWithColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3] offset:CGSizeMake(0, offsetY)];
}

/**
 *  暂停动画
 */
- (void)wwz_pauseAnimation{
    
    self.speed = 0.0;
    // 暂停时间
    CFTimeInterval pausedTime = [self convertTime:CACurrentMediaTime() fromLayer:nil];
    self.timeOffset = pausedTime;
}
/**
 *  恢复动画
 */
- (void)wwz_resumeAnimation{
    
    self.speed = 1.0;
    self.timeOffset = 0.0;
    self.beginTime = 0.0;
    CFTimeInterval pausedTime = [self timeOffset];
    CFTimeInterval timeSincePause = [self convertTime:CACurrentMediaTime() fromLayer:nil] - pausedTime;
    self.beginTime = timeSincePause;
}
@end

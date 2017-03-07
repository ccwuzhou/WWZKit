
//
//  WWZAngle.m
//  wwz
//
//  Created by wwz on 16/8/3.
//  Copyright © 2016年 cn.szwwz. All rights reserved.
//

#import "WWZAngle.h"

@implementation WWZAngle


/**
 *  两线之间的角度
 */
+ (CGFloat)wwz_angleBetweenLinesWithLine1Start:(CGPoint)line1Start
                                      Line1End:(CGPoint)line1End
                                    Line2Start:(CGPoint)line2Start
                                      Line2End:(CGPoint)line2End{
    
    CGFloat a = line1End.x - line1Start.x;
    CGFloat b = line1End.y - line1Start.y;
    CGFloat c = line2End.x - line2Start.x;
    CGFloat d = line2End.y - line2Start.y;
    return acos(((a*c) + (b*d)) / ((sqrt(a*a + b*b)) * (sqrt(c*c + d*d))));
}


/**
 *  圆弧上点的坐标(相对于x正方向,逆时针转)
 *
 *  @param center 圆心
 *  @param angle  角度（弧度值）
 *  @param radius 半径
 */
+ (CGPoint)wwz_circleCoordinatePointWithCenter:(CGPoint)center
                                         angle:(CGFloat)angle
                                        radius:(CGFloat)radius{
    
    return [self wwz_circleCoordinatePointWithCenter:center startAngle:0 changeAngle:angle radius:radius clockwise:NO];
}

/**
 *  圆弧上点的坐标
 *
 *  @param center      圆心坐标
 *  @param startAngle  起始计算弧度（x正方向为0度，逆时针递增）
 *  @param changeAngle 相对起始弧度的转过的弧度（顺时针）
 *  @param radius      半径
 *  @param clockwise   顺时针
 *
 *  @return 圆弧上点的坐标
 */
+ (CGPoint)wwz_circleCoordinatePointWithCenter:(CGPoint)center
                                    startAngle:(CGFloat)startAngle
                                   changeAngle:(CGFloat)changeAngle
                                        radius:(CGFloat)radius
                                     clockwise:(BOOL)clockwise
{
    // 相对于x轴正方向的角度
    CGFloat currentAngle = 0;
    
    if (clockwise) {// 顺时针
        
        currentAngle = startAngle-changeAngle;
        
    }else{// 逆时针
        
        currentAngle = -(startAngle-changeAngle);
    }
    
    CGFloat x2 = radius*cosf(currentAngle);
    CGFloat y2 = radius*sinf(currentAngle);
    
    return CGPointMake(center.x+x2, center.y-y2);
    
}

@end

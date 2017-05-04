//
//  UINavigationBar+WWZ.m
//  WWZKit
//
//  Created by wwz on 17/3/7.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import "UINavigationBar+WWZ.h"

@implementation UINavigationBar (WWZ)

- (void)wwz_setBackgroundColor:(UIColor *)color{
    
    self.barTintColor = color;
    //    self.translucent = NO;
    [self setShadowImage:nil];
}

- (void)wwz_setTitleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont{
    
    // 设置导航条标题的字体和颜色
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor,NSFontAttributeName:titleFont}];
}

- (void)wwz_noShadowImage{
    //去掉导航栏下面黑线
    if ([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
        
        for (UIView *obj in self.subviews){
            
            if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0){//10.0的系统字段不一样
                
                for (UIView *obj2 in obj.subviews) {
                    
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
 
                        obj2.hidden = YES;
                    }
                }
            }else{
                
                if ([obj isKindOfClass:[UIImageView class]]){
                    
                    for (UIView *obj2 in obj.subviews){
                        
                        if ([obj2 isKindOfClass:[UIImageView class]]){
               
                            obj2.hidden=YES;
                        }
                    }
                }
            }
        }
    }
}

@end

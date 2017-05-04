//
//  UINavigationBar+WWZ.m
//  WWZKit
//
//  Created by wwz on 17/3/7.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import "UINavigationBar+WWZ.h"
#import <objc/runtime.h>

static NSString *const WWZ_NAVBAR_OVERLAY_KEY = @"WWZ_NAVBAR_OVERLAY_KEY";


@interface UINavigationBar (WWZ)

@property (nonatomic, strong) UIView *wwz_overlay;

@end


@implementation UINavigationBar (WWZ)

/**
 *  设置标题
 */
- (void)wwz_setTitleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont{
    
    // 设置导航条标题的字体和颜色
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor,NSFontAttributeName:titleFont}];
}

/**
 *  设置背景颜色
 */
- (void)wwz_setBackgroundColor:(UIColor *)color{
    
    if (!self.wwz_overlay) {
        [self setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
        
        self.wwz_overlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height+20)];
        self.wwz_overlay.userInteractionEnabled = NO;
        self.wwz_overlay.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    }
    self.wwz_overlay.backgroundColor = color;
    
    [self.subviews.firstObject insertSubview:self.wwz_overlay atIndex:0];
}

/**
 *  是否隐藏下面线
 */
- (void)wwz_setShadowImage:(BOOL)isHidden{

    UIImageView *lineImageView = [self wwz_findNavLineImageViewOnView:self];
    lineImageView.hidden = isHidden;
}

/**
 *  还原，viewWillDisAppear调用
 */
- (void)wwz_reset{

    [self wwz_setShadowImage:NO];
    [self setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    
    [self.wwz_overlay removeFromSuperview];
    self.wwz_overlay = nil;
}
/**
 *  设置tabbar内所有视图的alpha
 */
- (void)wwz_setElementAlpha:(CGFloat)alpha{

    for (UIView *element in self.subviews) {
        
        if ([element isKindOfClass:NSClassFromString(@"UINavigationItemView")]||[element isKindOfClass:NSClassFromString(@"UINavigationButton")]||[element isKindOfClass:NSClassFromString(@"UINavBarPrompt")]) {
            element.alpha = alpha;
        }
        if ([element isKindOfClass:NSClassFromString(@"_UINavigationBarBackIndicatorView")]||[element isKindOfClass:NSClassFromString(@"_UIBarBackground")]||[element isKindOfClass:NSClassFromString(@"_UINavigationBarBackground")]) {
            element.alpha = element.alpha == 0 ? 0 : alpha;
        }
        
        for (UINavigationItem *item in self.items) {
            
            item.titleView.alpha = alpha;
            
            for (UIBarButtonItem *barItem in item.leftBarButtonItems) {
                barItem.customView.alpha = alpha;
            }
            for (UIBarButtonItem *barItem in item.rightBarButtonItems) {
                barItem.customView.alpha = alpha;
            }
        }
    }
}


#pragma mark - 私有方法
- (UIImageView *)wwz_findNavLineImageViewOnView:(UIView *)view{

    if ([view isKindOfClass:[UIImageView class]] && view.bounds.size.height <= 1.0) {
        return view;
    }
    
    for (UIView *subView in view.subviews) {
        UIImageView *imageView = [self wwz_findNavLineImageViewOnView:subView];
        if (imageView) {
            return imageView;
        }
    }
    return nil;
}


- (UIView *)wwz_overlay{

    return objc_getAssociatedObject(self, &WWZ_NAVBAR_OVERLAY_KEY);
}

- (void)setWwz_overlay:(UIView *)wwz_overlay{

    objc_setAssociatedObject(self, &WWZ_NAVBAR_OVERLAY_KEY, wwz_overlay, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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

//
//  WWZNavigationController.m
//  wwz
//
//  Created by wwz on 16/8/4.
//  Copyright © 2016年 cn.szwwz. All rights reserved.
//

#import "WWZNavigationController.h"

@interface WWZNavigationController ()

//@property (nonatomic, strong) UIImage *originBackgroundImage;
//
//@property (nonatomic, strong) UIImage *originShadowImage;
//
//@property (nonatomic, assign) BOOL originIsTranslucent;

@end

@implementation WWZNavigationController

#pragma mark 类第一次使用的时候被调用
+ (void)initialize{

    if (self == [WWZNavigationController class]) {
        // ...
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self wwz_setBackgroundColor:[UIColor blueColor]];
}

- (void)wwz_setBackgroundColor:(UIColor *)backgroundColor
                     titleFont:(UIFont *)titleFont
                    titleColor:(UIColor *)titleColor
                     tintColor:(UIColor *)tintColor
                      itemFont:(UIFont *)itemFont{

    // 设置导航条的背题色
    self.navigationBar.barTintColor = backgroundColor;
    self.navigationBar.translucent = NO;
    [self.navigationBar setShadowImage:nil];
    
    // 设置导航条标题的字体和颜色
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor,NSFontAttributeName:titleFont}];
    
    //tintColor是用于导航条的所有Item
    self.navigationBar.tintColor = tintColor;
    
    UIBarButtonItem *navItem = [UIBarButtonItem appearance];
    
    //设置Item的字体大小
    [navItem setTitleTextAttributes:@{NSFontAttributeName:itemFont} forState:UIControlStateNormal];
    
    //去掉导航栏下面黑线
    if ([self.navigationBar respondsToSelector:@selector( setBackgroundImage:forBarMetrics:)])
    {
        
        NSArray *list=self.navigationBar.subviews;
        
        for (id obj in list)
        {
            
            if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0)
            {//10.0的系统字段不一样
                UIView *view =   (UIView*)obj;
                for (id obj2 in view.subviews) {
                    
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        
                        UIImageView *image =  (UIImageView*)obj2;
                        image.hidden = YES;
                    }
                }
            }else{
                
                if ([obj isKindOfClass:[UIImageView class]]){
                    
                    UIImageView *imageView=(UIImageView *)obj;
                    NSArray *list2=imageView.subviews;
                    
                    for (id obj2 in list2){
                        if ([obj2 isKindOfClass:[UIImageView class]]){
                            
                            UIImageView *imageView2=(UIImageView *)obj2;
                            imageView2.hidden=YES;
                        }
                    }
                }
            }
        }
    }
}


/**
 *  设置导航栏透明度
 *
 *  @param alpha
 */
- (void)wwz_setBackgroundAlpha:(CGFloat)alpha{
    
    [self wwz_setBackgroundColor:[self.navigationBar.barTintColor colorWithAlphaComponent:alpha]];
}

/**
 *  设置导航栏背景颜色
 *
 *  @param color
 */
- (void)wwz_setBackgroundColor:(UIColor *)color{
    
    // 保存原始值
//    _originBackgroundImage = [self.navigationBar backgroundImageForBarMetrics:UIBarMetricsDefault];
//    _originShadowImage = self.navigationBar.shadowImage;
//    _originIsTranslucent = self.navigationBar.translucent;
    
    // 设置当前背景图
    self.navigationBar.barTintColor = color;
    self.navigationBar.translucent = NO;
//    [self.navigationBar setBackgroundImage:[self imageWithColor:color size:CGSizeMake([UIScreen mainScreen].bounds.size.width, self.navigationBar.bounds.size.height + 20) alpha:1] forBarMetrics:UIBarMetricsDefault];
    [self.navigationBar setShadowImage:nil];
    
}
/**
 *  重置导航栏的状态，恢复到初始时的状态
 */
- (void)wwz_reset{
    
//    [self.navigationBar setBackgroundImage:_originBackgroundImage forBarMetrics:UIBarMetricsDefault];
//    [self.navigationBar setShadowImage:_originShadowImage];
//    [self.navigationBar setTranslucent:_originIsTranslucent];
//    
//    _originBackgroundImage = nil;
//    _originShadowImage     = nil;
}

#pragma mark 导航控制器的子控制器被push 的时候会调用

-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    
    
//    if (![viewController isKindOfClass:[BCMainController class]]) {
//        // 设置自定义返回按钮后，滑动返回功能会没有
//        UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"top_back_iphone"] style:UIBarButtonItemStyleDone target:self action:@selector(clickLeftBarBtn)];
//        // 设置导航条的按钮
//        viewController.navigationItem.leftBarButtonItem = left;
//    }

    
//    if (self.viewControllers.count == 0) {// 根控制器
//
//    }else{// 非根控制器
//
//    }
    [super pushViewController:viewController animated:animated];
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
//    UITabBarController *tabBarVc = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
//    
//    // 删除系统自带的tabBarButton
//    for (UIView *tabBarButton in tabBarVc.tabBar.subviews) {
//        if (![tabBarButton isKindOfClass:[BCTabBar class]]) {
//            [tabBarButton removeFromSuperview];
//        }
//    }
    
}
/**
 *  点击返回时
 */
//- (void)wwz_clickLeftBarBtn{
//    
//    if (self.viewControllers.count == 1) {//根控制器
//
//        [self.topViewController dismissViewControllerAnimated:YES completion:nil];
//        
//    }else{//非根控制器
//
//        [self popViewControllerAnimated:YES];
//    }
//}

#pragma mark 导航控制器的子控制器被pop[移除]的时候会调用
-(UIViewController *)popViewControllerAnimated:(BOOL)animated{
   
    return [super popViewControllerAnimated:animated];
}

#pragma mark 设置状态栏的样式
//如果有导航控制器的，状态栏的样式要在导航控制器里设置，不能在子控制器里设置
//这只方式只能针对局部的控制器
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return UIStatusBarStyleLightContent;
}


#pragma mark - 旋转相关
//-(BOOL)shouldAutorotate{
//
//    return NO;
//}
//
//
//-(UIInterfaceOrientationMask)supportedInterfaceOrientations{
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        return UIInterfaceOrientationMaskLandscape;
//    }else{
//        return UIInterfaceOrientationMaskPortrait;
//    }
//}
//
//- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
//    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//        return UIInterfaceOrientationMaskLandscape;
//    }else{
//        return (interfaceOrientation == UIInterfaceOrientationMaskPortrait);
//    }
//
//}



- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size alpha:(float)alpha{
    
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
@end

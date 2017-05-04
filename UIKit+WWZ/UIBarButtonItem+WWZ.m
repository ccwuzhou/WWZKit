//
//  UIBarButtonItem+WWZ.m
//  WWZKit
//
//  Created by wwz on 17/3/8.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import "UIBarButtonItem+WWZ.h"

@implementation UIBarButtonItem (WWZ)


+ (instancetype)wwz_barButtonItemWithNImageName:(NSString *)nImageName sImageName:(NSString *)sImageName{

    return [self wwz_barButtonItemWithNImageName:nImageName hImageName:nil sImageName:sImageName];
}
+ (instancetype)wwz_barButtonItemWithNImageName:(NSString *)nImageName hImageName:(NSString *)hImageName{
    
    return [self wwz_barButtonItemWithNImageName:nImageName hImageName:hImageName sImageName:nil];
}
+ (instancetype)wwz_barButtonItemWithNImageName:(NSString *)nImageName hImageName:(NSString *)hImageName sImageName:(NSString *)sImageName{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:[UIImage imageNamed:nImageName] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:hImageName] forState:UIControlStateHighlighted];
    [button setImage:[UIImage imageNamed:sImageName] forState:UIControlStateSelected];
    [button sizeToFit];
    
    return [[self alloc] initWithCustomView:button];
}

@end

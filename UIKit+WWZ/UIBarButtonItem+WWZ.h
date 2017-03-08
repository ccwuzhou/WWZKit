//
//  UIBarButtonItem+WWZ.h
//  WWZKit
//
//  Created by wwz on 17/3/8.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (WWZ)

+ (instancetype)wwz_barButtonItemWithNImageName:(NSString *)nImageName sImageName:(NSString *)sImageName;

+ (instancetype)wwz_barButtonItemWithNImageName:(NSString *)nImageName hImageName:(NSString *)hImageName;

+ (instancetype)wwz_barButtonItemWithNImageName:(NSString *)nImageName hImageName:(NSString *)hImageName sImageName:(NSString *)sImageName;

@end

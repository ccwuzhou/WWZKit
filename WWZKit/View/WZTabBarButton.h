//
//  BCTabBarButton.h
//  BCSmart
//
//  Created by wwz on 16/7/16.
//  Copyright © 2016年 cn.zgkjd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WZTabBarItem : UITabBarItem

@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIColor *selectedTitleColor;

@property (nonatomic, strong) UIColor *backgroundColor;

@property (nonatomic, strong) UIColor *selectedBackgroundColor;

@property (nonatomic, strong) UIColor *badgeNColor;

@end


@interface WZTabBarButton : UIButton

@property (nonatomic, strong) WZTabBarItem *item;

+ (instancetype)wwz_tabBarButtonWithItem:(WZTabBarItem *)item;

@end

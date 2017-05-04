//
//  BCTabBarButton.h
//  BCSmart
//
//  Created by wwz on 16/7/16.
//  Copyright © 2016年 cn.zgkjd. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WWZTabBarItem : UITabBarItem

@property (nonatomic, strong) UIFont *titleFont;

@property (nonatomic, strong) UIColor *titleColor;

@property (nonatomic, strong) UIColor *selectedTitleColor;

@property (nonatomic, strong) UIColor *backgroundColor;

@property (nonatomic, strong) UIColor *selectedBackgroundColor;

@property (nonatomic, strong) UIColor *badgeNColor;

@end


@interface WWZTabBarButton : UIButton

@property (nonatomic, strong) WWZTabBarItem *item;

+ (instancetype)wwz_tabBarButtonWithItem:(WWZTabBarItem *)item;

@end

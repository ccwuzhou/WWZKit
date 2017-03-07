//
//  WZTabBar.h
//  BCSmart
//
//  Created by wwz on 16/11/16.
//  Copyright © 2016年 cn.zgkjd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WZTabBarButton;
@class WZTabBar;

@protocol WZTabBarDelegate <NSObject>

@optional

- (void)tabBar:(WZTabBar *)tabBar didClickButtonAtIndex:(NSUInteger)index;

@end

@interface WZTabBar : UIView

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, weak) id<WZTabBarDelegate> delegate;

- (WZTabBarButton *)tabBarButtonAtIndex:(NSInteger)index;
@end

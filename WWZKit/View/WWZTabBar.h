//
//  WWZTabBar.h
//  BCSmart
//
//  Created by wwz on 16/11/16.
//  Copyright © 2016年 cn.zgkjd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WWZTabBarButton;
@class WWZTabBar;

@protocol WWZTabBarDelegate <NSObject>

@optional

- (void)tabBar:(WWZTabBar *)tabBar didClickButtonAtIndex:(NSUInteger)index;

@end

@interface WWZTabBar : UIView

@property (nonatomic, strong) NSArray *items;

@property (nonatomic, weak) id<WWZTabBarDelegate> delegate;

- (WWZTabBarButton *)tabBarButtonAtIndex:(NSInteger)index;
@end


//
//  WZTabBar.m
//  BCSmart
//
//  Created by wwz on 16/11/16.
//  Copyright © 2016年 cn.zgkjd. All rights reserved.
//

#import "WZTabBar.h"
#import "WZTabBarButton.h"

static int const WZTabBarButtonTag = 99;

@interface WZTabBar ()

@property (nonatomic, strong) NSMutableArray *mTabBarButtons;

@property (nonatomic, weak) UIButton *selButton;

@end

@implementation WZTabBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setItems:(NSArray *)items{
    
    _items = items;
    
    for (WZTabBarItem *item in _items) {
        
        WZTabBarButton *tabBarBtn = [WZTabBarButton wwz_tabBarButtonWithItem:item];
        
        tabBarBtn.tag = self.mTabBarButtons.count + WZTabBarButtonTag;
        
        [tabBarBtn addTarget:self action:@selector(clickTabBarButton:) forControlEvents:UIControlEventTouchDown];
        
        // 初始选中第0个
        if (tabBarBtn.tag == 0 + WZTabBarButtonTag) {
            
            [self clickTabBarButton:tabBarBtn];
            
        }
 
        [self addSubview:tabBarBtn];
        
        [self.mTabBarButtons addObject:tabBarBtn];
    }
}

- (void)clickTabBarButton:(UIButton *)sender{
    
    _selButton.selected = NO;
    
    sender.selected = YES;
    
    _selButton = sender;
    
    if ([_delegate respondsToSelector:@selector(tabBar:didClickButtonAtIndex:)]) {
        
        [_delegate tabBar:self didClickButtonAtIndex:sender.tag - WZTabBarButtonTag];
    }
}


- (WZTabBarButton *)tabBarButtonAtIndex:(NSInteger)index{
    
    return (WZTabBarButton *)[self viewWithTag:index+WZTabBarButtonTag];
}
- (NSMutableArray *)mTabBarButtons{
    
    if (!_mTabBarButtons) {
        _mTabBarButtons = [NSMutableArray array];
    }
    return _mTabBarButtons;
}

// self.items UITabBarItem模型，有多少个子控制器就有多少个UITabBarItem模型
// 调整子控件的位置
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat btnX = 0;
    
    CGFloat btnW = self.bounds.size.width / self.items.count;
    CGFloat btnH = 49;
    CGFloat btnY = self.bounds.size.height-49;
    
    int i = 0;
    // 设置tabBarButton的frame
    for (UIView *tabBarButton in self.mTabBarButtons) {
        
        btnX = i * btnW;
        tabBarButton.frame = CGRectMake(btnX, btnY, btnW, btnH);
        i++;
    }
}
@end

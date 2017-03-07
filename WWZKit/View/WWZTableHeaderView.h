//
//  WZCellHeaderView.h
//  BCSmart
//
//  Created by wwz on 16/7/6.
//  Copyright © 2016年 cn.zgkjd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WWZReusableModel;
@class WWZTableHeaderView;

@protocol WWZTableHeaderViewDelegate <NSObject>

@optional

/**
 *  tap headerView 回调
 */
- (void)didTapHeaderView:(WWZTableHeaderView *)headerView;

@end

@interface WWZTableHeaderView : UITableViewHeaderFooterView

/**
 *  左边图片
 */
@property (nonatomic, strong, readonly) UIImageView *imageView;

/**
 *  左边文本
 */
@property (nonatomic, strong, readonly) UILabel *titleLabel;

/**
 *  view 底线
 */
@property (nonatomic, strong, readonly) UIView *lineView;

/**
 *  tableView是否展开
 */
@property (nonatomic, assign) BOOL isUnfold;


@property (nonatomic, strong) WWZReusableModel *reusableModel;

@property (nonatomic, weak) id<WWZTableHeaderViewDelegate> delegate;

/**
 *  底层调用initWithReuseIdentifier初始化方法
 */
+ (instancetype)wwz_headerViewWithTabelView:(UITableView *)tableView;

@end

//
//  WZCollectionReusableView.h
//  BCSmart
//
//  Created by wwz on 16/7/6.
//  Copyright © 2016年 cn.zgkjd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WZReusableModel;

@class WZCollectionReusableView;

@protocol WZCollectionReusableViewDelegate <NSObject>

@optional

/**
 *  tap回调
 */
- (void)didTapReusableView:(WZCollectionReusableView *)reusableView;

@end

@interface WZCollectionReusableView : UICollectionReusableView

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
 *  collectionView是否展开
 */
@property (nonatomic, assign) BOOL isUnfold;

@property (nonatomic, strong) WZReusableModel *reusableModel;

@property (nonatomic, weak) id<WZCollectionReusableViewDelegate> delegate;

@end

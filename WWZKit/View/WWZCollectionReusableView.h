//
//  WWZCollectionReusableView.h
//  BCSmart
//
//  Created by wwz on 16/7/6.
//  Copyright © 2016年 cn.zgkjd. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WWZReusableModel;

@class WWZCollectionReusableView;

@protocol WWZCollectionReusableViewDelegate <NSObject>

@optional

/**
 *  tap回调
 */
- (void)didTapReusableView:(WWZCollectionReusableView *)reusableView;

@end

@interface WWZCollectionReusableView : UICollectionReusableView

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

@property (nonatomic, strong) WWZReusableModel *reusableModel;

@property (nonatomic, weak) id<WWZCollectionReusableViewDelegate> delegate;

@end

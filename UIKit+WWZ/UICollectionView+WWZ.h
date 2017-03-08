//
//  UICollectionView+WWZ.h
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UICollectionViewFlowLayout (WWZ)

/**
 *  UICollectionViewFlowLayout
 *
 *  @param inset           sectionInset
 *  @param itemCount       itemCount
 *  @param lineSpace       minimumLineSpacing
 *  @param itemSpace       minimumInteritemSpacing
 *  @param scrollDirection scrollDirection
 *
 *  @return UICollectionViewFlowLayout
 */
+ (instancetype)wwz_flowLayoutWithViewSize:(CGSize)viewSize
                              sectionInset:(UIEdgeInsets)sectionInset
                                 itemCount:(NSUInteger)itemCount
                                 lineSpace:(CGFloat)lineSpace
                                 itemSpace:(CGFloat)itemSpace
                           scrollDirection:(UICollectionViewScrollDirection)scrollDirection;
/**
 *  UICollectionViewFlowLayout
 *
 *  @param inset           sectionInset
 *  @param itemSize        itemSize
 *  @param lineSpace       minimumLineSpacing
 *  @param itemSpace       minimumInteritemSpacing
 *  @param scrollDirection scrollDirection
 *
 *  @return UICollectionViewFlowLayout
 */
+ (instancetype)wwz_flowLayoutWithSectionInset:(UIEdgeInsets)sectionInset
                                      itemSize:(CGSize)itemSize
                                     lineSpace:(CGFloat)lineSpace
                                     itemSpace:(CGFloat)itemSpace
                               scrollDirection:(UICollectionViewScrollDirection)scrollDirection;
@end


@interface UICollectionView (WWZ)

/**
 *  collectionView
 *
 *  @param frame      frame
 *  @param flowLayout flowLayout
 *
 *  @return UICollectionView
 */
+ (instancetype)wwz_collectionViewWithFrame:(CGRect)frame flowLayout:(UICollectionViewFlowLayout *)flowLayout;

@end

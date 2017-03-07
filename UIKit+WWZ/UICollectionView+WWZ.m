//
//  UICollectionView+WWZ.m
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import "UICollectionView+WWZ.h"

@implementation UICollectionViewFlowLayout (WWZ)

/**
 *  default flowLayout
 */
+ (instancetype)wwz_defaultFlowlayout{
    
    UIEdgeInsets edgeInsets = UIEdgeInsetsMake(5, 0, 5, 0);
    CGFloat lineSpace = 0;
    CGFloat itemSpace = 0;
    int itemCount = 3;
    
    CGFloat itemWH = ([UIScreen mainScreen].bounds.size.width-edgeInsets.left-edgeInsets.right-(itemCount-1)*itemSpace)/itemCount;
    
    return [self wwz_flowLayoutWithSectionInset:edgeInsets itemSize:CGSizeMake(itemWH, itemWH) lineSpace:lineSpace itemSpace:itemSpace scrollDirection:UICollectionViewScrollDirectionVertical];
}

/**
 *  固定itemCount的FlowLayout
 *
 *  @param viewSize        视图总size
 *  @param sectionInset    sectionInset
 *  @param itemCount       itemCount
 *  @param lineSpace       lineSpace
 *  @param itemSpace       itemSpace
 *  @param scrollDirection scrollDirection
 *
 *  @return 固定itemCount的FlowLayout
 */
+ (instancetype)wwz_flowLayoutWithViewSize:(CGSize)viewSize
                              sectionInset:(UIEdgeInsets)sectionInset
                                 itemCount:(NSUInteger)itemCount
                                 lineSpace:(CGFloat)lineSpace
                                 itemSpace:(CGFloat)itemSpace
                           scrollDirection:(UICollectionViewScrollDirection)scrollDirection
{
    
    UICollectionViewFlowLayout *layout = [[self alloc] init];
    layout.scrollDirection = scrollDirection;//滚动方向
    
    layout.minimumLineSpacing = lineSpace;//行间距(最小值)
    layout.minimumInteritemSpacing = itemSpace;//item间距(最小值)
    
    CGFloat itemWH = 0;
    
    if (scrollDirection == UICollectionViewScrollDirectionVertical) {
        
        itemWH = (viewSize.width-sectionInset.left-sectionInset.right-(itemCount-1)*itemSpace)/itemCount;
    }else{
        
        itemWH = (viewSize.height-sectionInset.top-sectionInset.bottom-(itemCount-1)*lineSpace)/itemCount;
    }
    
    layout.itemSize = CGSizeMake(itemWH, itemWH);
    
    layout.sectionInset = sectionInset;//设置section的边距
    
    return layout;
}

/**
 *  固定itemSize的FlowLayout
 *
 *  @param inset           sectionInset
 *  @param itemSize        itemSize
 *  @param lineSpace       minimumLineSpacing
 *  @param itemSpace       minimumInteritemSpacing
 *  @param scrollDirection scrollDirection
 *
 *  @return 固定itemSize的FlowLayout
 */
+ (instancetype)wwz_flowLayoutWithSectionInset:(UIEdgeInsets)sectionInset
                                      itemSize:(CGSize)itemSize
                                     lineSpace:(CGFloat)lineSpace
                                     itemSpace:(CGFloat)itemSpace
                               scrollDirection:(UICollectionViewScrollDirection)scrollDirection{
    
    UICollectionViewFlowLayout *layout = [[self alloc] init];
    layout.scrollDirection = scrollDirection;//滚动方向
    
    layout.minimumLineSpacing = lineSpace;//行间距(最小值)
    layout.minimumInteritemSpacing = itemSpace;//item间距(最小值)
    layout.itemSize = itemSize;
    
    layout.sectionInset = sectionInset;//设置section的边距
    
    return layout;
}

@end


@implementation UICollectionView (WWZ)


/**
 *  default collectionView
 *
 *  @param frame frame
 *
 *  @return UICollectionView
 */
+ (instancetype)wwz_collectionViewWithFrame:(CGRect)frame{
    
    return [self wwz_collectionViewWithFrame:frame flowLayout:[UICollectionViewFlowLayout wwz_defaultFlowlayout]];
}
/**
 *  collectionView
 *
 *  @param frame      frame
 *  @param flowLayout flowLayout
 *
 *  @return UICollectionView
 */
+ (instancetype)wwz_collectionViewWithFrame:(CGRect)frame flowLayout:(UICollectionViewFlowLayout *)flowLayout{
    
    UICollectionView *collectionView = [[self alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    
    collectionView.showsHorizontalScrollIndicator = NO;
    collectionView.showsVerticalScrollIndicator = NO;
    collectionView.backgroundColor = [UIColor clearColor];
    
    return collectionView;
}
/**
 *  自适应itemSize的collectionView
 *
 *  @param frame           frame
 *  @param itemCount       itemCount
 *  @param flowLayout      flowLayout
 *
 *  @return UICollectionView
 */
+ (instancetype)wwz_collectionViewWithFrame:(CGRect)frame itemCount:(NSInteger)itemCount flowLayout:(UICollectionViewFlowLayout *)flowLayout{
    
    CGFloat itemWH = 0.0;
    
    UIEdgeInsets insets = flowLayout.sectionInset;
    CGFloat lineSpace = flowLayout.minimumLineSpacing;
    CGFloat itemSpace = flowLayout.minimumInteritemSpacing;
    
    if (flowLayout.scrollDirection == UICollectionViewScrollDirectionHorizontal) {// 水平滚动
        
        itemWH = (frame.size.width-insets.left-insets.right-(itemCount-1)*lineSpace)/itemCount;
        
        if (itemWH>frame.size.height-insets.top-insets.bottom&&itemWH<frame.size.height) {
            CGFloat top = (frame.size.height-itemWH)*0.5;
            insets = UIEdgeInsetsMake(top, insets.left, top, insets.right);
            
        }else if (itemWH>frame.size.height){
            itemWH = frame.size.height;
            insets = UIEdgeInsetsMake(0, insets.left, 0, insets.right);
            lineSpace = (frame.size.width-insets.left-insets.right-itemCount*itemWH)/(itemCount-1);
        }
        
    }else{// 竖直滚动
        
        itemWH = (frame.size.width-insets.left-insets.right-(itemCount-1)*itemSpace)/itemCount;
        
        if (itemWH>frame.size.height-insets.top-insets.bottom&&itemWH<frame.size.height) {
            CGFloat top = (frame.size.height-itemWH)*0.5;
            insets = UIEdgeInsetsMake(top, insets.left, top, insets.right);
            
        }else if (itemWH>frame.size.height){
            itemWH = frame.size.height;
            insets = UIEdgeInsetsMake(0, insets.left, 0, insets.right);
            itemSpace = (frame.size.width-insets.left-insets.right-itemCount*itemWH)/(itemCount-1);
        }
    }
    itemWH = floorf(itemWH);
    
    flowLayout.minimumLineSpacing = lineSpace;//行间距(最小值)
    flowLayout.minimumInteritemSpacing = itemSpace;//item间距(最小值)
    flowLayout.itemSize = CGSizeMake(itemWH, itemWH);//item的大小
    flowLayout.sectionInset = insets;//设置section的边距
    
    return [self wwz_collectionViewWithFrame:frame flowLayout:flowLayout];
    
}
@end

//
//  UIScrollView+WWZ.m
//  WWZKit
//
//  Created by wwz on 17/3/7.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import "UIScrollView+WWZ.h"

@implementation UIScrollView (WWZ)
/**
 *  scrollView
 *
 *  @param frame       frame
 *  @param contentSize contentSize
 *
 *  @return scrollView
 */
+ (UIScrollView *)wwz_scrollViewWithFrame:(CGRect)frame contentSize:(CGSize)contentSize{
    
    UIScrollView *scrollView = [[self alloc] initWithFrame:frame];
    
    scrollView.contentSize = contentSize;
    //    scrollView.pagingEnabled = YES;
    //    scrollView.bounces = NO;
    scrollView.showsHorizontalScrollIndicator = NO;
    scrollView.showsVerticalScrollIndicator = NO;
    
    return scrollView;
}
@end

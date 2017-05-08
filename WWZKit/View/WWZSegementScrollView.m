
//
//  WWZSegementScrollView.m
//  test
//
//  Created by apple on 2017/5/4.
//  Copyright © 2017年 wwz. All rights reserved.
//

#import "WWZSegementScrollView.h"
#import "UIView+WWZ.h"

@interface WWZSegementScrollView ()<WWZSegementViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@end

@implementation WWZSegementScrollView

@synthesize segementView = _segementView;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setSegementControllers:(NSArray *)segementControllers{

    if (_segementControllers) {
        return;
    }
    _segementControllers = segementControllers;
    
    [self addSubview:self.segementView];
    
    [self addSubview:self.scrollView];
}

#pragma mark - WWZSegementViewDelegate
- (void)segementView:(WWZSegementView *)segementView clickButtonAtIndex:(int)index{
    
    [UIView animateWithDuration:0.3 animations:^{
        self.scrollView.contentOffset = CGPointMake(self.scrollView.width*index, 0);
    }];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    if (scrollView != self.scrollView) {
        return;
    }
    
    
    
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    if (scrollView != self.scrollView) {
        return;
    }

    int index = scrollView.contentOffset.x / self.scrollView.width;
    
    [self.segementView selectCellAtIndex:index];
}
#pragma mark - getter

- (WWZSegementView *)segementView{

    if (!_segementView) {
        
        NSMutableArray *mTitles = [NSMutableArray array];
        
        for (UIViewController *vc in self.segementControllers) {
            
            [mTitles addObject:vc.title ? vc.title : @""];
        }
        
        _segementView = [[WWZSegementView alloc] initWithFrame:CGRectMake(0, 0, self.width, 50) titles:mTitles];
        _segementView.segementDelegate = self;

    }
    return _segementView;
}

- (UIScrollView *)scrollView{

    if (!_scrollView) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.segementView.bottom, self.width, self.height - self.segementView.bottom)];
        _scrollView.delegate = self;
        _scrollView.bounces = NO;
        _scrollView.pagingEnabled = YES;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.contentSize = CGSizeMake(_scrollView.width*self.segementControllers.count, _scrollView.height);
        
        for (int i = 0; i < self.segementControllers.count; i++) {
            
            if (![self.segementControllers[i] isKindOfClass:[UIViewController class]]) {
                continue ;
            }
            
            UIViewController *vc = self.segementControllers[i];
            
            vc.view.frame = CGRectMake(_scrollView.width*i, 0, _scrollView.width, _scrollView.height);
            
            [_scrollView addSubview:vc.view];
        }
    }
    return _scrollView;
}

//- (void)dealloc{
//
//    NSLog(@"WWZSegementScrollView dealloc");
//}
@end

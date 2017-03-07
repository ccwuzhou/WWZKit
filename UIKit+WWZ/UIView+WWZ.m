//
//  UIView+WWZ.m
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import "UIView+WWZ.h"

#import <objc/runtime.h>
#pragma mark - 手势事件
@implementation UIView (GestureRecognizer)

/**
 *  点击
 */
static const char kTapBlock = '\0';
- (void)wwz_tapPeformBlock:(void(^)())block{
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    [self addGestureRecognizer:tap];
    if (block) {
        objc_setAssociatedObject(self, &kTapBlock, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

- (void)tap:(UITapGestureRecognizer *)tap{
    
    void(^voidBlock)() = objc_getAssociatedObject(self, &kTapBlock);
    if (voidBlock) {
        voidBlock();
    }
}
/**
 *  swipe
 */
static const char kSwipeBlock = '\1';
- (void)wwz_swipeDirection:(UISwipeGestureRecognizerDirection)direction peformBlock:(void(^)(UISwipeGestureRecognizer *swipe))block{
    
    UISwipeGestureRecognizer *swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(swipe:)];
    swipe.direction = direction;
    [self addGestureRecognizer:swipe];
    if (block) {
        objc_setAssociatedObject(self, &kSwipeBlock, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

- (void)swipe:(UISwipeGestureRecognizer *)swipe{
    
    void(^swipeBlock)(UISwipeGestureRecognizer *swipe) = objc_getAssociatedObject(self, &kSwipeBlock);
    if (swipeBlock) {
        swipeBlock(swipe);
    }
}

/**
 *  长按
 */
static const char kLongPressBlock = '\2';
- (void)wwz_longPressPeformBlock:(void(^)(UILongPressGestureRecognizer *longPress))block{
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    [self addGestureRecognizer:longPress];
    if (block) {
        objc_setAssociatedObject(self, &kLongPressBlock, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

- (void)longPress:(UILongPressGestureRecognizer *)longPress{
    
    void(^voidBlock)(UILongPressGestureRecognizer *longPress) = objc_getAssociatedObject(self, &kLongPressBlock);
    if (voidBlock) {
        voidBlock(longPress);
    }
}

/**
 *  pan
 */
static const char kPanBlock = '\3';
- (void)wwz_panPeformBlock:(void(^)(UIPanGestureRecognizer *pan))block{
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self addGestureRecognizer:pan];
    if (block) {
        objc_setAssociatedObject(self, &kPanBlock, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}

- (void)pan:(UIPanGestureRecognizer *)pan{
    
    void(^voidBlock)(UIPanGestureRecognizer *pan) = objc_getAssociatedObject(self, &kPanBlock);
    if (voidBlock) {
        voidBlock(pan);
    }
}

#pragma mark - launch image

/**
 *  获取启动图片并保持
 *
 *  @param duration duration后启动图片消失
 *
 *  @return 启动图片
 */
+ (UIImageView *)wwz_launchImageAnimateWithDuration:(NSTimeInterval)duration{
    
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    
    NSString *viewOrientation = @"Portrait";    //横屏请设置成 @"Landscape"
    
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        viewOrientation = @"Landscape";
        viewSize = CGSizeMake(viewSize.height, viewSize.width);
    }
    NSString *launchImage = nil;
    NSArray* imagesDict = [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    
    for (NSDictionary* dict in imagesDict){
        
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        
        if (CGSizeEqualToSize(imageSize, viewSize) && [viewOrientation isEqualToString:dict[@"UILaunchImageOrientation"]]){
            
            launchImage = dict[@"UILaunchImageName"];
        }
    }
    UIImageView *launchView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:launchImage]];
    launchView.frame = [UIScreen mainScreen].bounds;
    launchView.contentMode = UIViewContentModeScaleAspectFill;
    [[UIApplication sharedApplication].keyWindow addSubview:launchView];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        [self wwz_dismissLaunchImageView:launchView];
    });
    return launchView;
}

/**
 *  启动图片消失动画
 *
 *  @param launchView 启动图片
 */
+ (void)wwz_dismissLaunchImageView:(UIView *)launchView{
    
    [UIView animateWithDuration:0.5f delay:0.0f options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        
        launchView.alpha = 0.0f;
        launchView.layer.transform = CATransform3DScale(CATransform3DIdentity, 1.2, 1.2, 1);
        
    } completion:^(BOOL finished) {
        
        [launchView removeFromSuperview];
    }];
    
}


@end

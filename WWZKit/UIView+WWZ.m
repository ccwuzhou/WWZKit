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

@implementation UITableView (WWZ)

+ (instancetype)wwz_tableViewWithFrame:(CGRect)frame dataSource:(id <UITableViewDataSource>)dataSource delegate:(id <UITableViewDelegate>)delegate{
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:frame];
    tableView.delegate = delegate;
    tableView.dataSource = dataSource;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = [UIColor clearColor];
    
    return tableView;
}
////去掉 UItableview headerview 黏性(sticky)
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    if (scrollView == self.tableView)
//    {
//        CGFloat sectionHeaderHeight = 30; //sectionHeaderHeight
//        if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//        } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//        }
//    }
//}
@end

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


@implementation UINavigationBar (WWZ)

- (void)wwz_setBackgroundColor:(UIColor *)color{
    
    self.barTintColor = color;
    //    self.translucent = NO;
    [self setShadowImage:nil];
}

- (void)wwz_setTitleColor:(UIColor *)titleColor titleFont:(UIFont *)titleFont{
    
    // 设置导航条标题的字体和颜色
    [self setTitleTextAttributes:@{NSForegroundColorAttributeName:titleColor,NSFontAttributeName:titleFont}];
}

- (void)wwz_noShadowImage{
    //去掉导航栏下面黑线
    if ([self respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
        
        for (id obj in self.subviews){
            
            if ([UIDevice currentDevice].systemVersion.floatValue >= 10.0){//10.0的系统字段不一样
                
                UIView *view = (UIView*)obj;
                for (id obj2 in view.subviews) {
                    
                    if ([obj2 isKindOfClass:[UIImageView class]]) {
                        
                        UIImageView *image =  (UIImageView*)obj2;
                        image.hidden = YES;
                    }
                }
            }else{
                
                if ([obj isKindOfClass:[UIImageView class]]){
                    
                    UIImageView *imageView=(UIImageView *)obj;
                    NSArray *list2=imageView.subviews;
                    
                    for (id obj2 in list2){
                        
                        if ([obj2 isKindOfClass:[UIImageView class]]){
                            
                            UIImageView *imageView2=(UIImageView *)obj2;
                            imageView2.hidden=YES;
                        }
                    }
                }
            }
        }
    }
}

@end

@implementation UIImageView (WWZ)


+ (instancetype)wwz_imageViewWithImageName:(NSString *)imageName contentMode:(UIViewContentMode)contentMode{
    
    return [self wwz_imageViewWithFrame:CGRectZero imageName:imageName contentMode:contentMode];
    
}


+ (instancetype)wwz_imageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName contentMode:(UIViewContentMode)contentMode{
    
    UIImageView *imageView = [[self alloc] initWithImage:[UIImage imageNamed:imageName]];
    
    if (!CGRectEqualToRect(frame, CGRectZero)) {
        imageView.frame = frame;
    }
    imageView.contentMode = contentMode;
    
    return imageView;
}

/**
 *  圆形imageView
 *
 *  @param frame       frame
 *  @param imageName   imageName
 *  @param borderWidth borderWidth
 *  @param borderColor borderColor
 *
 *  @return 圆形imageView
 */
+ (instancetype)wwz_imageViewWithFrame:(CGRect)frame imageName:(NSString *)imageName borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor
{
    UIImageView *imageView = [self wwz_imageViewWithFrame:frame imageName:imageName contentMode:UIViewContentModeScaleAspectFit];
    
    imageView.layer.masksToBounds = YES;
    imageView.layer.cornerRadius = MIN(imageView.frame.size.width, imageView.frame.size.height)*0.5;
    imageView.layer.borderWidth = borderWidth;
    imageView.layer.borderColor = borderColor.CGColor;
    
    
    return imageView;
}
@end

@implementation UILabel (WWZ)

/**
 *  自适应尺寸的label
 */
+ (UILabel *)wwz_labelWithText:(NSString *)text font:(UIFont *)font tColor:(UIColor *)tColor alignment:(NSTextAlignment)alignment numberOfLines:(NSInteger)numberOfLines{
    
    UILabel *label = [self wwz_labelWithFrame:CGRectZero text:text font:font tColor:tColor alignment:alignment numberOfLines:numberOfLines];
    [label sizeToFit];
    return label;
}

/**
 *  给定frame的一行label
 */
+ (UILabel *)wwz_labelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font tColor:(UIColor *)tColor alignment:(NSTextAlignment)alignment{
    
    return [self wwz_labelWithFrame:frame text:text font:font tColor:tColor alignment:alignment numberOfLines:1];
}
/**
 *  给定frame的label
 */
+ (UILabel *)wwz_labelWithFrame:(CGRect)frame text:(NSString *)text font:(UIFont *)font tColor:(UIColor *)tColor alignment:(NSTextAlignment)alignment numberOfLines:(NSInteger)numberOfLines{
    
    UILabel *label = [[self alloc] initWithFrame:frame];
    label.text = text;
    label.font = font;
    label.textColor = tColor;
    label.textAlignment = alignment;
    label.numberOfLines = numberOfLines;
    
    return label;
}
/**
 *  自适应
 */
- (void)wwz_sizeToFitWithMaxSize:(CGSize)maxSize{
    
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rectToFit = [self.text boundingRectWithSize:maxSize options:options attributes:@{NSFontAttributeName:self.font} context:nil];
    CGSize sizeToFit = CGSizeMake(ceilf(rectToFit.size.width)+2, ceilf(rectToFit.size.height));
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, sizeToFit.width, sizeToFit.height*0.6);
}



@end

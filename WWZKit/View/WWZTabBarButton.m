//
//  BCTabBarButton.m
//  BCSmart
//
//  Created by wwz on 16/7/16.
//  Copyright © 2016年 cn.zgkjd. All rights reserved.
//

#import "WWZTabBarButton.h"

@implementation WWZTabBarItem
@end

@interface UIImage (ColorToImage)

+ (instancetype)wwz_imageWithColor:(UIColor *)color size:(CGSize)size alpha:(float)alpha;

@end

#pragma mark - WWZBadgeView

#define WZBadgeViewFont [UIFont systemFontOfSize:10]

#define kColorFromRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

static int const WZBadgeViewWidth = 15;
static int const WZBadgeViewNoTitleWidth = 10;

@interface WWZBadgeView : UIButton

@property (nonatomic, copy) NSString *badgeValue;

@property (nonatomic, strong) UIColor *badgeColor;
@end

@implementation WWZBadgeView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = NO;
        
        _badgeColor = [UIColor redColor];
        
        [self setBackgroundImage:[UIImage wwz_imageWithColor:self.badgeColor size:CGSizeMake(WZBadgeViewWidth, WZBadgeViewWidth) alpha:1] forState:UIControlStateNormal];
        
        // 设置字体大小
        self.titleLabel.font = WZBadgeViewFont;
        
        [self sizeToFit];
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = MIN(self.bounds.size.height, self.bounds.size.width)*0.5;
        self.hidden = YES;
    }
    return self;
}

- (void)setBadgeValue:(NSString *)badgeValue{
    
    _badgeValue = badgeValue;
    
    // 判断badgeValue是否有内容
    if (badgeValue.length == 0 || [badgeValue isEqualToString:@"0"]) { // 没有内容或者空字符串,等于0
        self.hidden = YES;
    }else{
        self.hidden = NO;
    }
    
    CGSize size = [badgeValue sizeWithAttributes:@{NSFontAttributeName: WZBadgeViewFont}];

    if (size.width > self.frame.size.width) { // 文字的尺寸大于控件的宽度
        [self setBackgroundImage:[UIImage wwz_imageWithColor:self.badgeColor size:CGSizeMake(WZBadgeViewNoTitleWidth, WZBadgeViewNoTitleWidth) alpha:1] forState:UIControlStateNormal];
        [self setTitle:nil forState:UIControlStateNormal];

        [self sizeToFit];
    }else{
        [self setBackgroundImage:[UIImage wwz_imageWithColor:self.badgeColor size:CGSizeMake(WZBadgeViewWidth, WZBadgeViewWidth) alpha:1] forState:UIControlStateNormal];
        [self setTitle:badgeValue forState:UIControlStateNormal];

    }
    self.layer.cornerRadius = MIN(self.bounds.size.height, self.bounds.size.width)*0.5;
}

- (void)setBadgeColor:(UIColor *)badgeColor{
    
    if (!badgeColor) return;
    
    _badgeColor = badgeColor;
    
    [self setBadgeValue:_badgeValue];
    
}

@end


#pragma mark - WWZTabBarButton

#define WZTabBarButtonFont [UIFont systemFontOfSize:12]

static CGFloat const kImageScale = 0.7;

@interface WWZTabBarButton ()

@property (nonatomic, weak) WWZBadgeView *badgeView;

@end

@implementation WWZTabBarButton

+ (instancetype)wwz_tabBarButtonWithItem:(WWZTabBarItem *)item{
    
    WWZTabBarButton *barButton = [self buttonWithType:UIButtonTypeCustom];
    
    barButton.item = item;
    
    return barButton;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // 设置字体颜色
        [self setNTitleColor:kColorFromRGBA(128, 128, 128, 1) sTitleColor:kColorFromRGBA(255, 255, 255, 1)];
        
        // 设置背景颜色
        [self setNBackgroundColor:[UIColor whiteColor] sBackgroundColor:kColorFromRGBA(104, 129, 192, 1)];
        
        // 图片居中
        self.imageView.contentMode = UIViewContentModeCenter;
        
        // 文字居中
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        
        // 设置文字字体
        self.titleLabel.font = WZTabBarButtonFont;
        
    }
    return self;
}



- (void)setItem:(WWZTabBarItem *)item{
    
    if (_item) {
        // KVO
        for (NSString *keyPath in [self keyPaths]) {
            
            [_item removeObserver:self forKeyPath:keyPath];
        }
    }
    
    _item = item;
    
    // 初始设置一次
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    
    // KVO
    for (NSString *keyPath in [self keyPaths]) {
        
        [_item addObserver:self forKeyPath:keyPath options:NSKeyValueObservingOptionNew context:nil];
    }
}

/**
 *  title color
 */
- (void)setNTitleColor:(UIColor *)nTitleColor sTitleColor:(UIColor *)sTitleColor{

    if (nTitleColor) {
        [self setTitleColor:nTitleColor forState:UIControlStateNormal];
    }
    if (sTitleColor) {
        [self setTitleColor:sTitleColor forState:UIControlStateSelected];
    }
}

/**
 *  background color
 */
- (void)setNBackgroundColor:(UIColor *)nBackgroundColor sBackgroundColor:(UIColor *)sBackgroundColor{
    
    if (nBackgroundColor) {
        [self setBackgroundImage:[UIImage wwz_imageWithColor:nBackgroundColor size:CGSizeMake(1, 1) alpha:1] forState:UIControlStateNormal];
    }
    
    if (sBackgroundColor) {
        [self setBackgroundImage:[UIImage wwz_imageWithColor:sBackgroundColor size:CGSizeMake(1, 1) alpha:1] forState:UIControlStateSelected];
    }
}


// 重写setHighlighted，取消高亮做的事情
- (void)setHighlighted:(BOOL)highlighted{}

#pragma mark - kvo
// 只要监听的属性一有新值，就会调用
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{
    
    if (_item.title) {
        [self setTitle:_item.title forState:UIControlStateNormal];
    }
    
    if (_item.image) {
        [self setImage:_item.image forState:UIControlStateNormal];
    }
    
    if (_item.selectedImage) {
        [self setImage:_item.selectedImage forState:UIControlStateSelected];
    }
    
    if (_item.titleColor) {
        [self setTitleColor:_item.titleColor forState:UIControlStateNormal];
    }
    
    if (_item.selectedTitleColor) {
        [self setTitleColor:_item.selectedTitleColor forState:UIControlStateSelected];
    }
    
    if (_item.titleFont) {
        self.titleLabel.font = _item.titleFont;
    }
    
    if (_item.backgroundColor) {
        [self setBackgroundImage:[UIImage wwz_imageWithColor:_item.backgroundColor size:CGSizeMake(1, 1) alpha:1] forState:UIControlStateNormal];
    }
    
    if (_item.selectedBackgroundColor) {
        [self setBackgroundImage:[UIImage wwz_imageWithColor:_item.selectedBackgroundColor size:CGSizeMake(1, 1) alpha:1] forState:UIControlStateSelected];
    }
    
    if (_item.badgeValue) {
        self.badgeView.badgeValue = _item.badgeValue;
    }
    
    if (_item.badgeNColor) {
        self.badgeView.badgeColor = _item.badgeNColor;
    }
//    NSDictionary *nDict = [_item titleTextAttributesForState:UIControlStateNormal];
//    NSDictionary *sDict = [_item titleTextAttributesForState:UIControlStateSelected];
//    
//    [self setNTitleColor:nDict[NSForegroundColorAttributeName] sTitleColor:sDict[NSForegroundColorAttributeName]];
//    self.titleLabel.font = nDict[NSFontAttributeName];
}

#pragma mark - getter

// 懒加载badgeView
- (WWZBadgeView *)badgeView
{
    if (!_badgeView) {
        
        WWZBadgeView *btn = [WWZBadgeView buttonWithType:UIButtonTypeCustom];
        
        [self addSubview:btn];
        
        _badgeView = btn;
    }
    
    return _badgeView;
}

- (NSArray *)keyPaths{
    
    return @[@"title", @"image", @"selectedImage", @"badgeValue", @"titleFont", @"titleColor", @"selectedTitleColor", @"backgroundColor", @"selectedBackgroundColor", @"badgeNColor"];
}


// 修改按钮内部子控件的frame
- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 1.imageView
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageW = self.bounds.size.width;
    CGFloat imageH = self.bounds.size.height * kImageScale;
    self.imageView.frame = CGRectMake(imageX, imageY, imageW, imageH);
    
    
    // 2.title
    CGFloat titleX = 0;
    CGFloat titleY = imageH - 3;
    CGFloat titleW = self.bounds.size.width;
    CGFloat titleH = self.bounds.size.height - titleY;
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    // 3.badgeView
    CGRect badgeFrame = self.badgeView.frame;
    badgeFrame.origin.x = self.frame.size.width - badgeFrame.size.width - 10;
    badgeFrame.origin.y = 0;
    self.badgeView.frame = badgeFrame;
}

- (void)dealloc{
    
    // KVO
    for (NSString *keyPath in [self keyPaths]) {
    
        [_item removeObserver:self forKeyPath:keyPath];
    }
}
@end


@implementation UIImage (ColorToImage)

+ (instancetype)wwz_imageWithColor:(UIColor *)color size:(CGSize)size alpha:(float)alpha{
    
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetAlpha(context, alpha);
    CGContextSetFillColorWithColor(context,color.CGColor);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end

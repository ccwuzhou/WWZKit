//
//  UIView+WWZ.m
//  wwz_objc
//
//  Created by wwz on 17/3/6.
//  Copyright © 2017年 tijio. All rights reserved.
//

#import "UIView+WWZ.h"

#import <objc/runtime.h>

@implementation UIView (WWZ)

- (void)setX:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX{
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY{
    return self.center.y;
}

- (void)setWidth:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)width{
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (CGFloat)height{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size{
    
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size{
    return self.frame.size;
}
- (void)setOrigin:(CGPoint)origin{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin{
    return self.frame.origin;
}
- (CGFloat)bottom{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom: (CGFloat)bottom{
    CGRect newframe = self.frame;
    newframe.origin.y = bottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat)right{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right{
    CGRect newframe = self.frame;
    newframe.origin.x = right - self.frame.size.width;
    self.frame = newframe;
}

#pragma mark - Other Origin
- (void)setBottomRight:(CGPoint)bottomRight{
    
    CGRect newframe = self.frame;
    newframe.origin.x = bottomRight.x-self.width;
    newframe.origin.y = bottomRight.y-self.height;
    self.frame = newframe;
}

- (CGPoint)bottomRight{
    
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (void)setBottomLeft:(CGPoint)bottomLeft{
    
    CGRect newframe = self.frame;
    newframe.origin.x = bottomLeft.x;
    newframe.origin.y = bottomLeft.y-self.height;
    self.frame = newframe;
}

- (CGPoint)bottomLeft{
    
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (void)setTopRight:(CGPoint)topRight{
    
    CGRect newframe = self.frame;
    newframe.origin.x = topRight.x-self.width;
    newframe.origin.y = topRight.y;
    self.frame = newframe;
}

- (CGPoint)topRight{
    
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}


#pragma mark - Relative
- (void)wwz_alignRight:(CGFloat)rightOffset{
    
    if (!self.superview) {
        return;
    }
    self.right = self.superview.width - rightOffset;
}

- (void)wwz_alignBottom:(CGFloat)bottomOffset{
    
    if (!self.superview) {
        return;
    }
    self.bottom = self.superview.height - bottomOffset;
}

- (void)wwz_alignCenter{
    
    if (!self.superview) {
        return;
    }
    self.origin = CGPointMake((self.superview.width-self.width)/2, (self.superview.height-self.height)/2);
}

- (void)wwz_alignCenterX{
    
    if (!self.superview) {
        return;
    }
    self.x = (self.superview.width-self.width)/2;
}

- (void)wwz_alignCenterY{
    
    if (!self.superview) {
        return;
    }
    self.y = (self.superview.height-self.height/2);
}
- (instancetype)initWithFrame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor
{
    self = [self initWithFrame:frame];
    if (self) {
        self.backgroundColor = backgroundColor;
    }
    return self;
}
@end

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



@end

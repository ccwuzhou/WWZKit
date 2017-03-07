//
//  WWZSwipeTableCell.m
//  wwz
//
//  Created by wwz on 16/8/11.
//  Copyright © 2016年 cn.szwwz. All rights reserved.
//

#import "WWZSwipeTableCell.h"

#pragma mark Input Overlay Helper Class
/** Used to capture table input while swipe buttons are visible*/

@interface WZSwipeTableOverlayView : UIView

@property (nonatomic, weak) WWZSwipeTableCell *currentCell;

@end

@implementation WZSwipeTableOverlayView

- (id)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]){
        self.backgroundColor = [UIColor clearColor];
        self.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    }
    return self;
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
    
    if (!_currentCell){
        [self removeFromSuperview];
        return nil;
    }
    CGPoint p = [self convertPoint:point toView:_currentCell];
    if (_currentCell.hidden || CGRectContainsPoint(_currentCell.bounds, p)){
        return nil;
    }
    BOOL hide = YES;
    if (_currentCell.swipeDelegate && [_currentCell.swipeDelegate respondsToSelector:@selector(swipeTableCell:shouldHideSwipeOnTap:)]){
        hide = [_currentCell.swipeDelegate swipeTableCell:_currentCell shouldHideSwipeOnTap:p];
    }
    if (hide){
        [_currentCell hideSwipeAnimated:YES];
    }
    return _currentCell.touchOnDismissSwipe ? nil : self;
}

@end

#pragma mark Button Container View and transitions

@interface WZSwipeButtonsView : UIView

@property (nonatomic, weak) WWZSwipeTableCell * cell;
@property (nonatomic, strong) UIColor *backgroundColorCopy;

@end

@implementation WZSwipeButtonsView
{
    NSArray * _buttons;
    UIView * _containerView;
    BOOL _fromLeft;
    UIView * _expandedButton;
    UIView * _expandedButtonAnimated;
    UIView * _expansionBackground;
    UIView * _expansionBackgroundAnimated;
    CGRect _expandedButtonBoundsCopy;
    WWZSwipeExpansionLayout _expansionLayout;
    CGFloat _expansionOffset;
    BOOL _autoHideExpansion;
}
/**
 *  button container view
 *
 *  @param buttons        buttons
 *  @param direction      swipe direction
 *  @param differentWidth button is same width or not
 *
 *  @return WZSwipeButtonsView
 */
- (instancetype)initWithButtons:(NSArray *)buttons direction:(WWZSwipeDirection)direction differentWidth:(BOOL)differentWidth{
    
    // 总宽度
    CGFloat containerWidth = 0;
    // buttons 中最大size
    CGSize maxSize = CGSizeZero;
    
    for (UIView *button in buttons){
        containerWidth += button.bounds.size.width;
        maxSize.width = MAX(maxSize.width, button.bounds.size.width);
        maxSize.height = MAX(maxSize.height, button.bounds.size.height);
    }
    
    if (!differentWidth){// same width
        containerWidth = maxSize.width * buttons.count;
    }
    
    if (self = [super initWithFrame:CGRectMake(0, 0, containerWidth, maxSize.height)]){
        
        _fromLeft = direction == WWZSwipeDirectionLeftToRight;
        
        // container view
        _containerView = [[UIView alloc] initWithFrame:self.bounds];
        _containerView.clipsToBounds = YES;
        _containerView.backgroundColor = [UIColor clearColor];
        [self addSubview:_containerView];
        
        // button sort
        _buttons = _fromLeft ? buttons: [[buttons reverseObjectEnumerator] allObjects];
        
        for (UIView * button in _buttons){
            if ([button isKindOfClass:[UIButton class]]){
                UIButton *btn = (UIButton*)button;
                [btn removeTarget:nil action:@selector(mgButtonClicked:) forControlEvents:UIControlEventTouchUpInside]; //Remove all targets to avoid problems with reused buttons among many cells
                [btn addTarget:self action:@selector(mgButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
            }
            if (!differentWidth){
                button.frame = CGRectMake(0, 0, maxSize.width, maxSize.height);
            }
            [_containerView insertSubview:button atIndex: _fromLeft ? 0: _containerView.subviews.count];
        }
        [self resetButtons];
    }
    return self;
}
/**
 *  layout buttons
 */
- (void)resetButtons{
    
    CGFloat offsetX = 0;
    for (UIView * button in _buttons){
        button.frame = CGRectMake(offsetX, 0, button.bounds.size.width, self.bounds.size.height);
        button.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        offsetX += button.bounds.size.width;
    }
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    if (_expandedButton){
        [self layoutExpansion:_expansionOffset];
    }else {
        _containerView.frame = self.bounds;
    }
}
- (void)dealloc{
    
    for (UIView * button in _buttons){
        if ([button isKindOfClass:[UIButton class]]){
            [(UIButton *)button removeTarget:self action:@selector(mgButtonClicked:)forControlEvents:UIControlEventTouchUpInside];
        }
    }
}



- (void)layoutExpansion:(CGFloat)offset{
    
    _expansionOffset = offset;
    _containerView.frame = CGRectMake(_fromLeft ? 0: self.bounds.size.width - offset, 0, offset, self.bounds.size.height);
    if (_expansionBackgroundAnimated && _expandedButtonAnimated){
        _expansionBackgroundAnimated.frame = [self expansionBackgroundRect:_expandedButtonAnimated];
    }
}



- (CGRect)expansionBackgroundRect: (UIView *)button
{
    CGFloat extra = 100.0f; //extra size to avoid expansion background size issue on iOS 7.0
    if (_fromLeft){
        return CGRectMake(-extra, 0, button.frame.origin.x + extra, _containerView.bounds.size.height);
    }
    else {
        return CGRectMake(button.frame.origin.x +  button.bounds.size.width, 0,
                          _containerView.bounds.size.width - (button.frame.origin.x + button.bounds.size.width )+ extra
                          ,_containerView.bounds.size.height);
    }
    
}

- (void)expandToOffset:(CGFloat)offset settings:(WWZSwipeExpansionSettings*)settings
{
    if (settings.buttonIndex < 0 || settings.buttonIndex >= _buttons.count){
        return;
    }
    if (!_expandedButton){
        _expandedButton = [_buttons objectAtIndex: _fromLeft ? settings.buttonIndex : _buttons.count - settings.buttonIndex - 1];
        CGRect previusRect = _containerView.frame;
        [self layoutExpansion:offset];
        [self resetButtons];
        if (!_fromLeft){ //Fix expansion animation for right buttons
            for (UIView * button in _buttons){
                CGRect frame = button.frame;
                frame.origin.x += _containerView.bounds.size.width - previusRect.size.width;
                button.frame = frame;
            }
        }
        _expansionBackground = [[UIView alloc] initWithFrame:[self expansionBackgroundRect:_expandedButton]];
        _expansionBackground.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        if (settings.expansionColor){
            _backgroundColorCopy = _expandedButton.backgroundColor;
            _expandedButton.backgroundColor = settings.expansionColor;
        }
        _expansionBackground.backgroundColor = _expandedButton.backgroundColor;
        if (UIColor.clearColor == _expandedButton.backgroundColor){
            // Provides access to more complex content for display on the background
            _expansionBackground.layer.contents = _expandedButton.layer.contents;
        }
        [_containerView addSubview:_expansionBackground];
        _expansionLayout = settings.expansionLayout;
        
        CGFloat duration = _fromLeft ? _cell.leftExpansion.animationDuration : _cell.rightExpansion.animationDuration;
        [UIView animateWithDuration: duration delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _expandedButton.hidden = NO;
            
            if (_expansionLayout == WWZSwipeExpansionLayoutCenter){
                _expandedButtonBoundsCopy = _expandedButton.bounds;
                _expandedButton.layer.mask = nil;
                _expandedButton.layer.transform = CATransform3DIdentity;
                _expandedButton.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
                [_expandedButton.superview bringSubviewToFront:_expandedButton];
                _expandedButton.frame = _containerView.bounds;
            }
            else if (_fromLeft){
                _expandedButton.frame = CGRectMake(_containerView.bounds.size.width - _expandedButton.bounds.size.width, 0, _expandedButton.bounds.size.width, _expandedButton.bounds.size.height);
                _expandedButton.autoresizingMask|= UIViewAutoresizingFlexibleLeftMargin;
            }
            else {
                _expandedButton.frame = CGRectMake(0, 0, _expandedButton.bounds.size.width, _expandedButton.bounds.size.height);
                _expandedButton.autoresizingMask|= UIViewAutoresizingFlexibleRightMargin;
            }
            _expansionBackground.frame = [self expansionBackgroundRect:_expandedButton];
            
        } completion:^(BOOL finished){
        }];
        return;
    }
    [self layoutExpansion:offset];
}

- (void)endExpansionAnimated:(BOOL)animated
{
    if (_expandedButton){
        _expandedButtonAnimated = _expandedButton;
        if (_expansionBackgroundAnimated && _expansionBackgroundAnimated != _expansionBackground){
            [_expansionBackgroundAnimated removeFromSuperview];
        }
        _expansionBackgroundAnimated = _expansionBackground;
        _expansionBackground = nil;
        _expandedButton = nil;
        if (_backgroundColorCopy){
            _expansionBackgroundAnimated.backgroundColor = _backgroundColorCopy;
            _expandedButtonAnimated.backgroundColor = _backgroundColorCopy;
            _backgroundColorCopy = nil;
        }
        CGFloat duration = _fromLeft ? _cell.leftExpansion.animationDuration : _cell.rightExpansion.animationDuration;
        [UIView animateWithDuration: animated ? duration : 0.0 delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            _containerView.frame = self.bounds;
            if (_expansionLayout == WWZSwipeExpansionLayoutCenter){
                _expandedButtonAnimated.frame = _expandedButtonBoundsCopy;
            }
            [self resetButtons];
            _expansionBackgroundAnimated.frame = [self expansionBackgroundRect:_expandedButtonAnimated];
        } completion:^(BOOL finished){
            [_expansionBackgroundAnimated removeFromSuperview];
        }];
    }
    else if (_expansionBackground){
        [_expansionBackground removeFromSuperview];
        _expansionBackground = nil;
    }
}

- (UIView*)getExpandedButton
{
    return _expandedButton;
}

#pragma mark Trigger Actions

- (BOOL)handleClick: (id)sender fromExpansion:(BOOL)fromExpansion
{
    bool autoHide = false;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
    
    if ([sender respondsToSelector:@selector(callWZSwipeConvenienceCallback:)]){
        //call convenience block callback if exits (usage of WWZSwipeButton class is not compulsory)
        autoHide = [sender performSelector:@selector(callWZSwipeConvenienceCallback:)withObject:_cell];
    }
#pragma clang diagnostic pop
    
    if (_cell.swipeDelegate && [_cell.swipeDelegate respondsToSelector:@selector(swipeTableCell:tappedButtonAtIndex:direction:fromExpansion:)]){
        NSInteger index = [_buttons indexOfObject:sender];
        if (!_fromLeft){
            index = _buttons.count - index - 1; //right buttons are reversed
        }
        autoHide|= [_cell.swipeDelegate swipeTableCell:_cell tappedButtonAtIndex:index direction:_fromLeft ? WWZSwipeDirectionLeftToRight : WWZSwipeDirectionRightToLeft fromExpansion:fromExpansion];
    }
    
    if (fromExpansion && autoHide){
        _expandedButton = nil;
        _cell.swipeOffset = 0;
    }
    else if (autoHide){
        [_cell hideSwipeAnimated:YES];
    }
    
    return autoHide;
    
}
//button listener
- (void)mgButtonClicked: (id)sender
{
    [self handleClick:sender fromExpansion:NO];
}


#pragma mark Transitions

- (void)transitionStatic:(CGFloat)t
{
    const CGFloat dx = self.bounds.size.width * (1.0 - t);
    CGFloat offsetX = 0;
    
    for (UIView *button in _buttons){
        CGRect frame = button.frame;
        frame.origin.x = offsetX + (_fromLeft ? dx : -dx);
        button.frame = frame;
        offsetX += frame.size.width;
    }
}

- (void)transitionDrag:(CGFloat)t
{
    //No Op, nothing to do ;)
}

- (void)transitionClip:(CGFloat)t
{
    CGFloat selfWidth = self.bounds.size.width;
    CGFloat offsetX = 0;
    
    for (UIView *button in _buttons){
        CGRect frame = button.frame;
        CGFloat dx = roundf(frame.size.width * 0.5 * (1.0 - t));
        frame.origin.x = _fromLeft ? (selfWidth - frame.size.width - offsetX)* (1.0 - t)+ offsetX + dx : offsetX * t - dx;
        button.frame = frame;
        
        if (_buttons.count > 1){
            CAShapeLayer *maskLayer = [CAShapeLayer new];
            CGRect maskRect = CGRectMake(dx - 0.5, 0, frame.size.width - 2 * dx + 1.5, frame.size.height);
            CGPathRef path = CGPathCreateWithRect(maskRect, NULL);
            maskLayer.path = path;
            CGPathRelease(path);
            button.layer.mask = maskLayer;
        }
        
        offsetX += frame.size.width;
    }
}

- (void)transtitionFloatBorder:(CGFloat)t
{
    CGFloat selfWidth = self.bounds.size.width;
    CGFloat offsetX = 0;
    
    for (UIView *button in _buttons){
        CGRect frame = button.frame;
        frame.origin.x = _fromLeft ? (selfWidth - frame.size.width - offsetX)* (1.0 - t)+ offsetX : offsetX * t;
        button.frame = frame;
        offsetX += frame.size.width;
    }
}

- (void)transition3D:(CGFloat)t
{
    const CGFloat invert = _fromLeft ? 1.0 : -1.0;
    const CGFloat angle = M_PI_2 * (1.0 - t)* invert;
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1.0/400.0f; //perspective 1/z
    const CGFloat dx = -_containerView.bounds.size.width * 0.5 * invert;
    const CGFloat offset = dx * 2 * (1.0 - t);
    transform = CATransform3DTranslate(transform, dx - offset, 0, 0);
    transform = CATransform3DRotate(transform, angle, 0.0, 1.0, 0.0);
    transform = CATransform3DTranslate(transform, -dx, 0, 0);
    _containerView.layer.transform = transform;
}

- (void)transition:(WWZSwipeTransition)mode percent:(CGFloat)t
{
    switch (mode){
        case WWZSwipeTransitionStatic: [self transitionStatic:t]; break;
        case WWZSwipeTransitionDrag: [self transitionDrag:t]; break;
        case WWZSwipeTransitionClipCenter: [self transitionClip:t]; break;
        case WWZSwipeTransitionBorder: [self transtitionFloatBorder:t]; break;
        case WWZSwipeTransitionRotate3D: [self transition3D:t]; break;
    }
    if (_expandedButtonAnimated && _expansionBackgroundAnimated){
        _expansionBackgroundAnimated.frame = [self expansionBackgroundRect:_expandedButtonAnimated];
    }
}

@end

#pragma mark Easing Functions and WWZSwipeAnimation Class

static inline CGFloat mgEaseLinear(CGFloat t, CGFloat b, CGFloat c){
    return c*t + b;
}

static inline CGFloat mgEaseInQuad(CGFloat t, CGFloat b, CGFloat c){
    return c*t*t + b;
}
static inline CGFloat mgEaseOutQuad(CGFloat t, CGFloat b, CGFloat c){
    return -c*t*(t-2)+ b;
}
static inline CGFloat mgEaseInOutQuad(CGFloat t, CGFloat b, CGFloat c){
    if ((t*=2)< 1)return c/2*t*t + b;
    --t;
    return -c/2 * (t*(t-2)- 1)+ b;
}
static inline CGFloat mgEaseInCubic(CGFloat t, CGFloat b, CGFloat c){
    return c*t*t*t + b;
}
static inline CGFloat mgEaseOutCubic(CGFloat t, CGFloat b, CGFloat c){
    --t;
    return c*(t*t*t + 1)+ b;
}
static inline CGFloat mgEaseInOutCubic(CGFloat t, CGFloat b, CGFloat c){
    if ((t*=2)< 1)return c/2*t*t*t + b;
    t-=2;
    return c/2*(t*t*t + 2)+ b;
}
static inline CGFloat mgEaseOutBounce(CGFloat t, CGFloat b, CGFloat c){
    if (t < (1/2.75)){
        return c*(7.5625*t*t)+ b;
    } else if (t < (2/2.75)){
        t-=(1.5/2.75);
        return c*(7.5625*t*t + .75)+ b;
    } else if (t < (2.5/2.75)){
        t-=(2.25/2.75);
        return c*(7.5625*t*t + .9375)+ b;
    } else {
        t-=(2.625/2.75);
        return c*(7.5625*t*t + .984375)+ b;
    }
};
static inline CGFloat mgEaseInBounce(CGFloat t, CGFloat b, CGFloat c){
    return c - mgEaseOutBounce (1.0 -t, 0, c)+ b;
};

static inline CGFloat mgEaseInOutBounce(CGFloat t, CGFloat b, CGFloat c){
    if (t < 0.5)return mgEaseInBounce (t*2, 0, c)* .5 + b;
    return mgEaseOutBounce (1.0 - t*2, 0, c)* .5 + c*.5 + b;
};
@implementation WWZSwipeAnimation

- (instancetype)init {
    if (self = [super init]){
        _duration = 0.3;
        _easingFunction = WWZSwipeEasingFunctionCubicOut;
    }
    return self;
}

- (CGFloat)value:(CGFloat)elapsed duration:(CGFloat)duration from:(CGFloat)from to:(CGFloat)to{
    
    CGFloat t = MIN(elapsed/duration, 1.0f);
    if (t == 1.0){
        return to; //precise last value
    }
    CGFloat (*easingFunction)(CGFloat t, CGFloat b, CGFloat c)= 0;
    switch (_easingFunction){
        case WWZSwipeEasingFunctionLinear: easingFunction = mgEaseLinear; break;
        case WWZSwipeEasingFunctionQuadIn: easingFunction = mgEaseInQuad; break;
        case WWZSwipeEasingFunctionQuadOut: easingFunction = mgEaseOutQuad; break;
        case WWZSwipeEasingFunctionQuadInOut: easingFunction = mgEaseInOutQuad; break;
        case WWZSwipeEasingFunctionCubicIn: easingFunction = mgEaseInCubic; break;
        case WWZSwipeEasingFunctionCubicOut: easingFunction = mgEaseOutCubic; break;
        case WWZSwipeEasingFunctionCubicInOut: easingFunction = mgEaseInOutCubic; break;
        case WWZSwipeEasingFunctionBounceIn: easingFunction = mgEaseInBounce; break;
        case WWZSwipeEasingFunctionBounceOut: easingFunction = mgEaseOutBounce; break;
        case WWZSwipeEasingFunctionBounceInOut: easingFunction = mgEaseInOutBounce; break;
        default:break;
    }
    return (*easingFunction)(t, from, to - from);
}

@end

#pragma mark Settings Classes

@implementation WWZSwipeSettings

- (instancetype)init{
    
    if (self = [super init]){
        self.transition = WWZSwipeTransitionStatic;
        self.threshold = 0.5;
        self.offset = 0;
        self.keepButtonsSwiped = YES;
        self.enableSwipeBounces = YES;
        self.showAnimation = [[WWZSwipeAnimation alloc] init];
        self.hideAnimation = [[WWZSwipeAnimation alloc] init];
        self.stretchAnimation = [[WWZSwipeAnimation alloc] init];
    }
    return self;
}

- (void)setAnimationDuration:(CGFloat)duration{
    
    _showAnimation.duration = duration;
    _hideAnimation.duration = duration;
    _stretchAnimation.duration = duration;
}

- (CGFloat)animationDuration {
    return _showAnimation.duration;
}

@end

@implementation WWZSwipeExpansionSettings

- (instancetype)init{
    if (self = [super init]){
        self.buttonIndex = -1;
        self.threshold = 1.3;
        self.animationDuration = 0.2;
        self.triggerAnimation = [[WWZSwipeAnimation alloc] init];
    }
    return self;
}
@end

@interface WZSwipeAnimationData : NSObject
@property (nonatomic, assign) CGFloat from;
@property (nonatomic, assign) CGFloat to;
@property (nonatomic, assign) CFTimeInterval duration;
@property (nonatomic, assign) CFTimeInterval start;
@property (nonatomic, strong) WWZSwipeAnimation *animation;

@end

@implementation WZSwipeAnimationData
@end


#pragma mark WWZSwipeTableCell Implementation

@implementation WWZSwipeTableCell
{
    UITapGestureRecognizer * _tapRecognizer;
    UIPanGestureRecognizer * _panRecognizer;
    CGPoint _panStartPoint;
    CGFloat _panStartOffset;
    CGFloat _targetOffset;
    
    UIView * _swipeOverlay;
    UIImageView * _swipeImageView;
    UIView * _swipeContentView;
    WZSwipeButtonsView * _leftView;
    WZSwipeButtonsView * _rightView;
    bool _allowSwipeRightToLeft;
    bool _allowSwipeLeftToRight;
    __weak WZSwipeButtonsView * _activeExpansion;
    
    WZSwipeTableOverlayView * _tableInputOverlay;
    bool _overlayEnabled;
    __weak UITableView * _cachedParentTable;
    UITableViewCellSelectionStyle _previusSelectionStyle;
    NSMutableSet * _previusHiddenViews;
    BOOL _triggerStateChanges;
    
    WZSwipeAnimationData * _animationData;
    void (^_animationCompletion)(BOOL finished);
    CADisplayLink * _displayLink;
    WWZSwipeState _firstSwipeState;
}

#pragma mark View creation & layout

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self){
        [self initViews:YES];
    }
    return self;
}

- (id)initWithCoder:(NSCoder*)aDecoder{
    
    if(self = [super initWithCoder:aDecoder]){
        [self initViews:YES];
    }
    return self;
}

- (void)awakeFromNib{
    
    [super awakeFromNib];
    
    if (!_panRecognizer){
        [self initViews:YES];
    }
}

- (void)dealloc{
    [self hideSwipeOverlayIfNeeded];
}

- (void)initViews:(BOOL)cleanButtons{
    
    if (cleanButtons){
        _leftButtons = [NSArray array];
        _rightButtons = [NSArray array];
        _leftSwipeSettings = [[WWZSwipeSettings alloc] init];
        _rightSwipeSettings = [[WWZSwipeSettings alloc] init];
        _leftExpansion = [[WWZSwipeExpansionSettings alloc] init];
        _rightExpansion = [[WWZSwipeExpansionSettings alloc] init];
    }
    _animationData = [[WZSwipeAnimationData alloc] init];
    
    _panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panHandler:)];
    _panRecognizer.delegate = self;
    [self addGestureRecognizer:_panRecognizer];
    
    
    _activeExpansion = nil;
    _previusHiddenViews = [NSMutableSet set];
    _swipeState = WWZSwipeStateNone;
    _triggerStateChanges = YES;
    _allowsSwipeWhenTappingButtons = YES;
    _preservesSelectionStatus = NO;
    _allowsOppositeSwipe = YES;
    _firstSwipeState = WWZSwipeStateNone;
    
}

- (void)cleanViews{
    
    [self hideSwipeAnimated:NO];
    if (_displayLink){
        [_displayLink invalidate];
        _displayLink = nil;
    }
    if (_swipeOverlay){
        [_swipeOverlay removeFromSuperview];
        _swipeOverlay = nil;
    }
    _leftView = _rightView = nil;
    if (_panRecognizer){
        _panRecognizer.delegate = nil;
        [self removeGestureRecognizer:_panRecognizer];
        _panRecognizer = nil;
    }
}

- (BOOL)isRTLLocale
{
    if ([[UIView class] instancesRespondToSelector:@selector(userInterfaceLayoutDirectionForSemanticContentAttribute:)]){
        return [UIView userInterfaceLayoutDirectionForSemanticContentAttribute:self.semanticContentAttribute] == UIUserInterfaceLayoutDirectionRightToLeft;
    }
    else {
        return [UIApplication sharedApplication].userInterfaceLayoutDirection == UIUserInterfaceLayoutDirectionRightToLeft;
    }
}

- (void)fixRegionAndAccesoryViews
{
    //Fix right to left layout direction for arabic and hebrew languagues
    if (self.bounds.size.width != self.contentView.bounds.size.width && [self isRTLLocale]){
        _swipeOverlay.frame = CGRectMake(-self.bounds.size.width + self.contentView.bounds.size.width, 0, _swipeOverlay.bounds.size.width, _swipeOverlay.bounds.size.height);
    }
}

- (UIView *)swipeContentView
{
    if (!_swipeContentView){
        _swipeContentView = [[UIView alloc] initWithFrame:self.contentView.bounds];
        _swipeContentView.backgroundColor = [UIColor clearColor];
        _swipeContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _swipeContentView.layer.zPosition = 9;
        [self.contentView addSubview:_swipeContentView];
    }
    return _swipeContentView;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    if (_swipeContentView){
        _swipeContentView.frame = self.contentView.bounds;
    }
    if (_swipeOverlay){
        CGSize prevSize = _swipeImageView.bounds.size;
        _swipeOverlay.frame = CGRectMake(0, 0, self.bounds.size.width, self.contentView.bounds.size.height);
        [self fixRegionAndAccesoryViews];
        if (_swipeImageView.image &&  !CGSizeEqualToSize(prevSize, _swipeOverlay.bounds.size)){
            //refresh contentView in situations like layout change, orientation chage, table resize, etc.
            [self refreshContentView];
        }
    }
}

- (void)fetchButtonsIfNeeded
{
    if (_leftButtons.count == 0 && _swipeDelegate && [_swipeDelegate respondsToSelector:@selector(swipeTableCell:swipeButtonsForDirection:swipeSettings:expansionSettings:)]){
        _leftButtons = [_swipeDelegate swipeTableCell:self swipeButtonsForDirection:WWZSwipeDirectionLeftToRight swipeSettings:_leftSwipeSettings expansionSettings:_leftExpansion];
    }
    if (_rightButtons.count == 0 && _swipeDelegate && [_swipeDelegate respondsToSelector:@selector(swipeTableCell:swipeButtonsForDirection:swipeSettings:expansionSettings:)]){
        _rightButtons = [_swipeDelegate swipeTableCell:self swipeButtonsForDirection:WWZSwipeDirectionRightToLeft swipeSettings:_rightSwipeSettings expansionSettings:_rightExpansion];
    }
}
/**
 *  add swipe view
 */
- (void)createSwipeViewIfNeeded{
    
    if (!_swipeOverlay){
        _swipeOverlay = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        
        [self fixRegionAndAccesoryViews];
        
        _swipeOverlay.hidden = YES;
        _swipeOverlay.backgroundColor = [self backgroundColorForSwipe];
        _swipeOverlay.layer.zPosition = 10; //force render on top of the contentView;
        
        _swipeImageView = [[UIImageView alloc] initWithFrame:_swipeOverlay.bounds];
        _swipeImageView.autoresizingMask =  UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _swipeImageView.contentMode = UIViewContentModeCenter;
        _swipeImageView.clipsToBounds = YES;
        
        [_swipeOverlay addSubview:_swipeImageView];
        
        [self.contentView addSubview:_swipeOverlay];
    }
    
    // 得到buttons
    [self fetchButtonsIfNeeded];
    
    // left
    if (!_leftView && _leftButtons.count > 0){
        _leftView = [[WZSwipeButtonsView alloc] initWithButtons:_leftButtons direction:WWZSwipeDirectionLeftToRight differentWidth:_allowsButtonsWithDifferentWidth];
        _leftView.cell = self;
        _leftView.frame = CGRectMake(-_leftView.bounds.size.width, _leftSwipeSettings.topMargin, _leftView.bounds.size.width, _swipeOverlay.bounds.size.height - _leftSwipeSettings.topMargin - _leftSwipeSettings.bottomMargin);
        _leftView.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleHeight;
        [_swipeOverlay addSubview:_leftView];
    }
    // right
    if (!_rightView && _rightButtons.count > 0){
        _rightView = [[WZSwipeButtonsView alloc] initWithButtons:_rightButtons direction:WWZSwipeDirectionRightToLeft differentWidth:_allowsButtonsWithDifferentWidth];
        _rightView.cell = self;
        _rightView.frame = CGRectMake(_swipeOverlay.bounds.size.width, _rightSwipeSettings.topMargin, _rightView.bounds.size.width, _swipeOverlay.bounds.size.height - _rightSwipeSettings.topMargin - _rightSwipeSettings.bottomMargin);
        _rightView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight;
        [_swipeOverlay addSubview:_rightView];
    }
}


- (void)showSwipeOverlayIfNeeded
{
    if (_overlayEnabled){
        return;
    }
    _overlayEnabled = YES;
    
    if (!_preservesSelectionStatus)
        self.selected = NO;
    if (_swipeContentView)
        [_swipeContentView removeFromSuperview];
    if (_swipeDelegate && [_swipeDelegate respondsToSelector:@selector(swipeTableCellWillBeginSwiping:)]){
        [_swipeDelegate swipeTableCellWillBeginSwiping:self];
    }
    _swipeImageView.image = [self imageFromView:self];
    _swipeOverlay.hidden = NO;
    if (_swipeContentView)
        [_swipeImageView addSubview:_swipeContentView];
    
    if (!_allowsMultipleSwipe){
        //input overlay on the whole table
        UITableView * table = [self parentTable];
        if (_tableInputOverlay){
            [_tableInputOverlay removeFromSuperview];
        }
        _tableInputOverlay = [[WZSwipeTableOverlayView alloc] initWithFrame:table.bounds];
        _tableInputOverlay.currentCell = self;
        [table addSubview:_tableInputOverlay];
    }
    
    _previusSelectionStyle = self.selectionStyle;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    [self setAccesoryViewsHidden:YES];
    
    _tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapHandler:)];
    _tapRecognizer.cancelsTouchesInView = YES;
    _tapRecognizer.delegate = self;
    [self addGestureRecognizer:_tapRecognizer];
}

- (void)hideSwipeOverlayIfNeeded
{
    if (!_overlayEnabled){
        return;
    }
    _overlayEnabled = NO;
    _swipeOverlay.hidden = YES;
    _swipeImageView.image = nil;
    if (_swipeContentView){
        [_swipeContentView removeFromSuperview];
        [self.contentView addSubview:_swipeContentView];
    }
    
    if (_tableInputOverlay){
        [_tableInputOverlay removeFromSuperview];
        _tableInputOverlay = nil;
    }
    
    self.selectionStyle = _previusSelectionStyle;
    NSArray * selectedRows = self.parentTable.indexPathsForSelectedRows;
    if ([selectedRows containsObject:[self.parentTable indexPathForCell:self]]){
        self.selected = NO; //Hack: in some iOS versions setting the selected property to YES own isn't enough to force the cell to redraw the chosen selectionStyle
        self.selected = YES;
    }
    [self setAccesoryViewsHidden:NO];
    
    if (_swipeDelegate && [_swipeDelegate respondsToSelector:@selector(swipeTableCellWillEndSwiping:)]){
        [_swipeDelegate swipeTableCellWillEndSwiping:self];
    }
    
    if (_tapRecognizer){
        [self removeGestureRecognizer:_tapRecognizer];
        _tapRecognizer = nil;
    }
}

- (void)refreshContentView
{
    CGFloat currentOffset = _swipeOffset;
    BOOL prevValue = _triggerStateChanges;
    _triggerStateChanges = NO;
    self.swipeOffset = 0;
    self.swipeOffset = currentOffset;
    _triggerStateChanges = prevValue;
}

- (void)refreshButtons: (BOOL)usingDelegate
{
    if (usingDelegate){
        self.leftButtons = @[];
        self.rightButtons = @[];
    }
    if (_leftView){
        [_leftView removeFromSuperview];
        _leftView = nil;
    }
    if (_rightView){
        [_rightView removeFromSuperview];
        _rightView = nil;
    }
    [self createSwipeViewIfNeeded];
    [self refreshContentView];
}

#pragma mark Handle Table Events

- (void)willMoveToSuperview:(UIView *)newSuperview;
{
    if (newSuperview == nil){ //remove the table overlay when a cell is removed from the table
        [self hideSwipeOverlayIfNeeded];
    }
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [self cleanViews];
    if (_swipeState != WWZSwipeStateNone){
        _triggerStateChanges = YES;
        [self updateState:WWZSwipeStateNone];
    }
    BOOL cleanButtons = _swipeDelegate && [_swipeDelegate respondsToSelector:@selector(swipeTableCell:swipeButtonsForDirection:swipeSettings:expansionSettings:)];
    [self initViews:cleanButtons];
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    if (editing){ //disable swipe buttons when the user sets table editing mode
        self.swipeOffset = 0;
    }
}

- (void)setEditing:(BOOL)editing
{
    [super setEditing:YES];
    if (editing){ //disable swipe buttons when the user sets table editing mode
        self.swipeOffset = 0;
    }
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (!self.hidden && _swipeOverlay && !_swipeOverlay.hidden){
        //override hitTest to give swipe buttons a higher priority (diclosure buttons can steal input)
        UIView * targets[] = {_leftView, _rightView};
        for (int i = 0; i< 2; ++i){
            UIView * target = targets[i];
            if (!target)continue;
            
            CGPoint p = [self convertPoint:point toView:target];
            if (CGRectContainsPoint(target.bounds, p)){
                return [target hitTest:p withEvent:event];
            }
        }
    }
    return [super hitTest:point withEvent:event];
}

#pragma mark Some utility methods

- (UIImage *)imageFromView:(UIView *)view {
    UIGraphicsBeginImageContextWithOptions(view.bounds.size, NO, [[UIScreen mainScreen] scale]);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage * image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

- (void)setAccesoryViewsHidden: (BOOL)hidden
{
    if (self.accessoryView){
        self.accessoryView.hidden = hidden;
    }
    for (UIView * view in self.contentView.superview.subviews){
        if (view != self.contentView && ([view isKindOfClass:[UIButton class]] || [NSStringFromClass(view.class)rangeOfString:@"Disclosure"].location != NSNotFound)){
            view.hidden = hidden;
        }
    }
    
    for (UIView * view in self.contentView.subviews){
        if (view == _swipeOverlay || view == _swipeContentView)continue;
        if (hidden && !view.hidden){
            view.hidden = YES;
            [_previusHiddenViews addObject:view];
        }
        else if (!hidden && [_previusHiddenViews containsObject:view]){
            view.hidden = NO;
        }
    }
    
    if (!hidden){
        [_previusHiddenViews removeAllObjects];
    }
}

- (UIColor *)backgroundColorForSwipe{
    
    if (_swipeBackgroundColor){
        
        return _swipeBackgroundColor; //user defined color
        
    }else if (self.contentView.backgroundColor && ![self.contentView.backgroundColor isEqual:[UIColor clearColor]]){
        
        return self.contentView.backgroundColor;
    }else if (self.backgroundColor){
        
        return self.backgroundColor;
    }
    return [UIColor clearColor];
}

- (UITableView *)parentTable
{
    if (_cachedParentTable){
        return _cachedParentTable;
    }
    
    UIView * view = self.superview;
    while(view != nil){
        if([view isKindOfClass:[UITableView class]]){
            _cachedParentTable = (UITableView*)view;
        }
        view = view.superview;
    }
    return _cachedParentTable;
}

- (void)updateState: (WWZSwipeState)newState;
{
    if (!_triggerStateChanges || _swipeState == newState){
        return;
    }
    _swipeState = newState;
    if (_swipeDelegate && [_swipeDelegate respondsToSelector:@selector(swipeTableCell:didChangeSwipeState:gestureIsActive:)]){
        [_swipeDelegate swipeTableCell:self didChangeSwipeState:_swipeState gestureIsActive: self.isSwipeGestureActive] ;
    }
}

#pragma mark Swipe Animation

- (void)setSwipeOffset:(CGFloat)newOffset;
{
    CGFloat sign = newOffset > 0 ? 1.0 : -1.0;
    WZSwipeButtonsView * activeButtons = sign < 0 ? _rightView : _leftView;
    WWZSwipeSettings * activeSettings = sign < 0 ? _rightSwipeSettings : _leftSwipeSettings;
    
    if(activeSettings.enableSwipeBounces){
        _swipeOffset = newOffset;
    }
    else {
        CGFloat maxOffset = sign * activeButtons.bounds.size.width;
        _swipeOffset = sign > 0 ? MIN(newOffset, maxOffset): MAX(newOffset, maxOffset);
    }
    CGFloat offset = fabs(_swipeOffset);
    
    
    if (!activeButtons || offset == 0){
        if (_leftView)
            [_leftView endExpansionAnimated:NO];
        if (_rightView)
            [_rightView endExpansionAnimated:NO];
        [self hideSwipeOverlayIfNeeded];
        _targetOffset = 0;
        [self updateState:WWZSwipeStateNone];
        return;
    }
    else {
        [self showSwipeOverlayIfNeeded];
        CGFloat swipeThreshold = activeSettings.threshold;
        BOOL keepButtons = activeSettings.keepButtonsSwiped;
        _targetOffset = keepButtons && offset > activeButtons.bounds.size.width * swipeThreshold ? activeButtons.bounds.size.width * sign : 0;
    }
    
    BOOL onlyButtons = activeSettings.onlySwipeButtons;
    _swipeImageView.transform = CGAffineTransformMakeTranslation(onlyButtons ? 0 : _swipeOffset, 0);
    
    //animate existing buttons
    WZSwipeButtonsView* but[2] = {_leftView, _rightView};
    WWZSwipeSettings* settings[2] = {_leftSwipeSettings, _rightSwipeSettings};
    WWZSwipeExpansionSettings * expansions[2] = {_leftExpansion, _rightExpansion};
    
    for (int i = 0; i< 2; ++i){
        WZSwipeButtonsView * view = but[i];
        if (!view)continue;
        
        //buttons view position
        CGFloat translation = MIN(offset, view.bounds.size.width)* sign + settings[i].offset * sign;
        view.transform = CGAffineTransformMakeTranslation(translation, 0);
        
        if (view != activeButtons)continue; //only transition if active (perf. improvement)
        bool expand = expansions[i].buttonIndex >= 0 && offset > view.bounds.size.width * expansions[i].threshold;
        if (expand){
            [view expandToOffset:offset settings:expansions[i]];
            _targetOffset = expansions[i].fillOnTrigger ? self.bounds.size.width * sign : 0;
            _activeExpansion = view;
            [self updateState:i ? WWZSwipeStateExpandingRightToLeft : WWZSwipeStateExpandingLeftToRight];
        }
        else {
            [view endExpansionAnimated:YES];
            _activeExpansion = nil;
            CGFloat t = MIN(1.0f, offset/view.bounds.size.width);
            [view transition:settings[i].transition percent:t];
            [self updateState:i ? WWZSwipeStateSwipingRightToLeft : WWZSwipeStateSwipingLeftToRight];
        }
    }
}

- (void)hideSwipeAnimated: (BOOL)animated completion:(void(^)(BOOL finished))completion
{
    WWZSwipeAnimation * animation = animated ? (_swipeOffset > 0 ? _leftSwipeSettings.hideAnimation: _rightSwipeSettings.hideAnimation): nil;
    [self setSwipeOffset:0 animation:animation completion:completion];
}

- (void)hideSwipeAnimated: (BOOL)animated
{
    [self hideSwipeAnimated:animated completion:nil];
}

- (void)showSwipe: (WWZSwipeDirection)direction animated: (BOOL)animated
{
    [self showSwipe:direction animated:animated completion:nil];
}

- (void)showSwipe: (WWZSwipeDirection)direction animated: (BOOL)animated completion:(void(^)(BOOL finished))completion
{
    [self createSwipeViewIfNeeded];
    _allowSwipeLeftToRight = _leftButtons.count > 0;
    _allowSwipeRightToLeft = _rightButtons.count > 0;
    UIView * buttonsView = direction == WWZSwipeDirectionLeftToRight ? _leftView : _rightView;
    
    if (buttonsView){
        CGFloat s = direction == WWZSwipeDirectionLeftToRight ? 1.0 : -1.0;
        WWZSwipeAnimation * animation = animated ? (direction == WWZSwipeDirectionLeftToRight ? _leftSwipeSettings.showAnimation : _rightSwipeSettings.showAnimation): nil;
        [self setSwipeOffset:buttonsView.bounds.size.width * s animation:animation completion:completion];
    }
}

- (void)expandSwipe: (WWZSwipeDirection)direction animated: (BOOL)animated
{
    CGFloat s = direction == WWZSwipeDirectionLeftToRight ? 1.0 : -1.0;
    WWZSwipeExpansionSettings* expSetting = direction == WWZSwipeDirectionLeftToRight ? _leftExpansion : _rightExpansion;
    
    // only perform animation if there's no pending expansion animation and requested direction has fillOnTrigger enabled
    if(!_activeExpansion && expSetting.fillOnTrigger){
        [self createSwipeViewIfNeeded];
        _allowSwipeLeftToRight = _leftButtons.count > 0;
        _allowSwipeRightToLeft = _rightButtons.count > 0;
        UIView * buttonsView = direction == WWZSwipeDirectionLeftToRight ? _leftView : _rightView;
        
        if (buttonsView){
            __weak WZSwipeButtonsView * expansionView = direction == WWZSwipeDirectionLeftToRight ? _leftView : _rightView;
            __weak WWZSwipeTableCell * weakself = self;
            [self setSwipeOffset:buttonsView.bounds.size.width * s * expSetting.threshold * 2 animation:expSetting.triggerAnimation completion:^(BOOL finished){
                [expansionView endExpansionAnimated:YES];
                [weakself setSwipeOffset:0 animated:NO completion:nil];
            }];
        }
    }
}

- (void)animationTick: (CADisplayLink *)timer
{
    if (!_animationData.start){
        _animationData.start = timer.timestamp;
    }
    CFTimeInterval elapsed = timer.timestamp - _animationData.start;
    bool completed = elapsed >= _animationData.duration;
    if (completed){
        _triggerStateChanges = YES;
    }
    self.swipeOffset = [_animationData.animation value:elapsed duration:_animationData.duration from:_animationData.from to:_animationData.to];
    
    //call animation completion and invalidate timer
    if (completed){
        [timer invalidate];
        _displayLink = nil;
        if (_animationCompletion){
            _animationCompletion(YES);
            _animationCompletion = nil;
        }
    }
}
- (void)setSwipeOffset:(CGFloat)offset animated: (BOOL)animated completion:(void(^)(BOOL finished))completion
{
    WWZSwipeAnimation * animation = animated ? [[WWZSwipeAnimation alloc] init] : nil;
    [self setSwipeOffset:offset animation:animation completion:completion];
}

- (void)setSwipeOffset:(CGFloat)offset animation: (WWZSwipeAnimation *)animation completion:(void(^)(BOOL finished))completion
{
    if (_displayLink){
        [_displayLink invalidate];
        _displayLink = nil;
    }
    if (_animationCompletion){ //notify previous animation cancelled
        _animationCompletion(NO);
        _animationCompletion = nil;
    }
    if (offset !=0){
        [self createSwipeViewIfNeeded];
    }
    
    if (!animation){
        self.swipeOffset = offset;
        if (completion){
            completion(YES);
        }
        return;
    }
    
    _animationCompletion = completion;
    _triggerStateChanges = NO;
    _animationData.from = _swipeOffset;
    _animationData.to = offset;
    _animationData.duration = animation.duration;
    _animationData.start = 0;
    _animationData.animation = animation;
    _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(animationTick:)];
    [_displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

#pragma mark Gestures

- (void)cancelPanGesture
{
    if (_panRecognizer.state != UIGestureRecognizerStateEnded && _panRecognizer.state != UIGestureRecognizerStatePossible){
        _panRecognizer.enabled = NO;
        _panRecognizer.enabled = YES;
        if (self.swipeOffset){
            [self hideSwipeAnimated:YES];
        }
    }
}

- (void)tapHandler: (UITapGestureRecognizer *)recognizer
{
    BOOL hide = YES;
    if (_swipeDelegate && [_swipeDelegate respondsToSelector:@selector(swipeTableCell:shouldHideSwipeOnTap:)]){
        hide = [_swipeDelegate swipeTableCell:self shouldHideSwipeOnTap:[recognizer locationInView:self]];
    }
    if (hide){
        [self hideSwipeAnimated:YES];
    }
}

- (CGFloat)filterSwipe: (CGFloat)offset
{
    bool allowed = offset > 0 ? _allowSwipeLeftToRight : _allowSwipeRightToLeft;
    UIView * buttons = offset > 0 ? _leftView : _rightView;
    if (!buttons || ! allowed){
        offset = 0;
    }
    else if (!_allowsOppositeSwipe && _firstSwipeState == WWZSwipeStateSwipingLeftToRight && offset < 0){
        offset = 0;
    }
    else if (!_allowsOppositeSwipe && _firstSwipeState == WWZSwipeStateSwipingRightToLeft && offset > 0 ){
        offset = 0;
    }
    return offset;
}

- (void)panHandler: (UIPanGestureRecognizer *)gesture{
    
    CGPoint current = [gesture translationInView:self];
    
    if (gesture.state == UIGestureRecognizerStateBegan){
        if (!_preservesSelectionStatus) self.highlighted = NO;
        
        [self createSwipeViewIfNeeded];
        
        _panStartPoint = current;
        _panStartOffset = _swipeOffset;
        if (_swipeOffset != 0){
            _firstSwipeState = _swipeOffset > 0 ? WWZSwipeStateSwipingLeftToRight : WWZSwipeStateSwipingRightToLeft;
        }
        
        if (!_allowsMultipleSwipe){
            NSArray * cells = [self parentTable].visibleCells;
            for (WWZSwipeTableCell * cell in cells){
                if ([cell isKindOfClass:[WWZSwipeTableCell class]] && cell != self){
                    [cell cancelPanGesture];
                }
            }
        }
    }
    else if (gesture.state == UIGestureRecognizerStateChanged){
        CGFloat offset = _panStartOffset + current.x - _panStartPoint.x;
        if (_firstSwipeState == WWZSwipeStateNone){
            _firstSwipeState = offset > 0 ? WWZSwipeStateSwipingLeftToRight : WWZSwipeStateSwipingRightToLeft;
        }
        self.swipeOffset = [self filterSwipe:offset];
    }
    else {
        WZSwipeButtonsView * expansion = _activeExpansion;
        if (expansion){
            UIView * expandedButton = [expansion getExpandedButton];
            WWZSwipeExpansionSettings * expSettings = _swipeOffset > 0 ? _leftExpansion : _rightExpansion;
            UIColor * backgroundColor = nil;
            if (!expSettings.fillOnTrigger && expSettings.expansionColor){
                backgroundColor = expansion.backgroundColorCopy; //keep expansion background color
                expansion.backgroundColorCopy = expSettings.expansionColor;
            }
            [self setSwipeOffset:_targetOffset animation:expSettings.triggerAnimation completion:^(BOOL finished){
                if (!finished || self.hidden){
                    return; //cell might be hidden after a delete row animation without being deallocated (to be reused later)
                }
                BOOL autoHide = [expansion handleClick:expandedButton fromExpansion:YES];
                if (autoHide){
                    [expansion endExpansionAnimated:NO];
                }
                if (backgroundColor){
                    expandedButton.backgroundColor = backgroundColor;
                }
            }];
        }
        else {
            CGFloat velocity = [_panRecognizer velocityInView:self].x;
            CGFloat inertiaThreshold = 100.0; //points per second
            
            if (velocity > inertiaThreshold){
                _targetOffset = _swipeOffset < 0 ? 0 : (_leftView  && _leftSwipeSettings.keepButtonsSwiped ? _leftView.bounds.size.width : _targetOffset);
            }
            else if (velocity < -inertiaThreshold){
                _targetOffset = _swipeOffset > 0 ? 0 : (_rightView && _rightSwipeSettings.keepButtonsSwiped ? -_rightView.bounds.size.width : _targetOffset);
            }
            _targetOffset = [self filterSwipe:_targetOffset];
            WWZSwipeSettings * settings = _swipeOffset > 0 ? _leftSwipeSettings : _rightSwipeSettings;
            WWZSwipeAnimation * animation = nil;
            if (_targetOffset == 0){
                animation = settings.hideAnimation;
            }
            else if (fabs(_swipeOffset)> fabs(_targetOffset)){
                animation = settings.stretchAnimation;
            }
            else {
                animation = settings.showAnimation;
            }
            [self setSwipeOffset:_targetOffset animation:animation completion:nil];
        }
        
        _firstSwipeState = WWZSwipeStateNone;
    }
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    if (gestureRecognizer == _panRecognizer){
        
        if (self.isEditing){
            return NO; //do not swipe while editing table
        }
        
        CGPoint translation = [_panRecognizer translationInView:self];
        if (fabs(translation.y)> fabs(translation.x)){
            return NO; // user is scrolling vertically
        }
        if (_swipeImageView){
            CGPoint point = [_tapRecognizer locationInView:_swipeImageView];
            if (!CGRectContainsPoint(_swipeImageView.bounds, point)){
                return _allowsSwipeWhenTappingButtons; //user clicked outside the cell or in the buttons area
            }
        }
        
        if (_swipeOffset != 0.0){
            return YES; //already swiped, don't need to check buttons or canSwipe delegate
        }
        
        //make a decision according to existing buttons or using the optional delegate
        if (_swipeDelegate && [_swipeDelegate respondsToSelector:@selector(swipeTableCell:canSwipe:fromPoint:)]){
            CGPoint point = [_panRecognizer locationInView:self];
            _allowSwipeLeftToRight = [_swipeDelegate swipeTableCell:self canSwipe:WWZSwipeDirectionLeftToRight fromPoint:point];
            _allowSwipeRightToLeft = [_swipeDelegate swipeTableCell:self canSwipe:WWZSwipeDirectionRightToLeft fromPoint:point];
        }
        else if (_swipeDelegate && [_swipeDelegate respondsToSelector:@selector(swipeTableCell:canSwipe:)]){
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            _allowSwipeLeftToRight = [_swipeDelegate swipeTableCell:self canSwipe:WWZSwipeDirectionLeftToRight];
            _allowSwipeRightToLeft = [_swipeDelegate swipeTableCell:self canSwipe:WWZSwipeDirectionRightToLeft];
#pragma clang diagnostic pop
        }
        else {
            [self fetchButtonsIfNeeded];
            _allowSwipeLeftToRight = _leftButtons.count > 0;
            _allowSwipeRightToLeft = _rightButtons.count > 0;
        }
        
        return (_allowSwipeLeftToRight && translation.x > 0)|| (_allowSwipeRightToLeft && translation.x < 0);
    }
    else if (gestureRecognizer == _tapRecognizer){
        CGPoint point = [_tapRecognizer locationInView:_swipeImageView];
        return CGRectContainsPoint(_swipeImageView.bounds, point);
    }
    return YES;
}

- (BOOL)isSwipeGestureActive
{
    return _panRecognizer.state == UIGestureRecognizerStateBegan || _panRecognizer.state == UIGestureRecognizerStateChanged;
}

- (void)setSwipeBackgroundColor:(UIColor *)swipeBackgroundColor {
    _swipeBackgroundColor = swipeBackgroundColor;
    if (_swipeOverlay){
        _swipeOverlay.backgroundColor = swipeBackgroundColor;
    }
}

@end


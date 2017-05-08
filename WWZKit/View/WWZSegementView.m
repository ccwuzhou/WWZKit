//
//  WWZSegementView.m
//  Pods
//
//  Created by apple on 2017/5/4.
//
//

#import "WWZSegementView.h"
#import "UIView+WWZ.h"
#import "UIButton+WWZ.h"


@interface WWZSegementButton : UIButton

@end

@implementation WWZSegementButton

- (void)setHighlighted:(BOOL)highlighted{}

- (void)layoutSubviews{

    [super layoutSubviews];
    
    [self.titleLabel sizeToFit];
    
    [self.titleLabel wwz_alignCenter];
    
    [self.imageView wwz_alignCenter];
}

@end

@interface WWZSegementView ()

@property (nonatomic, strong) NSArray *titles;

@property (nonatomic, strong) UIButton *selButton;

@property (nonatomic, weak) UIView *lineView;

@end

@implementation WWZSegementView

static int const SEGEMENT_BUTTON_TAG = 99;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titles = titles;
        
        [self setContentView];
        
    }
    return self;
}

- (void)setContentView{

    self.showsHorizontalScrollIndicator = NO;
    self.showsVerticalScrollIndicator = NO;
    self.contentSize = self.size;
    self.scrollEnabled = NO;
    
    _lineHeight = 2;
    _lineYSpace = 5;
    
    [self addTitleButtons];
}


- (void)addTitleButtons{

    CGFloat buttonW = self.width / self.titles.count;
    
    for (int i = 0; i < self.titles.count; i++) {
        
        NSString *title = self.titles[i];
        
        WWZSegementButton *button = [WWZSegementButton wwz_buttonWithFrame:CGRectMake(i*buttonW, 0, buttonW, self.height) nTitle:title sTitle:title tFont:[UIFont systemFontOfSize:15] nColor:[UIColor blackColor] sColor:[UIColor redColor]];
        
        button.tag = SEGEMENT_BUTTON_TAG + i;
        [button addTarget:self action:@selector(clickButtonAtIndex:) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:button];
        
        if (i == 0) {
            
            button.selected = YES;
            _selButton = button;
        }
    }
}

- (void)reloadContentView{

    for (int i = 0; i < self.titles.count; i++) {
        
        UIButton *sender = [self viewWithTag:i+SEGEMENT_BUTTON_TAG];
        
        sender.frame = CGRectMake(i*self.cellWidth, 0, self.cellWidth, self.height);
        
        [self moveLineViewAnimation:NO];
    }
}

/**
 *  移动线
 */
- (void)moveLineViewAnimation:(BOOL)animate{

    if (self.segementType != WWZSegementTypeBottomLine) return;
    
    NSTimeInterval duration = animate ? 0.3 : 0;
    
    CGSize stringSize = [self p_stringSizeWithString:_selButton.currentTitle font:_selButton.font maxSize:_selButton.size];
    
    [UIView animateWithDuration:duration animations:^{
  
        self.lineView.width = stringSize.width;
        self.lineView.centerX = _selButton.centerX;
        self.lineView.y = (_selButton.height+stringSize.height)*0.5+self.lineYSpace;
    }];
}

#pragma mark - 点击事件
- (void)clickButtonAtIndex:(UIButton *)sender{

    if (sender == _selButton) return;
    
    _selButton.selected = NO;
    sender.selected = YES;
    _selButton = sender;
    
    // 移动线
    [self moveLineViewAnimation:YES];
    
    // 代理回调
    if ([self.segementDelegate respondsToSelector:@selector(segementView:clickButtonAtIndex:)]) {
        [self.segementDelegate segementView:self clickButtonAtIndex:(int)sender.tag - SEGEMENT_BUTTON_TAG];
    }
}


#pragma mark - 公有方法
/**
 *  设置类型
 */
- (void)setSegementType:(WWZSegementType)segementType{

    _segementType = segementType;
    
    if (self.segementType != WWZSegementTypeBottomLine) return;

    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _selButton.height-self.lineYSpace, 0, self.lineHeight)];
    lineView.backgroundColor = [UIColor redColor];
    [self addSubview:lineView];
    
    _lineView = lineView;
    
    [self moveLineViewAnimation:NO];
}

- (void)setFrame:(CGRect)frame{

    [super setFrame:frame];
    
    [self reloadContentView];
}

- (void)setHeight:(CGFloat)height{

    [super setHeight:height];
    
    [self reloadContentView];
}

/**
 *  单个cell宽
 */
- (void)setCellWidth:(CGFloat)cellWidth{
    
    _cellWidth = cellWidth;
    
    CGFloat contentWidth = self.titles.count*cellWidth;
    
    self.contentSize = CGSizeMake(contentWidth, self.height);
    
    self.scrollEnabled = self.width < contentWidth;
    
    [self reloadContentView];
}
/**
 *  底部线高
 */
- (void)setLineHeight:(CGFloat)lineHeight{

    _lineHeight = lineHeight;
    
    if (self.segementType == WWZSegementTypeBottomLine) {
        _lineView.height = self.lineHeight;
    }
}
/**
 *  底部线与文字的间隙
 */
- (void)setLineYSpace:(CGFloat)lineYSpace{

    _lineYSpace = lineYSpace;
    
    if (self.segementType == WWZSegementTypeBottomLine) {
        
        [self moveLineViewAnimation:NO];
    }
}
/**
 *  选中按钮
 */
- (void)selectCellAtIndex:(int)index{

    UIButton *sender = [self viewWithTag:index+SEGEMENT_BUTTON_TAG];
    
    if (sender == _selButton) return;
    
    _selButton.selected = NO;
    sender.selected = YES;
    _selButton = sender;
    
    [self moveLineViewAnimation:YES];
}

/**
 *  设置文字属性
 */
- (void)setTitleFont:(UIFont *)font nColor:(UIColor *)nColor sColor:(UIColor *)sColor{

    for (int i = 0; i < self.titles.count; i++) {
    
        UIButton *sender = [self viewWithTag:i+SEGEMENT_BUTTON_TAG];
        
        [sender wwz_setNColor:nColor sColor:sColor];
        [sender wwz_setTitleFont:font];
    }
    
    if (self.segementType == WWZSegementTypeBottomLine) {
    
        self.lineView.backgroundColor = sColor;
    }
}

/**
 *  设置背景图片，仅当WWZSegementTypeCustom时可用
 */
- (void)setNBImage:(UIImage *)nBImage sBImage:(UIImage *)sBImage{

    if (self.segementType != WWZSegementTypeCustom) return;
    
    
    for (int i = 0; i < self.titles.count; i++) {
        
        UIButton *sender = [self viewWithTag:i+SEGEMENT_BUTTON_TAG];
        
        [sender setImage:nBImage forState:UIControlStateNormal];
        [sender setImage:sBImage forState:UIControlStateSelected];
    }
}


#pragma mark - getter



#pragma mark - help
- (CGSize)p_stringSizeWithString:(NSString *)string font:(UIFont *)font maxSize:(CGSize)maxSize{
    
    if (!string) {
        return CGSizeZero;
    }
    NSStringDrawingOptions options =  NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading;
    CGRect rectToFit = [string boundingRectWithSize:maxSize options:options attributes:@{NSFontAttributeName:font} context:nil];
    
    // 向上取整
    return CGSizeMake(ceilf(rectToFit.size.width), ceilf(rectToFit.size.height));
}

//- (void)dealloc{
//    
//    NSLog(@"WWZSegementView dealloc");
//}
@end

//
//  WWZSegementView.h
//  Pods
//
//  Created by apple on 2017/5/4.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WWZSegementType) {
    WWZSegementTypeDefault,
    WWZSegementTypeBottomLine,
    WWZSegementTypeCustom,
};

@class WWZSegementView;

@protocol WWZSegementViewDelegate <NSObject>

- (void)segementView:(WWZSegementView *)segementView clickButtonAtIndex:(int)index;

@end

@interface WWZSegementView : UIScrollView

@property (nonatomic, weak) id<WWZSegementViewDelegate> segementDelegate;

/**
 *  设置类型
 */
@property (nonatomic, assign) WWZSegementType segementType;

/**
 *  单个cell宽
 */
@property (nonatomic, assign) CGFloat cellWidth;

/**
 *  底部线高
 */
@property (nonatomic, assign) CGFloat lineHeight;

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles;

/**
 *  选中按钮
 */
- (void)selectCellAtIndex:(int)index;

/**
 *  设置文字属性
 */
- (void)setTitleFont:(UIFont *)font nColor:(UIColor *)nColor sColor:(UIColor *)sColor;


/**
 *  设置背景图片，仅当WWZSegementTypeCustom时可用
 */
- (void)setNBImage:(UIImage *)nBImage sBImage:(UIImage *)sBImage;
@end

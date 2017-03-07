//
//  WWZTimePickerView.h
//  wwz
//
//  Created by wwz on 16/8/9.
//  Copyright © 2016年 cn.szwwz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WWZTimePickerView : UIPickerView

/**
 *  文字颜色
 */
@property (nonatomic, strong) UIColor *textColor;

/**
 *  文字字体大小
 */
@property (nonatomic, strong) UIFont *textFont;

/**
 *  列宽
 */
@property (nonatomic, assign) CGFloat componentWidth;

/**
 *  行高
 */
@property (nonatomic, assign) CGFloat rowHeight;

/**
 *  是否循环
 */
@property (nonatomic, assign) BOOL isCircle;

/**
 *  列标题
 */
@property (nonatomic, strong) NSArray *comonentTitles;

/**
 *  自定义pickView
 *
 *  @param frame          frame
 *  @param components     @[@[],@[]...]
 *  @param block          选中回调@{@(component):text}
 *
 *  @return pickView
 */
+ (instancetype)wwz_pickerViewWithFrame:(CGRect)frame components:(NSArray *)components didSelectedBlock:(void(^)(NSDictionary *result))block;

/**
 *  自定义pickView
 *
 *  @param frame          frame
 *  @param components     @[@[],@[]...]
 *  @param block          选中回调@{@(component):text}
 *
 *  @return pickView
 */
- (instancetype)initWithFrame:(CGRect)frame components:(NSArray *)components didSelectedBlock:(void(^)(NSDictionary *result))block;


@end

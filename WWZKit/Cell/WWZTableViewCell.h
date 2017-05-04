//
//  WWZTableViewCell.h
//  KJD
//
//  Created by appple on 15/10/16.
//  Copyright © 2015年 WL. All rights reserved.
//  自定义cell

#import <UIKit/UIKit.h>

// 注意：设置imageView的contentMode类型必须在layoutSubviews中设置才会生效

/**
 *  cell 类型
 */
typedef NS_OPTIONS(NSInteger, WWZTableViewCellStyle) {
    /**
     *  默认
     */
    WWZTableViewCellStyleDefault             = 0,
    /**
     *  下边子label
     */
    WWZTableViewCellStyleSubTitle            = 1 << 0,
    /**
     *  右边子label
     */
    WWZTableViewCellStyleRightTitle          = 1 << 1,
    /**
     *  右边switch
     */
    WWZTableViewCellStyleSwitchView          = 1 << 2,
    /**
     *  下边和右边子label
     */
    WWZTableViewCellStyleSubAndRightTitle    =(WWZTableViewCellStyleSubTitle|WWZTableViewCellStyleRightTitle),
    /**
     *  下边子label和右边switch
     */
    WWZTableViewCellStyleSubAndSwitchView    =(WWZTableViewCellStyleSubTitle|WWZTableViewCellStyleSwitchView),
};
@class WWZTableViewCell;

@protocol WWZTableViewCellDelegate <NSObject>

@optional

/**
 *  点击右边switch
 *
 *  @param cell cell
 *  @param isOn switch 状态
 */
- (void)tableViewCell:(WWZTableViewCell *)cell didChangeSwitch:(BOOL)isOn;

@end

@interface WWZTableViewCell : UITableViewCell

/**
 *  sublabel
 */
@property (nonatomic, weak, readonly) UILabel *subLabel;

/**
 *  右边label
 */
@property (nonatomic, weak, readonly) UILabel *rightLabel;

/**
 *  右边switch
 */
@property (nonatomic, weak, readonly) UISwitch *mySwitch;

/**
 *  底部分割线
 */
@property (nonatomic, weak, readonly) UIView *lineView;

/**
 *  textLabel与subLabel的间距,default is 5.0
 */
@property (nonatomic, assign) CGFloat titleSpaceH;

/**
 *  是否为最后一行cell，最后一行cell线宽==cell宽度
 */
@property (nonatomic, assign) BOOL isLastCell;


@property (nonatomic, weak) id<WWZTableViewCellDelegate> delegate;

/**
 *  WWZTableViewCell
 *
 *  @param tableView UITableView
 *  @param style     WWZTableViewCellStyle
 *
 *  @return WWZTableViewCell
 */
+ (instancetype)wwz_cellWithTableView:(UITableView *)tableView style:(WWZTableViewCellStyle)style;

/**
 *  WWZTableViewCell
 *
 *  @param style           WWZTableViewCellStyle
 *  @param reuseIdentifier reuseIdentifier
 *
 *  @return WWZTableViewCell
 */
- (instancetype)initWithCellStyle:(WWZTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end

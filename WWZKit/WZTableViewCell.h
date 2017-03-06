//
//  WZTableViewCell.h
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
typedef NS_OPTIONS(NSInteger, WZTableViewCellStyle) {
    /**
     *  默认
     */
    WZTableViewCellStyleDefault             = 0,
    /**
     *  下边子label
     */
    WZTableViewCellStyleSubTitle            = 1 << 0,
    /**
     *  右边子label
     */
    WZTableViewCellStyleRightTitle          = 1 << 1,
    /**
     *  右边switch
     */
    WZTableViewCellStyleSwitchView          = 1 << 2,
    /**
     *  下边和右边子label
     */
    WZTableViewCellStyleSubAndRightTitle    =(WZTableViewCellStyleSubTitle|WZTableViewCellStyleRightTitle),
    /**
     *  下边子label和右边switch
     */
    WZTableViewCellStyleSubAndSwitchView    =(WZTableViewCellStyleSubTitle|WZTableViewCellStyleSwitchView),
};
@class WZTableViewCell;

@protocol WZTableViewCellDelegate <NSObject>

@optional

/**
 *  点击右边switch
 *
 *  @param cell cell
 *  @param isOn switch 状态
 */
- (void)tableViewCell:(WZTableViewCell *)cell didChangeSwitch:(BOOL)isOn;

@end

@interface WZTableViewCell : UITableViewCell

/**
 *  sublabel
 */
@property (nonatomic, strong, readonly) UILabel *subLabel;

/**
 *  右边label
 */
@property (nonatomic, strong, readonly) UILabel *rightLabel;

/**
 *  右边switch
 */
@property (nonatomic, strong, readonly) UISwitch *mySwitch;

/**
 *  底部分割线
 */
@property (nonatomic, strong, readonly) UIView *lineView;

/**
 *  textLabel与subLabel的间距,default is 5.0
 */
@property (nonatomic, assign) CGFloat titleSpaceH;

/**
 *  是否为最后一行cell，最后一行cell线宽==cell宽度
 */
@property (nonatomic, assign) BOOL isLastCell;


@property (nonatomic, weak) id<WZTableViewCellDelegate> delegate;

/**
 *  WZTableViewCell
 *
 *  @param tableView UITableView
 *  @param style     WZTableViewCellStyle
 *
 *  @return WZTableViewCell
 */
+ (instancetype)wwz_cellWithTableView:(UITableView *)tableView style:(WZTableViewCellStyle)style;

/**
 *  WZTableViewCell
 *
 *  @param style           WZTableViewCellStyle
 *  @param reuseIdentifier reuseIdentifier
 *
 *  @return WZTableViewCell
 */
- (instancetype)initWithCellStyle:(WZTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end

//
//  WZTableViewCell.m
//  KJD
//
//  Created by appple on 15/10/16.
//  Copyright © 2015年 WL. All rights reserved.
//

#import "WZTableViewCell.h"

#define kRightSpacing (self.accessoryType == UITableViewCellAccessoryNone ? 16.0 : 0)

#define kColorFromRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]

#define kCellBgColor kColorFromRGBA(255, 255, 255, 1)

#define kCellSelectBgColor kColorFromRGBA(217, 217, 217, 1)

// title color
#define kTitleColor kColorFromRGBA(51, 51, 51, 1)
// subTitle color
#define kSubTitleColor kColorFromRGBA(153, 153, 153, 1)
// rightTitle color
#define kRightTitleColor kColorFromRGBA(153, 153, 153, 1)
// 分割线 color
#define kBottomLineColor kColorFromRGBA(0, 0, 0, 0.1)
// switch on color
#define kDefaultThemeColor kColorFromRGBA(51, 184, 252, 1)

#define kTitleFont (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? [UIFont systemFontOfSize:21]:[UIFont systemFontOfSize:16])

#define kSubTitleFont (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? [UIFont systemFontOfSize:18]:[UIFont systemFontOfSize:14])

#define kRightTitleFont (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? [UIFont systemFontOfSize:18]:[UIFont systemFontOfSize:14])

#define kDefaultImageViewX (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 25.0 : 15.0)

#define kDefaultImageViewY (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 15.0 : 7.0)

//#define kRightAccessorySwitchWidth ([UIScreen mainScreen].bounds.size.width == 414.0 ? 71 : 66)

static float const kBottomLineHeight = 0.5;

@interface WZTableViewCell ()


@end

@implementation WZTableViewCell

/**
 *  为只读属性生成成员变量
 */
@synthesize lineView = _lineView;
@synthesize subLabel = _subLabel;
@synthesize rightLabel = _rightLabel;
@synthesize mySwitch = _mySwitch;


+ (instancetype)wwz_cellWithTableView:(UITableView *)tableView style:(WZTableViewCellStyle)style{
    
    static NSString *reuseIdentifier = @"reuseCellID";
    WZTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (!cell) {
        cell = [[self alloc] initWithCellStyle:style reuseIdentifier:reuseIdentifier];
    }
    return cell;
}

- (instancetype)initWithCellStyle:(WZTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        // 设置cell
        [self setUpCell];
        
        // 根据类型添加视图
        switch (style) {
            case WZTableViewCellStyleDefault:{
                
            }
                break;
            case WZTableViewCellStyleSubTitle:{
                
                [self.contentView addSubview:self.subLabel];
            }
                break;
            case WZTableViewCellStyleRightTitle:{
                
                [self.contentView addSubview:self.rightLabel];
            }
                break;
                
            case WZTableViewCellStyleSwitchView:{
                
                self.accessoryView = self.mySwitch;
            }
                break;
            case WZTableViewCellStyleSubAndRightTitle:{
                
                [self.contentView addSubview:self.subLabel];
                [self.contentView addSubview:self.rightLabel];
            }
                break;
            case WZTableViewCellStyleSubAndSwitchView:{
                
                [self.contentView addSubview:self.subLabel];
                self.accessoryView = self.mySwitch;
            }
                break;
                
            default:
                break;
        }
        
    }
    return self;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
    }
    return self;
}
/**
 *  设置cell
 */
- (void)setUpCell{
    
    self.backgroundColor = kCellBgColor;
    
    // textLabel
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.font = kTitleFont;
    self.textLabel.textColor = kTitleColor;
    
    //设置选中的背景
    self.selectedBackgroundView = [[UIView alloc] init];
    self.selectedBackgroundView.backgroundColor = kCellSelectBgColor;
    
    //设置cell的分隔线
    [self.contentView addSubview:self.lineView];
}

#pragma mark - getter
- (UIView *)lineView{
    
    if (!_lineView) {
        
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kBottomLineColor;
    }
    return _lineView;
}

- (UILabel *)subLabel{
    
    if (!_subLabel) {
        
        _titleSpaceH = 5;
        _subLabel = [[UILabel alloc] init];
        _subLabel.font = kSubTitleFont;
        _subLabel.textColor = kSubTitleColor;
        _subLabel.textAlignment = NSTextAlignmentLeft;
        _subLabel.numberOfLines = 1;
        
    }
    return _subLabel;
}

- (UILabel *)rightLabel{
    
    if (!_rightLabel) {
        
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.font = kRightTitleFont;
        _rightLabel.textColor = kRightTitleColor;
        _rightLabel.textAlignment = NSTextAlignmentRight;
        _rightLabel.numberOfLines = 1;
        
    }
    return _rightLabel;
}

- (UISwitch *)mySwitch{
    
    if (!_mySwitch) {
        
        _mySwitch = [[UISwitch alloc] init];
        _mySwitch.onTintColor = kDefaultThemeColor;
        [_mySwitch addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
    }
    return _mySwitch;
}

#pragma mark - 点击switch
- (void)changeSwitch:(UISwitch *)sender{
    
    if ([self.delegate respondsToSelector:@selector(tableViewCell:didChangeSwitch:)]) {
        [self.delegate tableViewCell:self didChangeSwitch:sender.on];
    }
}

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat height = self.frame.size.height;
    CGFloat width = self.frame.size.width;
    
    CGFloat contentViewW = self.contentView.frame.size.width;
    
    // imageView
    CGFloat imageWH = height-kDefaultImageViewY*2;
    
    CGSize imageSize = CGSizeMake(imageWH, imageWH);
    
    if (self.imageView.image) {
        
        if (self.imageView.image.size.width>imageSize.width||self.imageView.image.size.height>imageSize.height) {
            
            self.imageView.contentMode = UIViewContentModeScaleAspectFit;
            
        }else{
            
            self.imageView.contentMode = UIViewContentModeCenter;
            imageSize = self.imageView.image.size;
        }
        self.imageView.frame = (CGRect){{kDefaultImageViewX, (height-imageSize.height)*0.5}, imageSize};
    }
    
    // textLabel
    [self.textLabel sizeToFit];
    
    CGRect textLabelFrame = self.textLabel.frame;
    
    textLabelFrame.origin.x = self.imageView.image ? CGRectGetMaxX(self.imageView.frame) + 10 : 15;
    
    textLabelFrame.origin.y = (height-textLabelFrame.size.height)*0.5;
    
    CGFloat textLRightSpace = 10.0;
    
    // text label max width
    CGFloat textLMaxWidth = contentViewW - textLabelFrame.origin.x - textLRightSpace;
    
    textLabelFrame.size.width = textLabelFrame.size.width < textLMaxWidth ? textLabelFrame.size.width : textLMaxWidth;
    
    // 右边label
    if (_rightLabel.text.length>0) {
        
        [_rightLabel sizeToFit];
        
        // right label min width
        CGFloat rightLMinWidth = 60.0;
        
        // right label max width
        CGFloat rightLMaxWidth = contentViewW - CGRectGetMaxX(textLabelFrame) - textLRightSpace - kRightSpacing;
        
        CGRect rightLabelFrame = _rightLabel.frame;
        
        if (rightLMaxWidth < rightLMinWidth) {
            
            rightLabelFrame.size.width = rightLabelFrame.size.width < rightLMinWidth ? rightLabelFrame.size.width : rightLMinWidth;
        }else{
        
            rightLabelFrame.size.width = rightLabelFrame.size.width < rightLMaxWidth ? rightLabelFrame.size.width : rightLMaxWidth;
        }
        
        rightLabelFrame.origin.x = contentViewW - rightLabelFrame.size.width-kRightSpacing;
        rightLabelFrame.origin.y = (height-rightLabelFrame.size.height)*0.5;
        
        _rightLabel.frame = rightLabelFrame;
        
        textLMaxWidth = rightLabelFrame.origin.x - textLabelFrame.origin.x - textLRightSpace;
    }
    
    textLabelFrame.size.width = textLabelFrame.size.width < textLMaxWidth ? textLabelFrame.size.width : textLMaxWidth;
    
    // subLabel
    if (_subLabel.text.length > 0) {
        
        [_subLabel sizeToFit];
        
        CGRect subLabelFrame = _subLabel.frame;
        
        subLabelFrame.size.width = subLabelFrame.size.width < textLMaxWidth ? subLabelFrame.size.width : textLMaxWidth;
        
        textLabelFrame.origin.y = (height - textLabelFrame.size.height - subLabelFrame.size.height - _titleSpaceH)*0.5;
        
        subLabelFrame.origin.x = textLabelFrame.origin.x;
        subLabelFrame.origin.y = textLabelFrame.origin.y + textLabelFrame.size.height + _titleSpaceH;
        
        _subLabel.frame = subLabelFrame;
    }
    
    self.textLabel.frame = textLabelFrame;
    
    self.selectedBackgroundView.frame = self.bounds;
    
    // bottomLine
    CGFloat leftX = self.isLastCell ? 0 : self.textLabel.frame.origin.x;
    
    _lineView.frame = CGRectMake(leftX, height-kBottomLineHeight, width-leftX, kBottomLineHeight);
    
}

@end

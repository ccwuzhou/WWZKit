//
//  WWZTableViewCell.m
//  KJD
//
//  Created by appple on 15/10/16.
//  Copyright © 2015年 WL. All rights reserved.
//

#import "WWZTableViewCell.h"

@interface WWZTableViewCell ()


@end

@implementation WWZTableViewCell

+ (instancetype)wwz_cellWithTableView:(UITableView *)tableView style:(WWZTableViewCellStyle)style{
    
    static NSString *reuseIdentifier = @"REUSE_CELL_ID";
    WWZTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if (!cell) {
        cell = [[self alloc] initWithCellStyle:style reuseIdentifier:reuseIdentifier];
    }
    return cell;
}

- (instancetype)initWithCellStyle:(WWZTableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [self initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        // set cell
        [self p_setupCell];
        
        // add sub label
        [self p_addSubTitleLabelWithStyle:style];
        
        // add right label
        [self p_addRightTitleLabelWithStyle:style];
        
        // add switch
        [self p_addSwitchViewWithStyle:style];
        
    }
    return self;
}
#pragma mark - 私有方法
/**
 *  设置cell
 */
- (void)p_setupCell{
    
    self.backgroundColor = [UIColor whiteColor];
    
    // textLabel
    self.textLabel.backgroundColor = [UIColor clearColor];
    self.textLabel.font = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? [UIFont systemFontOfSize:21]:[UIFont systemFontOfSize:16]);
    self.textLabel.textColor = [UIColor blackColor];
    
    //设置选中的背景
    self.selectedBackgroundView = [[UIView alloc] init];
    self.selectedBackgroundView.backgroundColor = [UIColor colorWithRed:217.0/255.0 green:217.0/255.0 blue:217.0/255.0 alpha:1];
    
    //设置cell的分隔线
    [self p_addLineView];
}

- (void)p_addSubTitleLabelWithStyle:(WWZTableViewCellStyle)style{
    
    if (!(style & WWZTableViewCellStyleSubTitle)) {
        return;
    }

    _titleSpaceH = 5;
    UILabel *subLabel = [[UILabel alloc] init];
    subLabel.font = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? [UIFont systemFontOfSize:18]:[UIFont systemFontOfSize:14]);
    subLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    subLabel.textAlignment = NSTextAlignmentLeft;
    subLabel.numberOfLines = 1;
    [self.contentView addSubview:subLabel];
    
    _subLabel = subLabel;
}

- (void)p_addRightTitleLabelWithStyle:(WWZTableViewCellStyle)style{
    
    if (!(style & WWZTableViewCellStyleRightTitle)) {
        return;
    }
    
    UILabel *rightLabel = [[UILabel alloc] init];
    rightLabel.font = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? [UIFont systemFontOfSize:18]:[UIFont systemFontOfSize:14]);
    rightLabel.textColor = [UIColor colorWithRed:153/255.0 green:153/255.0 blue:153/255.0 alpha:1];
    rightLabel.textAlignment = NSTextAlignmentRight;
    rightLabel.numberOfLines = 1;
    [self.contentView addSubview:rightLabel];
    
    _rightLabel = rightLabel;
}

- (void)p_addSwitchViewWithStyle:(WWZTableViewCellStyle)style{
    
    if (!(style & WWZTableViewCellStyleSwitchView)) {
        return;
    }
    
    UISwitch *mySwitch = [[UISwitch alloc] init];
    [mySwitch addTarget:self action:@selector(changeSwitch:) forControlEvents:UIControlEventValueChanged];
    self.accessoryView = mySwitch;
    
    _mySwitch = mySwitch;
}

- (void)p_addLineView{

    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor colorWithRed:217.0/255.0 green:217.0/255.0 blue:217.0/255.0 alpha:1];
    [self.contentView addSubview:lineView];
    
    _lineView = lineView;
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
    CGFloat imageViewX = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 25.0 : 15.0);
    CGFloat imageViewY = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad ? 15.0 : 7.0);
    CGFloat imageWH = height-imageViewY*2;
    
    CGSize imageSize = CGSizeMake(imageWH, imageWH);
    
    if (self.imageView.image) {
        
        if (self.imageView.image.size.width>imageSize.width||self.imageView.image.size.height>imageSize.height) {
            
            self.imageView.contentMode = UIViewContentModeScaleAspectFit;
            
        }else{
            
            self.imageView.contentMode = UIViewContentModeCenter;
            imageSize = self.imageView.image.size;
        }
        self.imageView.frame = (CGRect){{imageViewX, (height-imageSize.height)*0.5}, imageSize};
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
    CGFloat right_space = (self.accessoryType == UITableViewCellAccessoryNone ? 16.0 : 0);
    
    if (_rightLabel.text.length>0) {
        
        [_rightLabel sizeToFit];
        
        // right label min width
        CGFloat rightLMinWidth = 60.0;
        
        // right label max width
        CGFloat rightLMaxWidth = contentViewW - CGRectGetMaxX(textLabelFrame) - textLRightSpace - right_space;
        
        CGRect rightLabelFrame = _rightLabel.frame;
        
        if (rightLMaxWidth < rightLMinWidth) {
            
            rightLabelFrame.size.width = rightLabelFrame.size.width < rightLMinWidth ? rightLabelFrame.size.width : rightLMinWidth;
        }else{
        
            rightLabelFrame.size.width = rightLabelFrame.size.width < rightLMaxWidth ? rightLabelFrame.size.width : rightLMaxWidth;
        }
        
        rightLabelFrame.origin.x = contentViewW - rightLabelFrame.size.width-right_space;
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
    
    _lineView.frame = CGRectMake(leftX, height-0.5, width-leftX, 0.5);
    
}

@end

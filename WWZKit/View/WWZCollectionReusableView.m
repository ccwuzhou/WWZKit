//
//  WWZCollectionReusableView.m
//  BCSmart
//
//  Created by wwz on 16/7/6.
//  Copyright © 2016年 cn.zgkjd. All rights reserved.
//

#import "WWZCollectionReusableView.h"
#import "WWZReusableModel.h"

#define kColorFromRGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define kDefaultBgColor kColorFromRGBA(242, 242, 242, 1)
#define kTipViewLineColor kColorFromRGBA(204, 204, 204, 1)
#define kDefaultTitleColor kColorFromRGBA(51, 51, 51, 1)


@interface WWZCollectionReusableView ()



@end

@implementation WWZCollectionReusableView

/**
 *  为只读属性生成成员变量
 */
@synthesize imageView = _imageView;
@synthesize titleLabel = _titleLabel;
@synthesize lineView = _lineView;

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.imageView];
        
        [self addSubview:self.titleLabel];
        
        [self addSubview:self.lineView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        
        [self addGestureRecognizer:tap];
        
    }
    return self;
}

- (void)tap:(UITapGestureRecognizer *)tap{
    
    if ([self.delegate respondsToSelector:@selector(didTapReusableView:)]) {
        [self.delegate didTapReusableView:self];
    }
}


#pragma mark - setter 方法

- (void)setReusableModel:(WWZReusableModel *)reusableModel{
    
    _reusableModel = reusableModel;
    
    if (_reusableModel.title) {
        self.titleLabel.text = _reusableModel.title;
    }
    
    if (_reusableModel.image) {
        self.imageView.image = _reusableModel.image;
    }
    
    [self setNeedsLayout];
}

/**
 *  是否展开
 */
- (void)setIsUnfold:(BOOL)isUnfold{
    
    _isUnfold = isUnfold;
    
    _lineView.hidden = _isUnfold;
    
    if (_isUnfold) {// 展开
        
        self.imageView.transform = CGAffineTransformIdentity;
        
    }else{// 收起
        
        self.imageView.transform = CGAffineTransformMakeRotation(-M_PI/2);
    }
}


#pragma mark - getter

- (UIImageView *)imageView{
    
    if (!_imageView) {
        
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"WZViewTool.bundle/cell_header_arrow_down.png"]];
    }
    return _imageView;
}

- (UILabel *)titleLabel{
    if (!_titleLabel) {
        
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:16];
        _titleLabel.textColor = kDefaultTitleColor;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}
- (UIView *)lineView{
    if (!_lineView) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = kTipViewLineColor;
    }
    return _lineView;
}

#pragma mark - layout

- (void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat leftX = 15;
    
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    CGSize imageSize = CGSizeMake(height-leftX, height-leftX);
    
    //左边图标
    if (self.imageView.image) {
        
        if (self.imageView.image.size.width>imageSize.width||self.imageView.image.size.height>imageSize.height) {
            
            self.imageView.contentMode = UIViewContentModeScaleAspectFit;
            
        }else{
            
            self.imageView.contentMode = UIViewContentModeCenter;
            imageSize = self.imageView.image.size;
        }
        self.imageView.frame = (CGRect){{leftX, (height-imageSize.height)*0.5},imageSize};
    }
    
    [self.titleLabel sizeToFit];
    
    CGFloat titleLX = self.imageView.image ? CGRectGetMaxX(self.imageView.frame) + 10 : 15;
    
    self.titleLabel.frame = (CGRect){{titleLX, (height-self.titleLabel.frame.size.height)*0.5},self.titleLabel.frame.size};
    
    _lineView.frame = CGRectMake(0, height-0.5, width, 0.5);
}

@end

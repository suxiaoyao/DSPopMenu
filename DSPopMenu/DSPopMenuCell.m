//
//  DSPopMenuCell.m
//  Menu_test
//
//  Created by Will on 2017/5/22.
//  Copyright © 2017年 Will. All rights reserved.
//

#import "DSPopMenuCell.h"
#import "DSPopMenuItem.h"

#define kIconLeftMargin WIDTH_SCALE(20)
#define kIconWidthAndHeight HEIGHT_SCALE(20)
#define kTextLeftMargin WIDTH_SCALE(10)
#define kIconRightMargin WIDTH_SCALE(15)

@interface DSPopMenuCell()

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UIImageView *iconImageView;

@property (nonatomic, strong) UIView *line;

@end

@implementation DSPopMenuCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        
        self.iconImageView = [[UIImageView alloc] init];
        [self.contentView addSubview:self.iconImageView];
        [self.iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView.mas_left).with.offset(kIconLeftMargin);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.size.mas_equalTo(CGSizeMake(kIconWidthAndHeight, kIconWidthAndHeight));
            
        }];
        
        
        self.titleLabel = [[UILabel alloc] init];
        self.titleLabel.font = [UIFont systemFontOfSize:HEIGHT_SCALE(14.0)];
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView.mas_left).with.offset(kTextLeftMargin);
            make.right.equalTo(self.contentView.mas_right).with.offset(-kTextLeftMargin);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.height.mas_equalTo(self.titleLabel.font.lineHeight);
            
        }];
        
        self.line = [[UIView alloc] init];
        self.line.backgroundColor = [UIColor grayColor];
        [self.contentView addSubview:self.line];
        [self.line mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.mas_equalTo(self.contentView.mas_left);
            make.right.mas_equalTo(self.contentView.mas_right);
            make.bottom.mas_equalTo(self.contentView.mas_bottom);
            make.height.mas_equalTo(1.0 / [UIScreen mainScreen].scale);
            
        }];
        
    }
    
    return self;
    
}

- (void)updateMenuCellWith:(DSPopMenuItem *)menuItem
                  hasImage:(BOOL)hasImage
                titleColor:(UIColor *)titleColor
             hidBottomLine:(BOOL)hidBottomLine
           bottomLineColor:(UIColor *)bottomLineColor
{
    
    self.titleLabel.text = menuItem.title;
    self.titleLabel.textColor = titleColor;
    self.line.backgroundColor = bottomLineColor;
    self.line.hidden = hidBottomLine;
    
    if (hasImage) {
        
        self.iconImageView.hidden = NO;
        self.iconImageView.image = menuItem.image;
        
        self.titleLabel.textAlignment = NSTextAlignmentLeft;
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.iconImageView.mas_right).with.offset(kIconRightMargin);
            make.right.equalTo(self.contentView.mas_right).with.offset(-kIconRightMargin);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.height.mas_equalTo(self.titleLabel.font.lineHeight);
            
        }];
        
    }else {
        
        self.iconImageView.hidden = YES;
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView.mas_left).with.offset(kTextLeftMargin);
            make.right.equalTo(self.contentView.mas_right).with.offset(-kTextLeftMargin);
            make.centerY.mas_equalTo(self.contentView.mas_centerY);
            make.height.mas_equalTo(self.titleLabel.font.lineHeight);
            
        }];
        
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

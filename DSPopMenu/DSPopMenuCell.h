//
//  DSPopMenuCell.h
//  Menu_test
//
//  Created by Will on 2017/5/22.
//  Copyright © 2017年 Will. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DSPopMenuItem;

@interface DSPopMenuCell : UITableViewCell

- (void)updateMenuCellWith:(DSPopMenuItem *)menuItem
                  hasImage:(BOOL)hasImage
                titleColor:(UIColor *)titleColor
             hidBottomLine:(BOOL)hidBottomLine
           bottomLineColor:(UIColor *)bottomLineColor;

@end

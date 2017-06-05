//
//  DSPopMenuView.h
//  Menu_test
//
//  Created by Will on 2017/5/22.
//  Copyright © 2017年 Will. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    MenuViewPoistionCenter = 0, //显示位置-center
    MenuViewPoistionRight,      //显示位置-right
    MenuViewPoistionLeft,       //显示位置-left
} MenuViewPoistion;             //显示位置

typedef enum : NSUInteger {
    MenuViewShowStyleWhiteBackground = 0,   //menu展示风格-白色背景
    MenuViewShowStyleBlackBackground,       //menu展示风格-黑色背景
} MenuViewShowStyle;                        //menu展示风格

@interface DSPopMenuView : UIView

- (instancetype)initWithMenuItems:(NSArray *)menuItems
                menuViewShowStyle:(MenuViewShowStyle)menuViewShowStyle
                 menuViewPoistion:(MenuViewPoistion)menuViewPoistion;

/**
 MenuViewShowStyleWhiteBackground menu展示风格-白色背景
 背景透明度 0～1之间 default 0.05
 请在showView之前设置
 */
@property (nonatomic, assign) CGFloat backgroundColorAlpha;

/**
 itemWidth 
 default 有图片 150 无图片 100
 请在showView之前设置
 */
@property (nonatomic, assign) CGFloat itemWidth;

/**
 itemHeight
 default 50 
 请在showView之前设置
 */
@property (nonatomic, assign) CGFloat itemHeight;

/**
 箭头的高度
 default 6
 请在showView之前设置
 */
@property (nonatomic, assign) CGFloat arrowHeight;

/**
 箭头的宽度
 default 12
 请在showView之前设置
 */
@property (nonatomic, assign) CGFloat arrowWidth;

/**
 箭头距离左右的边距 只有在MenuViewPoistion = MenuViewPoistionLeft | MenuViewPoistionRight 才有效
 default 10
 请在showView之前设置
 */
@property (nonatomic, assign) CGFloat arrowMargin;

/**
 cornerRadius
 default 4
 请在showView之前设置
 */
@property (nonatomic, assign) CGFloat cornerRadius;

/**
 指定的view展示menu时有效，箭头距离view的bottom 
 default 1
 请在showView之前设置
 */
@property (nonatomic, assign) CGFloat viewBottomMargin;

/**
 item有无图片 
 default YES
 */
@property (nonatomic, assign) BOOL hasItemImage;

/**
 *item分割线颜色
 *MenuViewShowStyle 为 MenuViewShowStyleWhiteBackground 的时候 item分割线颜色默认颜色为:[UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1.00]
 *MenuViewShowStyle 为 MenuViewShowStyleBlackBackground 的时候 item分割线颜色默认颜色为:[UIColor whiteColor]
 */
@property (nonatomic, strong) UIColor *bottomLineColor;

/**
 *item文字颜色
 *MenuViewShowStyle 为 MenuViewShowStyleWhiteBackground 的时候 item文字颜色默认颜色为:[UIColor colorWithRed:0.314 green:0.314 blue:0.314 alpha:1.00]
 *MenuViewShowStyle 为 MenuViewShowStyleBlackBackground 的时候 item文字颜色默认颜色为:[UIColor whiteColor]
 */
@property (nonatomic, strong) UIColor *titleColor;

/**
 指定的view展示menu
 
 @param view 指定的view
 */
- (void)showMenuToView:(UIView *)view;

/**
 指定的点展示menu
 
 @param point 指定的点((0, 0)是屏幕的左上角)
 */
- (void)showMenuToPoint:(CGPoint)point;

@end

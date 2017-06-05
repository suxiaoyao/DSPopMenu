//
//  DSPopMenuView.m
//  Menu_test
//
//  Created by Will on 2017/5/22.
//  Copyright © 2017年 Will. All rights reserved.
//

#import "DSPopMenuView.h"
#import "DSPopMenuCell.h"
#import "DSPopMenuItem.h"

float DegreesToRadians(float angle) {
    return angle*M_PI/180;
}

static NSInteger const MAX_ITEM_NOTSCROLL_COUNT = 5;//最大不可滑动个数(当个数大于此数时，可以滑动)

@interface DSPopMenuView()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) UIView *shadeView;

@property (nonatomic, strong) NSArray *menuItems;

@property (nonatomic, strong) UIWindow *keyWindow;

@property (nonatomic, assign) MenuViewShowStyle menuViewShowStyle;

@property (nonatomic, assign) MenuViewPoistion menuViewPoistion;

@property (nonatomic, assign) BOOL isShowShadeView;

@property (nonatomic, assign) BOOL hasSetItemWidth;

@property (nonatomic, assign) BOOL hasSetItemHeight;

@end

@implementation DSPopMenuView

- (instancetype)initWithMenuItems:(NSArray *)menuItems menuViewShowStyle:(MenuViewShowStyle)menuViewShowStyle menuViewPoistion:(MenuViewPoistion)menuViewPoistion {
    
    self = [super init];
    
    if (self) {
        
        self.keyWindow = [UIApplication sharedApplication].keyWindow;
        self.backgroundColorAlpha = 0.05;
        self.arrowHeight = 6;
        self.arrowWidth = 12;
        self.arrowMargin = 10;
        self.cornerRadius = 4;
        self.viewBottomMargin = 1;
        self.hasSetItemWidth = NO;
        self.hasSetItemHeight = NO;
        self.hasItemImage = YES;
        
        self.menuItems = menuItems;
        self.menuViewShowStyle = menuViewShowStyle;
        self.menuViewPoistion = menuViewPoistion;
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleBackHidTap:)];
        [self.shadeView addGestureRecognizer:tap];
        
        switch (menuViewShowStyle) {
                
            case MenuViewShowStyleWhiteBackground:
                self.isShowShadeView = YES;
                self.backgroundColor = [UIColor whiteColor];
                self.bottomLineColor = [UIColor colorWithRed:0.937 green:0.937 blue:0.957 alpha:1.00];
                self.titleColor = [UIColor colorWithRed:0.314 green:0.314 blue:0.314 alpha:1.00];
                break;
                
            case MenuViewShowStyleBlackBackground:
                self.isShowShadeView = NO;
                self.backgroundColor = [UIColor colorWithRed:0.267 green:0.282 blue:0.290 alpha:1.00];
                self.bottomLineColor = [UIColor whiteColor];
                self.titleColor = [UIColor whiteColor];
                break;
                
            default:
                break;
        }
        
        [self addSubview:self.tableView];
        
    }
    
    return self;
    
}

#pragma mark - layoutSubviews
- (void)layoutSubviews {
    
    [super layoutSubviews];

    self.tableView.frame = CGRectMake(0, self.arrowHeight, self.itemWidth, self.frame.size.height - self.arrowHeight);
    
}

#pragma mark - getter and setter
- (UIView *)shadeView {
    
    if (!_shadeView) {
        
        _shadeView = [[UIView alloc] initWithFrame:_keyWindow.bounds];
        _shadeView.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        
    }
    
    return _shadeView;
    
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.backgroundColor = [UIColor clearColor];
        
    }
    
    return _tableView;
    
}

- (void)setIsShowShadeView:(BOOL)isShowShadeView {
    
    _isShowShadeView = isShowShadeView;
    
    if (isShowShadeView) {
        
        _shadeView.backgroundColor = [UIColor colorWithWhite:0 alpha:_backgroundColorAlpha];
        
    }else {
        
        _shadeView.backgroundColor = [UIColor clearColor];
        
    }
    
}

- (void)setBackgroundColorAlpha:(CGFloat)backgroundColorAlpha {
    
    _backgroundColorAlpha = backgroundColorAlpha;
    
    if (_menuViewShowStyle == MenuViewShowStyleWhiteBackground) {
        
        _shadeView.backgroundColor = [UIColor colorWithWhite:0 alpha:_backgroundColorAlpha];
        
    }
    
}

- (void)setItemWidth:(CGFloat)itemWidth {
    
    _itemWidth = itemWidth;
    _hasSetItemWidth = YES;
    
}

- (void)setItemHeight:(CGFloat)itemHeight {
    
    _itemHeight = itemHeight;
    _hasSetItemHeight = YES;
    
}

- (void)setHasItemImage:(BOOL)hasItemImage {
    
    _hasItemImage = hasItemImage;
    
    if (hasItemImage) {
        
        if (!_hasSetItemWidth) {
            
            _itemWidth = WIDTH_SCALE(150);
            
        }
        
        if (!_hasSetItemHeight) {
            
            _itemHeight = HEIGHT_SCALE(50);
            
        }
        
    }else {
        
        if (!_hasSetItemWidth) {
            
            _itemWidth = WIDTH_SCALE(100);
            
        }
        
        if (!_hasSetItemHeight) {
            
            _itemHeight = HEIGHT_SCALE(40);
            
        }
        
    }
    
    if (_tableView) {
        
        [_tableView reloadData];
    
    }
    
}

- (void)setBottomLineColor:(UIColor *)bottomLineColor {
    
    _bottomLineColor = bottomLineColor;
    
    if (_tableView) {
        
        [_tableView reloadData];
        
    }
    
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.menuItems.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *cellIdentifer = @"DSPopMenuCell";
    
    DSPopMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer];
    
    if (cell == nil) {
        
        cell = [[DSPopMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    
    BOOL hidBottomLine = (indexPath.row == (self.menuItems.count - 1));
    
    [cell updateMenuCellWith:self.menuItems[indexPath.row]
                    hasImage:self.hasItemImage
                  titleColor:self.titleColor
               hidBottomLine:hidBottomLine
             bottomLineColor:self.bottomLineColor];
    
    return cell;

}

#pragma mark - UITabelViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.itemHeight;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DSPopMenuItem *menuItem = self.menuItems[indexPath.row];
    [menuItem performAction];
    
    [self hid];

}

#pragma mark - action
- (void)handleBackHidTap:(UITapGestureRecognizer *)tap {
    
    [self hid];
    
}

- (void)showMenuToPoint:(CGPoint)point {
    
    [self.keyWindow addSubview:self.shadeView];
    
    //箭头在keywindow中的坐标
    CGFloat arrowForKeyWindowX = point.x;
    CGFloat arrowForKeyWindowY = point.y;
    
    //计算popview frame
    CGFloat currentX = 0;
    CGFloat currentY = arrowForKeyWindowY;
    CGFloat currentW = self.itemWidth;
    CGFloat currentH = 0;
    
    if (self.menuItems.count <= MAX_ITEM_NOTSCROLL_COUNT) {
        
        currentH = self.itemHeight * self.menuItems.count + self.arrowHeight;
        
    }else {
        
        currentH = self.itemHeight * MAX_ITEM_NOTSCROLL_COUNT + self.arrowHeight;
        
    }
    
    switch (self.menuViewPoistion) {
        
        case MenuViewPoistionLeft:
            currentX = arrowForKeyWindowX - self.arrowWidth / 2 - self.arrowMargin;
            break;
            
        case MenuViewPoistionCenter:
            currentX = arrowForKeyWindowX - currentW / 2;
            break;
            
        case MenuViewPoistionRight:
            currentX = arrowForKeyWindowX + self.arrowWidth / 2 + self.arrowMargin - currentW;
            break;
            
        default:
            break;
    }
    
    self.frame = CGRectMake(currentX, currentY, currentW, currentH);
    
    //箭头顶点在当前视图的坐标
    CGPoint arrowPoint = CGPointMake(arrowForKeyWindowX - currentX, 0);
    
    //绘制圆角和箭头
    UIBezierPath *maskPath = [UIBezierPath bezierPath];
    
    CGFloat cornerRadius = self.cornerRadius;
    CGFloat maskTop = self.arrowHeight;
    CGFloat arrowWidth = self.arrowWidth;
    CGFloat arrowHeight = self.arrowHeight;
    CGFloat maskBottom = currentH;
    
    //左上圆角
    [maskPath moveToPoint:CGPointMake(0, cornerRadius + maskTop)];
    [maskPath addArcWithCenter:CGPointMake(cornerRadius, cornerRadius + maskTop)
                        radius:cornerRadius
                    startAngle:DegreesToRadians(180)
                      endAngle:DegreesToRadians(270)
                     clockwise:YES];
    
    //箭头向上时的箭头位置
    [maskPath addLineToPoint:CGPointMake(arrowPoint.x - arrowWidth/2, arrowHeight)];
    [maskPath addQuadCurveToPoint:CGPointMake(arrowPoint.x, 0)
                     controlPoint:CGPointMake(arrowPoint.x - arrowWidth/2, arrowHeight)];
    [maskPath addQuadCurveToPoint:CGPointMake(arrowPoint.x, 0)
                     controlPoint:arrowPoint];
    [maskPath addQuadCurveToPoint:CGPointMake(arrowPoint.x + arrowWidth/2, arrowHeight)
                     controlPoint:CGPointMake(arrowPoint.x + arrowWidth/2, arrowHeight)];
    
    //右上圆角
    [maskPath addLineToPoint:CGPointMake(currentW - cornerRadius, maskTop)];
    [maskPath addArcWithCenter:CGPointMake(currentW - cornerRadius, maskTop + cornerRadius)
                        radius:cornerRadius
                    startAngle:DegreesToRadians(270)
                      endAngle:DegreesToRadians(0)
                     clockwise:YES];
    // 右下圆角
    [maskPath addLineToPoint:CGPointMake(currentW, maskBottom - cornerRadius)];
    [maskPath addArcWithCenter:CGPointMake(currentW - cornerRadius, maskBottom - cornerRadius)
                        radius:cornerRadius
                    startAngle:DegreesToRadians(0)
                      endAngle:DegreesToRadians(90)
                     clockwise:YES];
    // 左下圆角
    [maskPath addLineToPoint:CGPointMake(cornerRadius, maskBottom)];
    [maskPath addArcWithCenter:CGPointMake(cornerRadius, maskBottom - cornerRadius)
                        radius:cornerRadius
                    startAngle:DegreesToRadians(90)
                      endAngle:DegreesToRadians(180)
                     clockwise:YES];
    [maskPath closePath];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    self.layer.mask = maskLayer;
    
    [self.keyWindow addSubview:self];
    
    self.alpha = 0.0;
    self.shadeView.alpha = 0.0;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha = 1.0;
        self.shadeView.alpha = 1.0;
        
    } completion:nil];
    
}

- (void)showMenuToView:(UIView *)view {
    
    CGRect pointViewRect = [view.superview convertRect:view.frame toView:self.keyWindow];
    
    CGFloat arrowForKeyWindowX = CGRectGetMidX(pointViewRect);
    CGFloat arrowForKeyWindowY = CGRectGetMaxY(pointViewRect) + self.viewBottomMargin;
    
    [self showMenuToPoint:CGPointMake(arrowForKeyWindowX, arrowForKeyWindowY)];
    
}

- (void)hid {
    
    self.alpha = 1.0;
    self.shadeView.alpha = 1.0;
    
    [UIView animateWithDuration:0.3 animations:^{
        
        self.alpha = 0.0;
        self.shadeView.alpha = 0.0;
        
    } completion:^(BOOL finished) {
        
        if (self.superview) {
            
            [self.shadeView removeFromSuperview];
            [self removeFromSuperview];
            
        }
        
    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

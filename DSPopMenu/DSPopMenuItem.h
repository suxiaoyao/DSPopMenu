//
//  DSPopMenuItem.h
//  Menu_test
//
//  Created by Will on 2017/5/26.
//  Copyright © 2017年 Will. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

// 传入ip5的尺寸进行适配
#define DSWIDTH_SCALE(X)      ([[UIScreen mainScreen] bounds].size.width)*X/320
#define DSHEIGHT_SCALE(Y)     (DSIPhone6Plus ? ([[UIScreen mainScreen] bounds].size.height)*Y/568 :(DSIPhone6 ? ([[UIScreen mainScreen] bounds].size.height)*Y/568  :(DSIPhone5? ([[UIScreen mainScreen] bounds].size.height)*Y/568 :568*Y/568)))

//判断机型(5/5s/5c 6/6s 6plus/6s plus other is 4/4s)
#define DSIPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define DSIPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define DSIPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size): NO)

@interface DSPopMenuItem : NSObject

@property (nonatomic, copy, readonly) NSString *title;

@property (nonatomic, strong, readonly) UIImage *image;

@property (nonatomic, assign, readonly) SEL action;

@property (nonatomic, weak, readonly) id target;

+ (instancetype)menuItem:(NSString *)title
                   image:(UIImage *)image
                  target:(id)target
                  action:(SEL)action;

- (void)performAction;

@end

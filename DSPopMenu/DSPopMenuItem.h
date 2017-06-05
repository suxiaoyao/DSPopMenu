//
//  DSPopMenuItem.h
//  Menu_test
//
//  Created by Will on 2017/5/26.
//  Copyright © 2017年 Will. All rights reserved.
//

#import <Foundation/Foundation.h>

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

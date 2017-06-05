//
//  DSPopMenuItem.m
//  Menu_test
//
//  Created by Will on 2017/5/26.
//  Copyright © 2017年 Will. All rights reserved.
//

#import "DSPopMenuItem.h"

@implementation DSPopMenuItem

+ (instancetype)menuItem:(NSString *)title
                   image:(UIImage *)image
                  target:(id)target
                  action:(SEL)action
{
    return [[DSPopMenuItem alloc] init:title
                               image:image
                              target:target
                              action:action];
}

- (id)init:(NSString *)title
     image:(UIImage *)image
    target:(id)target
    action:(SEL)action
{
    self = [super init];
    if (self) {
        
        _title = title;
        _image = image;
        _target = target;
        _action = action;
    }
    return self;
}

- (void)performAction
{
    __strong id target = self.target;
    
    if (target && [target respondsToSelector:_action]) {
        
        [target performSelectorOnMainThread:_action withObject:self waitUntilDone:YES];
    }
}

@end



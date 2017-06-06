//
//  ViewController.m
//  DSPopMenuDemo
//
//  Created by Dandy on 2017/6/6.
//  Copyright © 2017年 doshr. All rights reserved.
//

#import "ViewController.h"
#import "DSPopMenu.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *showButton = [UIButton buttonWithType:UIButtonTypeCustom];
    showButton.backgroundColor = [UIColor lightGrayColor];
    [showButton setTitle:@"显示" forState:UIControlStateNormal];
    [showButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    showButton.frame = CGRectMake(100, 200, 44, 44);
    [self.view addSubview:showButton];
    
    [showButton addTarget:self action:@selector(showPopMenu:) forControlEvents:UIControlEventTouchUpInside];
    
}

#pragma mark - action

- (void)showPopMenu:(UIButton *)sender {
    
    NSArray *menuItems = @[[DSPopMenuItem menuItem:@"按钮1"
                                           image:nil
                                          target:self
                                          action:@selector(click1:)],
                         [DSPopMenuItem menuItem:@"按钮2"
                                           image:nil
                                          target:self
                                          action:@selector(click2:)]];;
    
    DSPopMenuView *popView = [[DSPopMenuView alloc] initWithMenuItems:menuItems
                                                    menuViewShowStyle:MenuViewShowStyleWhiteBackground
                                                     menuViewPoistion:MenuViewPoistionRight];
    popView.hasItemImage = NO;
    [popView showMenuToView:sender];
    
}

- (void)click1:(UIButton *)sender {
    
    NSLog(@"DSPopMenu --> 点击 --> 按钮1");
    
}

- (void)click2:(UIButton *)sender {
    
    NSLog(@"DSPopMenu --> 点击 --> 按钮2");
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

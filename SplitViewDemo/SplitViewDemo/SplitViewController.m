//
//  SplitViewController.m
//  SplitViewDemo
//
//  Created by wudan on 2020/4/27.
//  Copyright © 2020 wudan. All rights reserved.
//

#import "SplitViewController.h"

@interface SplitViewController ()

@end

@implementation SplitViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    self.preferredDisplayMode = UISplitViewControllerDisplayModeAllVisible;
}

@end

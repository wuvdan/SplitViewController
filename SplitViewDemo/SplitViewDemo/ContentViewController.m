//
//  ContentViewController.m
//  SplitViewDemo
//
//  Created by wudan on 2020/4/27.
//  Copyright © 2020 wudan. All rights reserved.
//

#import "ContentViewController.h"
#import "OtherViewController.h"

@interface ContentViewController ()<UINavigationControllerDelegate>
@property (nonatomic, strong) UILabel *textLabel;
@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.delegate = self;
    
    self.textLabel = [[UILabel alloc] init];
    self.textLabel.textColor = [UIColor whiteColor];
    self.textLabel.textAlignment = NSTextAlignmentCenter;
    self.textLabel.font = [UIFont systemFontOfSize:100 weight:UIFontWeightMedium];
    [self.view addSubview:self.textLabel];
    self.textLabel.text = self.contentText.length > 0 ? self.contentText : @"1";

    self.view.backgroundColor = [UIColor orangeColor];
}

#pragma mark - UINavigationControllerDelegate
- (void)navigationController:(UINavigationController *)navigationController
      willShowViewController:(UIViewController *)viewController
                    animated:(BOOL)animated {
    
    BOOL isLandscape = (UIApplication.sharedApplication.statusBarOrientation == UIInterfaceOrientationLandscapeLeft ||
                        UIApplication.sharedApplication.statusBarOrientation == UIInterfaceOrientationLandscapeRight);
    // 为了Demo显示好看，分屏时赢了内容控制器的导航栏
    if (isLandscape && UIScreen.mainScreen.bounds.size.height > 375) {
        BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
        [self.navigationController setNavigationBarHidden:isShowHomePage animated:YES];
    } else {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    }
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    OtherViewController *vc = [[OtherViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)setContentText:(NSString *)contentText {
    _contentText = contentText;
    self.textLabel.text = contentText;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.textLabel.frame = self.view.bounds;
}

@end

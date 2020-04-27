//
//  MasterViewController.m
//  SplitViewDemo
//
//  Created by wudan on 2020/4/27.
//  Copyright © 2020 wudan. All rights reserved.
//

#import "MasterViewController.h"
#import "ContentViewController.h"

@interface MasterViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation MasterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主控制器";
    [self.view addSubview:self.tableView];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.tableView.frame = self.view.bounds;
}

#pragma mark - UITableView DataSource Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UITableViewCell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    return cell;
}

#pragma mark - UITableView Delegate Methods
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // 小屏幕不支持分屏
    BOOL isLandscape = (UIApplication.sharedApplication.statusBarOrientation == UIInterfaceOrientationLandscapeLeft || UIApplication.sharedApplication.statusBarOrientation == UIInterfaceOrientationLandscapeRight);
    if (isLandscape && UIScreen.mainScreen.bounds.size.height > 375) {
        // 点击直接修改显示内容
        UINavigationController *nav = self.splitViewController.viewControllers.lastObject;
        if (nav.viewControllers.count > 0) {
            [nav.viewControllers.lastObject.navigationController popToRootViewControllerAnimated:YES];
        }
        ContentViewController *vc = nav.viewControllers.firstObject;
        vc.contentText = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
    } else {
        // 点击进行push跳转
        ContentViewController *vc = [[ContentViewController alloc] init];
        vc.contentText = [NSString stringWithFormat:@"%ld", indexPath.row + 1];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"UITableViewCell"];
    }
    return _tableView;
}
@end

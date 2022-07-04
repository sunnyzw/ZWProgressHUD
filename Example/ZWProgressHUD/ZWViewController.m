//
//  ZWViewController.m
//  ZWProgressHUD
//
//  Created by Sunny on 07/04/2022.
//  Copyright (c) 2022 Sunny. All rights reserved.
//

#import "ZWViewController.h"
#import "ZWProgressHUD.h"

@interface ZWViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;

@end

@implementation ZWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = @[
        @"显示菊花",
        @"显示默认gif动画",
        @"显示默认gif动画，并设置偏移量",
        @"显示自定义gif动画",
        @"显示自定义gif动画，可设置偏移量",
        @"显示文字提示",
        @"显示自定义图片提示",
        @"显示成功提示",
        @"显示失败提示",
        @"显示警告提示",
        @"显示进度条"
    ];
    [self.tableView reloadData];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"kUITableViewCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"kUITableViewCell"];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    switch (indexPath.row) {
        case 0: // 显示菊花
            [ZWProgressHUD showIndeterminate:self.view];
            break;
        case 1: // 显示默认gif动画
            [ZWProgressHUD showAnimation:self.view];
            break;
        case 2: // 显示默认gif动画，并设置偏移量
            [ZWProgressHUD showAnimation:self.view offsetY:100];
            break;
        case 3: { // 显示自定义gif动画
            NSMutableArray<UIImage *> *images = [NSMutableArray array];
            [ZWProgressHUD showCustomAnimation:images view:self.view];
            break;
        }
        case 4: { // 显示自定义gif动画，可设置偏移量
            NSMutableArray<UIImage *> *images = [NSMutableArray array];
            [ZWProgressHUD showCustomAnimation:images view:self.view offsetY:100];
            break;
        }
        case 5: // 显示文字提示
            [ZWProgressHUD showMessage:@"这是文字提示" view:self.view];
            break;
        case 6: // 显示自定义图片提示
            [ZWProgressHUD showCustomImage:[UIImage imageNamed:@""] message:@"这是文字提示，可传入nil" view:self.view];
            break;
        case 7: // 显示成功提示
            [ZWProgressHUD showSuccess:@"这是成功提示" view:self.view];
            break;
        case 8: // 显示失败提示
            [ZWProgressHUD showFailure:@"这是失败提示" view:self.view];
            break;
        case 9: // 显示警告提示
            [ZWProgressHUD showWarning:@"这是警告提示" view:self.view];
            break;
        case 10: // 显示进度条
            for (int i = 0; i <= 10; i++) {
                [ZWProgressHUD showProgress:(float)i / 10 view:self.view];
                sleep(0.5);
            }
            break;
        default:
            break;
    }
    [self performSelector:@selector(hideHUD) withObject:self afterDelay:3];
}

- (void)hideHUD {
    [ZWProgressHUD hide:self.view];
}

@end

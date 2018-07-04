//
//  WFSettingVC.m
//  ADSRouter
//
//  Created by Andy on 2017/12/14.
//

#import "WFSettingVC.h"
#import "ADSRouter.h"
#import "Masonry.h"
#import "SDImageCache.h"
#import "WFHelpers.h"
#import "WFUserCenter.h"

@interface WFSettingVC () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation WFSettingVC

ADS_REQUEST_MAPPING(WFSettingVC, "wfshop://setting")

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

- (void)setUpUI {
    _tableView = [UITableView new];
    [self.view addSubview:_tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];

    _tableView.delegate = self;
    _tableView.dataSource = self;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    if (indexPath.row == 0) {
        cell.textLabel.text = @"清空缓存";
    } else {
        cell.textLabel.text = @"退出登录";
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    if (indexPath.row == 0) {
        [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
            [[SDImageCache sharedImageCache] clearMemory];
            __strong typeof(weakSelf) sSelf = weakSelf;
            if (sSelf) {
                WFShowHud(@"清空成功", sSelf.view, 1);
            }
        }];
    } else {
        [[WFUserCenter sharedCenter] logout];
        WFShowHud(@"退出成功", self.view, 1);
    }
    
}

@end

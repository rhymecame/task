//
//  WFDebugVC.m
//  ADSRouter
//
//  Created by Andy on 2018/1/9.
//

#import "WFDebugVC.h"
#import "ADSRouter.h"
#import "WFHelpers.h"
#import "BeeHive.h"
#import "WFTestUserService.h"
#import "WFUserProtocol.h"

@interface WFDebugVC ()

@end

@implementation WFDebugVC

#ifdef DEBUG

ADS_REQUEST_MAPPING(WFDebugVC, "wfshop://debug")
ADS_STORYBOARD_IN_BUNDLE("WFDebug", "WFDebugVC", "WFDebug")
ADS_SHOWSTYLE_PRESENT

#endif

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpUI];
}

- (void)setUpUI {
    self.title = @"调试面板";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(close)];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        WFShowHud(@"替换成功", self.view, 1);
    }
}

- (void)close {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end

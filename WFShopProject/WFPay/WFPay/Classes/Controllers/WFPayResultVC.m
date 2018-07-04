//
//  WFPayResultVC.m
//  ADSRouter
//
//  Created by Andy on 2017/12/19.
//

#import "WFPayResultVC.h"
#import "ADSRouter.h"
#import "WFHelpers.h"

typedef NS_ENUM(NSUInteger, WFPayResult) {
    WFPayResultUnknown,
    WFPayResultSuccess,
    WFPayResultFail
};

static NSString * const kSuccess = @"success";
static NSString * const kFail = @"fail";

@interface WFPayResultVC ()

@property (nonatomic, assign) WFPayResult payResult;

@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *hintLabel;
@property (weak, nonatomic) IBOutlet UIButton *goBtn;

@end

@implementation WFPayResultVC

ADS_REQUEST_MAPPING(WFPayResultVC, "wfshop://wechatPayResult")
ADS_STORYBOARD_IN_BUNDLE("WFPay", "WFPayResultVC", "WFPay")
ADS_PARAMETER_MAPPING(WFPayResultVC, result, "result")

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    switch (self.payResult) {
        case WFPayResultSuccess:
            [self setUpSuccessUI];
            break;
        case WFPayResultFail:
            [self setUpFailUI];
            break;
        default:
            [self setUpDefautUI];
            break;
    }
}

- (void)setUpDefautUI {
    [_iconImage setImage:[UIImage imageNamed:@"pay-unknown" inBundle:WFGetBundle(@"WFPay") compatibleWithTraitCollection:nil]];
    _hintLabel.text = @"支付结果未知";
}

- (void)setUpSuccessUI {
    [_iconImage setImage:[UIImage imageNamed:@"pay-success" inBundle:WFGetBundle(@"WFPay") compatibleWithTraitCollection:nil]];
    _hintLabel.text = @"支付成功";
}

- (void)setUpFailUI {
    [_iconImage setImage:[UIImage imageNamed:@"pay-fail" inBundle:WFGetBundle(@"WFPay") compatibleWithTraitCollection:nil]];
    _hintLabel.text = @"支付失败";
    _hintLabel.textColor = [UIColor redColor];
}

- (IBAction)goBtnClick:(id)sender {
    NSInteger param = 0;
    switch (self.payResult) {
        case WFPayResultFail:
            param = 1;
            break;
        default:
            break;
    }
//    [self.presentingViewController.navigationController popToRootViewControllerAnimated:NO];
    [self dismissViewControllerAnimated:YES completion:^{
        [[ADSRouter sharedRouter] openUrlString:[NSString stringWithFormat:@"wfshop://showOrders?selected_idx=%ld", param]];
    }];
    
}

- (WFPayResult)payResult {
    if (_result && [_result isEqualToString:kSuccess]) {
        return WFPayResultSuccess;
    } else if (_result && [_result isEqualToString:kFail]) {
        return WFPayResultFail;
    }
    return WFPayResultUnknown;
}

@end

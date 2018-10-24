//
//  WFLaunchAdVC.m
//  ADSRouter
//
//  Created by Andy on 2018/1/8.
//

#import "WFLaunchAdVC.h"
#import "UIImageView+WebCache.h"
#import "WFHelpers.h"

@interface WFLaunchAdVC ()


@property (nonatomic, assign) int countDown;

@property (nonatomic, copy) dispatch_block_t skipBlock;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imgView;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *countDownLabel;

@end

@implementation WFLaunchAdVC

+ (instancetype)launchAdVCWithSkipBlock:(dispatch_block_t)block {
    WFLaunchAdVC *vc = [[UIStoryboard storyboardWithName:@"WFAd" bundle:WFGetBundle(@"WFAd")] instantiateViewControllerWithIdentifier:@"WFLaunchAdVC"];
    vc.skipBlock = block;
    return vc;
}

- (void)viewDidLoad {
    [super viewDidLoad];
//   [_imgView sd_setImageWithURL:[NSURL URLWithString:@"https://wfshop.andysheng.cn/img/ad.png"]];
    [_imgView sd_setImageWithURL:[NSURL URLWithString:@"http://127.0.0.1:8080/eplatform/img/ad.jpg"]];

    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _countDown = 3;
    __weak typeof(self) weakSelf = self;
    if (@available(iOS 10.0, *)) {
        [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            --weakSelf.countDown;
            if (weakSelf.countDown == 0) {
                [timer invalidate];
            }
        }];
    } else {
        // Fallback on earlier versions
    }
}

- (void)setCountDown:(int)countDown {
    _countDown = countDown;
    _countDownLabel.text = @(_countDown).stringValue;
}

- (IBAction)skipClicked:(id)sender {
    if (_skipBlock) {
        _skipBlock();
    }
}

@end

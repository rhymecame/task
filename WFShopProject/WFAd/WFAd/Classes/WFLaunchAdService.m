//
//  WFLaunchAdService.m
//  ADSRouter
//
//  Created by Andy on 2018/1/8.
//

#import "WFLaunchAdService.h"
#import "WFLaunchAdProtocol.h"
#import "WFLaunchAdVC.h"
#import "BeeHive.h"
#import "WFHelpers.h"

@interface WFLaunchAdService() <WFLaunchAdProtocol>
@end

@implementation WFLaunchAdService

@BeeHiveService(WFLaunchAdProtocol, WFLaunchAdService)

- (UIViewController*)launchAdVC:(dispatch_block_t)skipBlock {
    WFLaunchAdVC *vc = [WFLaunchAdVC launchAdVCWithSkipBlock:skipBlock];
    return vc;
}

@end

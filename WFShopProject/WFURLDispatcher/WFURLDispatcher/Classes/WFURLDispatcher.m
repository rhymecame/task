//
//  WFURLDispatcher.m
//  ADSRouter
//
//  Created by Andy on 2017/12/25.
//

#import "WFURLDispatcher.h"
#import "BeeHive.h"
#import "ADSRouter.h"
#import "WFURLDispatcherProtocol.h"

@interface WFURLDispatcher () <BHModuleProtocol, WFURLDispatcherProtocol>
@end

@implementation WFURLDispatcher

//+ (void)load {
//    [[BeeHive shareInstance] registerService:@protocol(WFURLDispatcherProtocol) service:[self class]];
//}
BH_EXPORT_MODULE()
@BeeHiveService(WFURLDispatcherProtocol, WFURLDispatcher)

- (void)modInit:(BHContext *)context {
//    [[BeeHive shareInstance] registerService:@protocol(WFURLDispatcherProtocol) service:[self class]];
}
     
- (void)modOpenURL:(BHContext *)context {
    NSURL *url = context.openURLItem.openURL;
    [self openUrl:url];
}

- (void)openUrlString:(NSString *)urlString {
    [self openUrl:[NSURL URLWithString:urlString]];
}

- (void)openUrl:(NSURL *)url {
    if ([url.scheme isEqualToString:@"wfshop"]) {
        [[ADSRouter sharedRouter] openUrl:url];
    } else if ([url.scheme isEqualToString:@"http"] || [url.scheme isEqualToString:@"https"]) {
        [[ADSRouter sharedRouter] openUrlString:[NSString stringWithFormat:@"wfshop://webContainer?url=%@", url.absoluteString]];
    }
}
@end

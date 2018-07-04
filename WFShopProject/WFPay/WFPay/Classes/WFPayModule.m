//
//  WFPayModule.m
//  ADSRouter
//
//  Created by Andy on 2018/1/25.
//

#import "WFPayModule.h"
#import "BeeHive.h"

#import "BHServiceProtocol.h"
#import "BHConfig.h"
#import "BHAppDelegate.h"

#import "WFNetwork.h"

@interface ADSContext : NSObject



//global config
@property(nonatomic, strong) BHConfig *config;

//application appkey
@property(nonatomic, strong) NSString *appkey;
//customEvent>=1000
@property(nonatomic, assign) NSInteger customEvent;

@property(nonatomic, strong) UIApplication *application;

@property(nonatomic, strong) NSDictionary *launchOptions;

@property(nonatomic, strong) NSString *moduleConfigName;

@property(nonatomic, strong) NSString *serviceConfigName;

//3D-Touch model
#if __IPHONE_OS_VERSION_MAX_ALLOWED > 80400
@property (nonatomic, strong) BHShortcutItem *touchShortcutItem;
#endif

//OpenURL model
@property (nonatomic, strong) BHOpenURLItem *openURLItem;

//Notifications Remote or Local
@property (nonatomic, strong) BHNotificationsItem *notificationsItem;

//user Activity Model
@property (nonatomic, strong) BHUserActivityItem *userActivityItem;

+ (instancetype)shareInstance;

- (void)addServiceWithImplInstance:(id)implInstance serviceName:(NSString *)serviceName;

- (id)getServiceInstanceFromServiceName:(NSString *)serviceName;

@end



@interface WFPayModule() <BHModuleProtocol>

@end

@implementation WFPayModule

BH_EXPORT_MODULE()

- (void)modInit:(BHContext *)context {
    id<WFNetworkProtocol> networkService = [[BeeHive shareInstance] createService:@protocol(WFNetworkProtocol)];
    [networkService requestWithUrl:@"payment" parameters:nil option:WFRequestOptionGet|WFRequestOptionWithToken complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
        [obj.data writeToFile:@"payment.json" options:NSDataWritingAtomic error:nil];
    }];
}

- (void)modOpenURL:(BHContext *)context {
    
}

@end

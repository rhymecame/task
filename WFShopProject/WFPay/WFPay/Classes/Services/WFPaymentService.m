//
//  WFPayService.m
//  ADSRouter
//
//  Created by Andy on 2017/12/18.
//

#import "WFPaymentService.h"
#import "YYModel.h"
#import "WFPayment.h"
#import "WFPayOrder.h"
#import "WFNetwork.h"
#import "WXApi.h"
//#import "Pingpp.h"

/*
 {
 "result": {
 "package": "Sign=WXPay",
 "sign": "4b0fbba2ff052b63bad7b78672a5c5bc",
 "prepayid": "wx201801191637522772ea2e710106137532",
 "partnerid": "1482000312",
 "noncestr": "265c2b6a26807154013753637b68d01d",
 "timestamp": "1516351072"
 },
 "code": "1"
 }
 */

@interface WFWechatPrepay:NSObject

@property (nonatomic, copy) NSString *package;
@property (nonatomic, copy) NSString *sign;
@property (nonatomic, copy) NSString *prePayId;
@property (nonatomic, copy) NSString *partnerId;
@property (nonatomic, copy) NSString *nonceStr;
@property (nonatomic, assign) UInt32 timeStamp;

@end

@implementation WFWechatPrepay
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"prePayId" : @"prepayid",
             @"partnerId":@"partnerid",
             @"nonceStr":@"noncestr",
             @"timeStamp":@"timestamp"
             };
}
@end

@implementation WFPaymentService

- (void)getPayments:(void (^)(NSArray<WFPayment *> *))callback {
    NSString *apiUrl = [WFAPIFactory URLWithNameSpace:@"payment" objId:nil path:nil];
    [WFNetworkExecutor requestWithUrl:apiUrl parameters:nil option:WFRequestOptionGet complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
        if (callback) {
            callback([NSArray yy_modelArrayWithClass:[WFPayment class] json:obj.data]);
        }
    }];
}

- (void)getPayOrderWithOrderId:(NSString *)orderId callback:(void (^)(WFPayOrder *))callback {
    NSString *apiUrl = [WFAPIFactory URLWithNameSpace:@"order" objId:orderId path:nil];
    [WFNetworkExecutor requestWithUrl:apiUrl parameters:nil option:WFRequestOptionGet|WFRequestOptionWithToken complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
        if (callback) {
            callback([WFPayOrder yy_modelWithJSON:obj.data]);
        }
    }];
}

- (void)payWithOrder:(WFPayOrder *)order channel:(NSString*)channel vc:(UIViewController*)vc callback:(void (^)(void))callback {
    if ([channel isEqualToString:@"wx"]) {
        [self prePay:order.orderId callbak:^(WFWechatPrepay *prePay) {
            PayReq *request = [PayReq new];
            
            request.partnerId = prePay.partnerId;
            
            request.prepayId= prePay.prePayId;
            
            request.package = prePay.package;
            
            request.nonceStr= prePay.nonceStr;
            
            request.timeStamp= prePay.timeStamp;
            
            request.sign= prePay.sign;
            
            [WXApi sendReq:request];
        }];
    }
//    NSString *apiUrl = [WFAPIFactory URLWithNameSpace:@"charge" objId:order.orderId path:nil];
//    NSDictionary *params = @{@"channel":channel, @"amount":@(order.cost)};
//
//    __weak typeof(vc) weakVC = vc;
//    [WFNetworkExecutor requestWithUrl:apiUrl parameters:params option:WFRequestOptionPost|WFRequestOptionWithToken complete:^(NSURLResponse *response, WFNetworkResponseObj *obj, NSError *error) {
//        NSString* charge = [[NSString alloc] initWithData:[obj.data yy_modelToJSONData] encoding:NSUTF8StringEncoding];
//        [Pingpp createPayment:charge
//               viewController:weakVC
//                 appURLScheme:@"wfshop"
//               withCompletion:^(NSString *result, PingppError *error) {
//                   NSLog(@"completion block: %@", result);
//                   if (error == nil) {
//                       NSLog(@"PingppError is nil");
//                   } else {
//                       NSLog(@"PingppError: code=%lu msg=%@", (unsigned  long)error.code, [error getMsg]);
//                   }
//                   NSLog(@"%@", result);
//                   //[weakVC showAlertMessage:result];
//               }];
//    }];
}

- (void)prePay:(NSString*)orderId callbak:(void(^)(WFWechatPrepay *prePay))callback {
    [WFNetworkExecutor outRequestWithUrl:[NSString stringWithFormat:@"http://tobyli16.com:8080/pay/wechat/%@", orderId] parameters:@{@"callbackUrl":@"https://wfshop.andysheng.cn/payment/wechat_callback"} option:WFRequestOptionPost complete:^(NSURLResponse * _Nonnull response, id  _Nullable responseObject, NSError * _Nullable error) {
        if (callback) {
            callback([WFWechatPrepay yy_modelWithJSON:responseObject[@"result"]]);
        }
    }];
}

@end

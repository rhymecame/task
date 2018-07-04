//
//  WFPayService.h
//  ADSRouter
//
//  Created by Andy on 2017/12/18.
//

#import <Foundation/Foundation.h>

@class WFPayment, WFPayOrder;
@interface WFPaymentService : NSObject

- (void)getPayments:(void(^)(NSArray<WFPayment*> *payments)) callback;

- (void)getPayOrderWithOrderId:(NSString*)orderId callback:(void(^)(WFPayOrder *payOrder)) callback;

- (void)payWithOrder:(WFPayOrder*)order channel:(NSString*)channel vc:(UIViewController*)vc callback:(void(^)(void))callback;

@end

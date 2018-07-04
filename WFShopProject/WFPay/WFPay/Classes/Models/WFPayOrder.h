//
//  WFPayOrder.h
//  ADSRouter
//
//  Created by Andy on 2017/12/18.
//

#import <Foundation/Foundation.h>

@interface WFPayOrder : NSObject

@property (nonatomic, strong) NSString *orderId;
@property (nonatomic, assign) CGFloat cost;

@end

//
//  WFPayOrder.m
//  ADSRouter
//
//  Created by Andy on 2017/12/18.
//

#import "WFPayOrder.h"

@implementation WFPayOrder

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"orderId" : @"id"
             };
}

@end

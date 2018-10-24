//
//  WFNetworkResponse.h
//  ADSRouter
//
//  Created by vayhee on 2018/8/18.
//

#import <Foundation/Foundation.h>

@interface WFNetworkResponse : NSObject
@property (nonatomic, assign) NSInteger code;
@property (nonatomic, strong) id data;
@end

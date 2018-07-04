//
//  ASSectionInfo.h
//  ASDataDrivenLayout
//
//  Created by Andy on 2017/7/23.
//

#import <Foundation/Foundation.h>

@class ASCellInfo;

@interface ASSectionInfo : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *footer;
@property (nonatomic, strong) NSArray<ASCellInfo*> *cellInfos;

@end

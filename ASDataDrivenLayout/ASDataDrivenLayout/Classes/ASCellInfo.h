//
//  ASCellInfo.h
//  ASDataDrivenLayout
//
//  Created by Andy on 2017/7/23.
//

#import <Foundation/Foundation.h>

@interface ASCellInfo : NSObject

@property (nonatomic, strong) Class cellClass;
@property (nonatomic, copy) NSString *cellReuseIdentifier;
@property (nonatomic, strong) id data;
@property (nonatomic, copy) void (^didSelected)(UITableView *tableView, NSIndexPath *indexPath, id data);
@property (nonatomic, copy) void (^didDeSelected)(UITableView *tableView, NSIndexPath *indexPath, id data);
@property (nonatomic, copy) void (^fillInData)(UITableView *tableView, NSIndexPath *indexPath, __kindof UITableViewCell *cell, id data);

@end

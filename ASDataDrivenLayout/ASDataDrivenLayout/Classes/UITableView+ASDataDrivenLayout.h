//
//  UITableView+UITableView_ASDataDivenLayout.h
//  ASDataDrivenLayout
//
//  Created by Andy on 2017/7/21.
//

#import <UIKit/UIKit.h>
#import "ASSectionInfo.h"
#import "ASCellInfo.h"

@class ASDelegateAndDataSource;
@interface UITableView (ASDataDrivenLayout)

@property (nonatomic, strong, readonly) ASDelegateAndDataSource *delegateAndDataSource;
@property (nonatomic, strong) NSArray<ASSectionInfo*> *sectionInfos;
@property (nonatomic, assign) BOOL enableDataDrivenLayout;

@property (nonatomic, assign) BOOL needSectionSeparator;
@property (nonatomic, assign) CGFloat separatorHeight;
@property (nonatomic, strong) UIColor *separatorColor;


- (ASCellInfo*)as_cellInfoForIndexPath:(NSIndexPath*)indexpath;

@end


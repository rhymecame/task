//
//  ASDelegateAndDataSource.m
//  ASDataDrivenLayout
//
//  Created by Andy on 2017/7/23.
//

#import "ASDelegateAndDataSource.h"
#import "UITableView+ASDataDrivenLayout.h"
#import "ASSectionInfo.h"
#import "ASCellInfo.h"

@implementation ASDelegateAndDataSource

# pragma mark - UITableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return tableView.sectionInfos.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return tableView.sectionInfos[section].cellInfos.count;
}


- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    ASCellInfo *cellInfo = [tableView as_cellInfoForIndexPath:indexPath];
    if (cellInfo) {
        cell = [tableView dequeueReusableCellWithIdentifier:cellInfo.cellReuseIdentifier];
        if (cellInfo.fillInData) {
            cellInfo.fillInData(tableView, indexPath, cell, cellInfo.data);
        }
    }
    return cell;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return tableView.sectionInfos[section].title;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    return tableView.sectionInfos[section].footer;
}

# pragma mark - UITableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ASCellInfo *cellInfo = [tableView as_cellInfoForIndexPath:indexPath];
    if (cellInfo.didSelected) {
        cellInfo.didSelected(tableView, indexPath, cellInfo.data);
    }
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    ASCellInfo *cellInfo = [tableView as_cellInfoForIndexPath:indexPath];
    if (cellInfo.didDeSelected) {
        cellInfo.didDeSelected(tableView, indexPath, cellInfo.data);
    }
}

# pragma mark _ Private Method

@end

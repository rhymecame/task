//
//  ASViewController.m
//  ASDataDrivenLayout
//
//  Created by andysheng@live.com on 07/21/2017.
//  Copyright (c) 2017 andysheng@live.com. All rights reserved.
//

#import "ASViewController.h"
#import "UITableView+ASDataDrivenLayout.h"
#import "ASSectionInfo.h"
#import "ASCellInfo.h"

@interface ASViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation ASViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTableView];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)setupTableView {
    _tableView = [UITableView new];
    _tableView.frame = self.view.bounds;
    _tableView.enableDataDrivenLayout = YES;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"testcell"];
    ASSectionInfo *section = [ASSectionInfo new];
    NSMutableArray<ASCellInfo*> *cells = [NSMutableArray array];
    ASCellInfo *cellInfo = [ASCellInfo new];
    cellInfo.cellReuseIdentifier = @"testcell";
    cellInfo.data = @"123";
    cellInfo.cellClass = [UITableViewCell class];
    cellInfo.didSelected = ^(UITableView *tableView, NSIndexPath *indexPath, id data) {
        NSLog(@"%@", data);
    };
    cellInfo.fillInData = ^(UITableView *tableView, NSIndexPath *indexPath, __kindof UITableViewCell *cell, id data) {
        cell.textLabel.text = data;
    };
    section.cellInfos = @[cellInfo];
    _tableView.sectionInfos = @[section];
    
    
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.view addSubview:_tableView];
    NSLog(@"number of sections:%ld", [_tableView numberOfSections]);
    NSLog(@"number of rows:%ld", [_tableView numberOfRowsInSection:0]);
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 2;
    }
    return 3;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld-%ld",(long) indexPath.section, (long)indexPath.row];
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ZYBaseTableViewController.m
//  ZYProject1
//
//  Created by lanou3g on 16/5/28.
//  Copyright © 2016年 橙子. All rights reserved.
//

#import "ZYBaseTableViewController.h"

@interface ZYBaseTableViewController ()

@end

@implementation ZYBaseTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
- (NSMutableArray *)dataArray {
    
    if (!_dataArray) {
        
        _dataArray = [NSMutableArray new];
    }
    
    return _dataArray;
}

@end

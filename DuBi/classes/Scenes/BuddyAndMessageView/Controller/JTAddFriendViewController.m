//
//  JTAddFriendViewController.m
//  DuBi
//
//  Created by Jason on 16/5/21.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "JTAddFriendViewController.h"
#import "JTSearchResultControllerTableViewController.h"
#import "UIView+XYWidthHeight.h"
@interface JTAddFriendViewController ()
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (strong,nonatomic)UISearchController *searchController;
@property (strong,nonatomic)NSMutableArray *dataListArr;
@property (strong,nonatomic)NSMutableArray *resultArr;
@end

@implementation JTAddFriendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataListArr = [NSMutableArray arrayWithCapacity:10];
    self.resultArr = [NSMutableArray array];
    for (int i = 0; i < 20; i++) {
        NSString *string = [NSString stringWithFormat:@"%@-result",]
    }
    
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:[JTSearchResultControllerTableViewController new]];
    self.searchController.searchBar.frame = CGRectMake(0, 0, self.view.width, 44);
    self.searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    self.searchController.hidesNavigationBarDuringPresentation = NO;
    [self.view addSubview:self.searchController.searchBar];
    
    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

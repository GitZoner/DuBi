//
//  JTSearchViewController.m
//  DuBi
//
//  Created by Jason on 16/6/3.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "JTSearchViewController.h"
#import "JTSearchBar.h"
#import "Main_marco.h"
#import "JTBuddySearchCell.h"
#import "JTBuddyManager.h"
#import "XHToast.h"
#import <AVOSCloud/AVOSCloud.h>
#import <SDWebImage/UIButton+WebCache.h>
#import <UIImageView+WebCache.h>
@interface JTSearchViewController ()<UITextFieldDelegate>
@property (strong,nonatomic)JTSearchBar *searchBar;
@property (strong,nonatomic)NSMutableArray *searchResultList;
@end
static NSString *const JTBuddySearchCellID = @"JTBuddySearchCellID";
@implementation JTSearchViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tableViewReloadData) name:@"searchViewControllerReloadDataNotifiCation" object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _searchBar = [[JTSearchBar alloc] initWithFrame:CGRectMake(0, 30, kScreenWidth, 30)];
    _searchBar.searchTextField.delegate = self;
    [_searchBar.cancleButton  addTarget:self action:@selector(goBackAction:) forControlEvents:(UIControlEventTouchUpInside)];
    _searchBar.cancleButton.titleLabel.font = [UIFont systemFontOfSize:13];
    self.navigationItem.hidesBackButton = YES;
    self.navigationItem.titleView = _searchBar;
    self.searchResultList  = [NSMutableArray array];
   
    
   [ self.tableView registerNib:[UINib nibWithNibName:@"JTBuddySearchCell" bundle:nil] forCellReuseIdentifier:JTBuddySearchCellID];
    
}

-(void)tableViewReloadData {
    [self.tableView reloadData];
}

-(void)goBackAction:(UIButton *)button {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.searchResultList.count;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JTBuddySearchCell *cell = [tableView dequeueReusableCellWithIdentifier:JTBuddySearchCellID forIndexPath:indexPath];
    AVObject *userObject = self.searchResultList[indexPath.row];
    NSString *imageUrlString = [userObject objectForKey:@"protrait"];
    NSURL *url = [NSURL URLWithString:imageUrlString];
    
    [cell.userImageView sd_setImageWithURL:url];
    
    NSString *userName = [userObject objectForKey:@"userAlias"];
    cell.userAliasLabel.text = userName;
    
    cell.telNum = [userObject objectForKey:@"telNum"];
    cell.userAlias = userObject[@"userAlias"];

    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

#pragma mark -UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    
    return YES;
}// return NO to disallow editing.
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
}// became first responder
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    return YES;
}// return YES to allow editing to stop and to resign first responder status. NO to disallow the editing session to end
- (void)textFieldDidEndEditing:(UITextField *)textField{
    
}// may be called if forced even if shouldEndEditing returns NO (e.g. view removed from window) or endEditing:YES called

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    return YES;
}// return NO to not change text

- (BOOL)textFieldShouldClear:(UITextField *)textField{
    
    return YES;
}// called when clear button pressed. return NO to ignore (no notifications)
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    __weak typeof (JTSearchViewController *)weakSelf = self;
    [[JTBuddyManager sharedJTBuddyManager] searchBuddyWithString:textField.text searchSuccess:^(NSArray *array) {
        weakSelf.searchResultList = array.mutableCopy;
        [self.tableView reloadData];
        
        NSLog(@"%ld",array.count);
        
    } failed:^(NSError *error) {
        [XHToast showBottomWithText:@"搜索失败，请稍后重试" bottomOffset:100 duration:3];
    }];
    
    [textField resignFirstResponder];
    return YES;
}// called when 'return' key pressed. return NO to ignore.


-(void)setSearchResultList:(NSMutableArray *)searchResultList {
    if (_searchResultList != searchResultList) {
        _searchResultList = nil;
        _searchResultList = searchResultList;
    }
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

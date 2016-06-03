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
@interface JTSearchViewController ()<UITextFieldDelegate>
@property (strong,nonatomic)JTSearchBar *searchBar;
@property (strong,nonatomic)NSMutableArray *searchResultList;
@end
static NSString *const JTBuddySearchCellID = @"JTBuddySearchCellID";
@implementation JTSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _searchBar = [[JTSearchBar alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 44)];
    _searchBar.searchTextField.delegate = self;
    [_searchBar.cancleButton  addTarget:self action:@selector(goBackAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.navigationController.navigationItem.hidesBackButton = YES;
    self.navigationItem.titleView = _searchBar;
    self.searchResultList  = [NSMutableArray array];
   
    
   [ self.tableView registerClass:[JTBuddySearchCell class] forCellReuseIdentifier:JTBuddySearchCellID];
    
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
    

    
    return cell;
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
    [[JTBuddyManager sharedJTBuddyManager] searchBuddyWithString:textField.text searchSuccess:^(NSArray *array) {
        
    } failed:^(NSError *error) {
        
    }];
    
    [textField resignFirstResponder];
    return YES;
}// called when 'return' key pressed. return NO to ignore.



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

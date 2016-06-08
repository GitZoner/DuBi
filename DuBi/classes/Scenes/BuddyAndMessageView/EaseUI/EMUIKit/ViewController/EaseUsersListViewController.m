/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */

#import "EaseUsersListViewController.h"

#import "UIViewController+HUD.h"
#import "EaseMessageViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "JTBuddyManager.h"
#import "Main_marco.h"
#import "UIImageView+WebCache.h"
#import "ChatViewController.h"
#import <AVOSCloud.h>
 #import "UIScrollView+MJRefresh.h"
#import "MJRefreshComponent.h"
#import "MJRefresh.h"
@interface EaseUsersListViewController ()

@property (strong, nonatomic) UISearchBar *searchBar;
@property (strong,nonatomic)NSMutableArray  *objectsArray;
@end

@implementation EaseUsersListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
   
 
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logInNotificationAction:) name:kNotification_loginIn object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(logOutNotificationAction:) name:kNotification_loginOut object:nil];
    [self tableViewDidTriggerHeaderRefresh];
    
        // 临时
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadNewData)];
    [self.tableView.mj_header beginRefreshing];
}


- (void)reloadNewData {
    
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = nil;
        NSArray *buddyList = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
        // TODO:在这里获取环信中好友列表 ，也要从LeanCloud中获取好友列表，通过LeanCloud中的好友列表，获得用户的头像，昵称信息，并放入EaseUserModel中，给cell赋值
        NSMutableArray *queruArray = [NSMutableArray array];
        
        
        if (!error) {
            for (NSString *buddy in buddyList) {
                AVQuery *buddyQuery = [AVQuery queryWithClassName:@"userInfo"];
                [buddyQuery whereKey:@"telNum" equalTo:buddy];
                [queruArray addObject:buddyQuery];
            }
            
            AVQuery *query = [AVQuery orQueryWithSubqueries:queruArray];
            [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
                NSLog(@"好友个数 %ld",results.count);
                
                for(AVObject *buddy in results) {
                    id<IUserModel> model = nil;
                    model = [[EaseUserModel alloc] initWithBuddy:[buddy objectForKey:kUserInfoKey_telNum]];
                    model.nickname  = [buddy objectForKey:kUserInfoKey_userAlias];
                    model.avatarURLPath = [buddy objectForKey:kUserInfoKey_protrait];
                    
                    SDWebImageManager *manager = [SDWebImageManager sharedManager];
                    [manager downloadImageWithURL:[NSURL URLWithString:model.avatarURLPath]
                                          options:0
                                         progress:nil
                                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                            if (image) {
                                                NSLog(@"model头像下载了");
                                                model.avatarImage = image;
                                            }
                                        }];
                    
                    
                    if(model){
                        [weakself.dataArray addObject:model];
                    }
                }
                
                [weakself.tableView.mj_header endRefreshing];
                [weakself.tableView reloadData];
            }];
        }
        
    });
    
    
}

-(void)logInNotificationAction:(NSNotification *)notification {
   
    [self.tableView.mj_header beginRefreshing];
}

-(void)logOutNotificationAction:(NSNotification *)notification {
    [self.tableView.mj_header beginRefreshing];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - setter

- (void)setShowSearchBar:(BOOL)showSearchBar
{
    if (_showSearchBar != showSearchBar) {
        _showSearchBar = showSearchBar;
        
//        if (_showSearchBar) {
//            <#statements#>
//        }
//        else{
//            
//        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        if ([_dataSource respondsToSelector:@selector(numberOfRowInUserListViewController:)]) {
            return [_dataSource numberOfRowInUserListViewController:self];
        }
        return 0;
    }
    
    if (![kUserDefaultGetValue(kUserInfoKey_hasSign) isEqualToString:@"YES"]) {
        return 0;
    }
    
    return [self.dataArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [EaseUserCell cellIdentifierWithModel:nil];
    EaseUserCell *cell = (EaseUserCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Configure the cell...
    if (cell == nil) {
        cell = [[EaseUserCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == 0) {
        return nil;
    } else {
        id<IUserModel> model = nil;
        if ([_dataSource respondsToSelector:@selector(userListViewController:userModelForIndexPath:)]) {
            model = [_dataSource userListViewController:self userModelForIndexPath:indexPath];
        }
        else {
            model = [self.dataArray objectAtIndex:indexPath.row];
        }
        
        if (model) {
            cell.model = model;
        }
        
        return cell;
    }
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [EaseUserCell cellHeightWithModel:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    id<IUserModel> model = nil;
   
   
        model = [self.dataArray objectAtIndex:indexPath.row];
    
    if (model) {
        ChatViewController *chatController = [[ChatViewController alloc] initWithConversationChatter:model.buddy conversationType:EMConversationTypeChat];
        chatController.title = model.nickname;
        chatController.userAvater =model.avatarImage;
        chatController.avaterUrlString = model.avatarURLPath;
        chatController.nickName = model.nickname;
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:chatController animated:YES];
        
        
       

        
    }}

#pragma mark - data

- (void)tableViewDidTriggerHeaderRefresh
{
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        EMError *error = nil;
        NSArray *buddyList = [[EMClient sharedClient].contactManager getContactsFromServerWithError:&error];
        // TODO:在这里获取环信中好友列表 ，也要从LeanCloud中获取好友列表，通过LeanCloud中的好友列表，获得用户的头像，昵称信息，并放入EaseUserModel中，给cell赋值
        NSMutableArray *queruArray = [NSMutableArray array];
        
        
        if (!error) {
            for (NSString *buddy in buddyList) {
                AVQuery *buddyQuery = [AVQuery queryWithClassName:@"userInfo"];
                [buddyQuery whereKey:@"telNum" equalTo:buddy];
                [queruArray addObject:buddyQuery];
            }
            
            AVQuery *query = [AVQuery orQueryWithSubqueries:queruArray];
            [query findObjectsInBackgroundWithBlock:^(NSArray *results, NSError *error) {
                NSLog(@"好友个数 %ld",results.count);
                
                for(AVObject *buddy in results) {
                    id<IUserModel> model = nil;
                    model = [[EaseUserModel alloc] initWithBuddy:[buddy objectForKey:kUserInfoKey_telNum]];
                    model.nickname  = [buddy objectForKey:kUserInfoKey_userAlias];
                    model.avatarURLPath = [buddy objectForKey:kUserInfoKey_protrait];
                    
                    SDWebImageManager *manager = [SDWebImageManager sharedManager];
                    [manager downloadImageWithURL:[NSURL URLWithString:model.avatarURLPath]
                                          options:0
                                         progress:nil
                                        completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished, NSURL *imageURL) {
                                            if (image) {
                                                NSLog(@"model头像下载了");
                                                model.avatarImage = image;
                                            }
                                        }];
                    
                    
                    if(model){
                        [weakself.dataArray addObject:model];
                    }
                }
                
                [weakself tableViewDidFinishTriggerHeader:YES reload:YES];
            }];
        }
        
    });
}

- (void)dealloc
{
}

@end

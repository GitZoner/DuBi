//
//  JTNotificationViewController.m
//  DuBi
//
//  Created by Jason on 16/6/3.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "JTNotificationViewController.h"
#import "SessionCell.h"
#import <HyphenateFullSDK/EMSDKFull.h>
#import "JTNotificationModel.h"
#import <AVOSCloud.h>
@interface JTNotificationViewController ()<EMContactManagerDelegate>
@property (strong,nonatomic)NSMutableArray *notificationArray;

@end
// 通知 cell 的重用标识符
static NSString *const NotificationCellReuseidentifier = @"NotificationCellID";
static NSString *const sessionCellID  = @"sessionCellID";
@implementation JTNotificationViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //注册好友回调
    [[EMClient sharedClient].contactManager addDelegate:self delegateQueue:nil];
    self.notificationArray = [NSMutableArray array];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"SessionCell" bundle:nil] forCellReuseIdentifier:sessionCellID];
    
}

// 监听好友请求
- (void)didReceiveFriendInvitationFromUsername:(NSString *)aUsername
                                       message:(NSString *)aMessage {
    JTNotificationModel *model = [JTNotificationModel new];
    model.message = aMessage;
    model.userName = aUsername;
    
    // 日期类
    NSDate *date = [NSDate date];// 什么创建的date。就是什么时候的时间
    // 管理日期格式的类
    NSDateFormatter *formatter = [NSDateFormatter new];
    [   formatter setDateFormat:@"yyyy年MM月dd日 hh:mm:ss"];
    // 从日期中按照格式提取字符串
    NSString *dateString = [formatter stringFromDate:date];
    dateString = [dateString substringWithRange:NSMakeRange(11, 5)];
    model.postTime = dateString;
    [self.notificationArray insertObject:model atIndex:0];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationTop)];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationTop)];
}

// 同意添加好友的回调
- (void)didReceiveAgreedFromUsername:(NSString *)aUsername {
    JTNotificationModel *model = [JTNotificationModel new];
    
    AVQuery *query = [AVQuery queryWithClassName:@"userInfo"];
    [query whereKey:@"telNum" equalTo:aUsername];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects.count > 0) {
            model.message = [NSString stringWithFormat:@"%@拒绝了你的好友请求",objects[0]];
        }
    }];
    
    
    
    
    
    // 日期类
    NSDate *date = [NSDate date];// 什么创建的date。就是什么时候的时间
    // 管理日期格式的类
    NSDateFormatter *formatter = [NSDateFormatter new];
    [   formatter setDateFormat:@"yyyy年MM月dd日 hh:mm:ss"];
    // 从日期中按照格式提取字符串
    NSString *dateString = [formatter stringFromDate:date];
    dateString = [dateString substringWithRange:NSMakeRange(11, 5)];
    model.postTime = dateString;
    [self.notificationArray insertObject:model atIndex:0];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationTop)];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationTop)];
}

// 拒绝添加好友的回调
- (void)didReceiveDeclinedFromUsername:(NSString *)aUsername {
    JTNotificationModel *model = [JTNotificationModel new];
    
    AVQuery *query = [AVQuery queryWithClassName:@"userInfo"];
    [query whereKey:@"telNum" equalTo:aUsername];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (objects.count > 0) {
            model.message = [NSString stringWithFormat:@"%@同意了你的好友请求",objects[0]];
        }
    }];
    
    
    
    
    
    // 日期类
    NSDate *date = [NSDate date];// 什么创建的date。就是什么时候的时间
    // 管理日期格式的类
    NSDateFormatter *formatter = [NSDateFormatter new];
    [   formatter setDateFormat:@"yyyy年MM月dd日 hh:mm:ss"];
    // 从日期中按照格式提取字符串
    NSString *dateString = [formatter stringFromDate:date];
    dateString = [dateString substringWithRange:NSMakeRange(11, 5)];
    model.postTime = dateString;
    [self.notificationArray insertObject:model atIndex:0];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    
    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationTop)];
    [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:(UITableViewRowAnimationTop)];
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.notificationArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     SessionCell *cell = [tableView dequeueReusableCellWithIdentifier:sessionCellID forIndexPath:indexPath];
    JTNotificationModel *model = self.notificationArray[indexPath.row];
    cell.contentLabel.text = model.message;
    cell.postTimeLabel.text = model.postTime;
    cell.userName = model.userName;

    return cell;
}



// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}
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

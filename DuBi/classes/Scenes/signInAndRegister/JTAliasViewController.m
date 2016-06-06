//
//  JTAliasViewController.m
//  DuBi
//
//  Created by Jason on 16/5/27.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "JTAliasViewController.h"
#import "JTRegisterViewController.h"
#import <AVOSCloud/AVOSCloud.h>
#import "JTBuddyManager.h"
#import "Main_marco.h"
#import "XHToast.h"
@interface JTAliasViewController ()

@property (weak, nonatomic) IBOutlet UITextField *userAlias; // 用户别名
@end

@implementation JTAliasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)completedRegisterAction:(UIButton *)sender {
    
    [[NSUserDefaults standardUserDefaults] setObject:self.userAlias.text forKey:@"userAlias" ];
    
    AVQuery *query = [AVQuery queryWithClassName:@"userInfo"];
    [query getObjectInBackgroundWithId:[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"] block:^(AVObject *object, NSError *error) {
        [object setObject:self.userAlias.text forKey:@"userAlias"];
        [object saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            NSLog(@"保存昵称是否成功：%d",succeeded);
        }];
       
    }];
    
    [[JTBuddyManager sharedJTBuddyManager] loginWithUsername:kUserDefaultGetValue(kUserInfoKey_telNum) password:kUserDefaultGetValue(kUserInfoKey_passWord) successed:^{
        [XHToast showBottomWithText:@"登录成功" bottomOffset:100 duration:3];
          } failed:^(NSError *error) {
        [XHToast showBottomWithText:@"登录失败，请稍后重试" bottomOffset:100 duration:3];
    }];
    
    [self.navigationController popToRootViewControllerAnimated:YES];
    
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

//
//  JTBuddyManager.m
//  DuBi
//
//  Created by Jason on 16/5/20.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "JTBuddyManager.h"
#import <HyphenateFullSDK/EMSDKFull.h>
#import "Main_marco.h"
@interface JTBuddyManager  () <EMContactManagerDelegate>
// 环信管理对象（单例）
@property (strong,nonatomic)EMClient *emClient;
// 存放所有好友的数组
@property (strong,nonatomic)NSMutableArray *userList;
@end


@implementation JTBuddyManager
/**
 *  类单例方法的实现
 */
singleton_implementation(JTBuddyManager);

/**
 *  覆写初始化方法，在初始化方法中实现，环信的初始化
 *
 *  @return 该类初始化的对象
 */

- (instancetype)init
{
    self = [super init];
    if (self) {
        // 初始化环信
        EMOptions *options = [EMOptions optionsWithAppkey:@"colorfulyogurt#dubi"];// 环信AppKey
        options.apnsCertName = @"istore_dev";// 苹果推送证书
       
        _emClient = [EMClient sharedClient];
      [_emClient initializeSDKWithOptions:options];
        // 好友管理的代理
        [self.emClient.contactManager addDelegate:self delegateQueue:nil];
        
    }
    return self;
}


#pragma mark -登录方法
-(void)loginWithUsername:(NSString *)userName password:(NSString *)passWord successed:(Successed)successed failed:(Failed)failed {
    
    // 环信登录
    EMError *error = [self.emClient loginWithUsername:userName  password:passWord];
    if (!error) {
        successed();
        
    }else {
        NSLog(@"%@",error);
        failed();
    }
}
#pragma mark -注册方法
-(void)registerWithUsername:(NSString *)userName password:(NSString *)passWord successed:(Successed)successed failed:(Failed)failed {
    // 环信注册
    EMError *error = [self.emClient registerWithUsername:userName password:passWord];
    if (!error) {
        successed();
    }else {
        NSLog(@"%@",error);
        failed();
    }
}
#pragma mark -添加好友方法
-(void)addContact:(NSString *)userName message:(NSString *)leaveMessage successed:(Successed)successed failed:(Failed)failed {
    EMError *error = [self.emClient.contactManager addContact:userName message:leaveMessage];
    
    if (!error) {
        successed();
    }else {
        failed();
    }
}

#pragma  mark - EMContactManagerDelegate /收到好友请求的回调-
- (void)didReceiveFriendInvitationFromUsername:(NSString *)aUsername message:(NSString *)aMessage {
    // 使用通知中心
    [[NSNotificationCenter defaultCenter] postNotificationName:JT_NewFriendInvitationNotification object:self userInfo:@{@"userName":aUsername,@"message":aMessage}];
}
#pragma mark - 好友申请处理结果的回调
// 对方同意添加为好友
- (void)didReceiveAgreedFromUsername:(NSString *)aUsername {
    [[NSNotificationCenter defaultCenter] postNotificationName:JT_FriendApplyResult object:self userInfo:@{@"result":@"YES"}];
}
// 对方拒绝添加为好友
- (void)didReceiveDeclinedFromUsername:(NSString *)aUsername {
    [[NSNotificationCenter defaultCenter] postNotificationName:JT_FriendApplyResult object:self userInfo:@{@"result":@"NO"}];
}
@end

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
#import <AVOSCloud/AVOSCloud.h>

#define kUserDefaultSetValue(value,key) [[NSUserDefaults standardUserDefaults]  setValue:value forKey:key]
#define kUserDefaultGetValue(key) [[NSUserDefaults standardUserDefaults] objectForKey: key]

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
        NSLog(@"环信登录错误：%@",error);
        NSError *aError = [NSError errorWithDomain:@"登录失败，稍后重试" code:001 userInfo:nil];
        failed(aError);
    }
}
#pragma mark -注册方法
-(void)registerWithUsername:(NSString *)userName password:(NSString *)passWord successed:(Successed)successed failed:(Failed)failed {
    // 环信注册
    EMError *error = [self.emClient registerWithUsername:userName password:@"123456"];
    if (error == nil || error.code == EMErrorUserAlreadyExist) {
        
        AVQuery *query = [AVQuery queryWithClassName:@"userInfo"];
        [query whereKey:@"telNum" equalTo:userName];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (objects.count == 0) {
                AVObject *newUser = [[AVObject alloc] initWithClassName:@"userInfo"];// 构建对象
                [newUser setObject:userName forKey:@"telNum"];// 设置名称
                [newUser setObject:passWord forKey:@"passWord"];
                [newUser saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded) {
                        // 存储成功
                        NSLog(@"%@",newUser.objectId);// 保存成功之后，objectId 会自动从服务端加载到本地
                        kUserDefaultSetValue(newUser.objectId, @"userID");
                        kUserDefaultSetValue(userName, @"telNum");
                        kUserDefaultSetValue(passWord, @"passWord");
                        // 设置登录状态
                        kUserDefaultSetValue(@"YES", @"hasSign");
                        [[JTBuddyManager sharedJTBuddyManager] loginWithUsername:userName password:@"123456" successed:^{
                            NSLog(@"环信注册成功并实现登录");
                        } failed:^(NSError * error) {
                            NSLog(@"环信注册成功，但登录失败");
                        }];
                        successed();
                        
                    } else {
                        NSLog(@"LeanCloud用户注册写入失败");
                        NSError *aError = [NSError errorWithDomain:@"注册失败，请稍后重试" code:002 userInfo:nil];
                        failed(aError);
                    }
                }];
            }else {
                
            }
        }];
        
        
        
    }else {
            NSLog(@"环信注册错误：%@",error);
            NSError *aError = [NSError errorWithDomain:@"注册失败，稍后重试" code:002 userInfo:nil];
            failed(aError);
       
    }
    
}
#pragma mark -添加好友方法
-(void)addContact:(NSString *)userName message:(NSString *)leaveMessage successed:(Successed)successed failed:(Failed)failed {
    EMError *error = [self.emClient.contactManager addContact:userName message:leaveMessage];
    
    if (!error) {
        successed();
    }else {
        NSLog(@"环信发送好友请求出错：%@",error);
        NSError *aError = [NSError errorWithDomain:@"发送好友请求失败，稍后重试" code:003 userInfo:nil];
        failed(aError);
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

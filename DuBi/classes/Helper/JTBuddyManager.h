//
//  JTBuddyManager.h
//  DuBi
//
//  Created by Jason on 16/5/20.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"

typedef void(^Successed)(void);
typedef void(^Failed)(void);
@interface JTBuddyManager : NSObject
/**
 *  该类单例方法的声明
 */
singleton_interface(JTBuddyManager);

/**
 *  根据用户名和密码进行登录
 *
 *  @param userName  用户名
 *  @param passWord  密码
 *  @param successed 登录成功后的block回调
 *  @param failed    登录失败后的block回调
 */
-(void)loginWithUsername:(NSString *)userName password:(NSString *)passWord successed:(Successed)successed failed:(Failed)failed;

/**
 *  根据用户名和密码进行注册
 *
 *  @param userName  用户名
 *  @param passWord  密码
 *  @param successed 注册成功后的block回调
 *  @param failed    注册失败后的block回调
 */
-(void)registerWithUsername:(NSString *)userName password:(NSString *)passWord successed:(Successed)successed failed:(Failed)failed;
/**
 *  指定用户名，向对方发送好友请求
 *
 *  @param userName     指定的用户名
 *  @param leaveMessage 留言信息
 *  @param successed    发送请求后的block回调事件
 *  @param failed       发送请求失败的Bloc回调
 */
-(void)addContact:(NSString *)userName message:(NSString *)leaveMessage successed:(Successed)successed failed:(Failed)failed;
@end

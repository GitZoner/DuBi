//
//  UserInfo.h
//  DuBi
//
//  Created by Jason on 16/5/27.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
@property (strong,nonatomic)NSString *telNum; // 手机号，当做用户名使用
@property (strong,nonatomic)NSString *passWord; // 密码
@property (strong,nonatomic)NSString *gender; // 性别
@property (strong,nonatomic)NSString *userAlias; // 用户名昵称
@property (strong,nonatomic)NSString *protrait; // 用户头像

-(instancetype)initWithTelNum:(NSString *)telNum passWord:(NSString *)passWord userAlias:(NSString *)userAlias protrait:(NSString *)protrait gender:(NSString *)gender;
+(instancetype)userInfoWithTelNum:(NSString *)telNum passWord:(NSString *)passWord userAlias:(NSString *)userAlias protrait:(NSString *)protrait gender:(NSString *)gender;
@end

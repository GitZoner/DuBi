//
//  JTLocalInfoManager.m
//  DuBi
//
//  Created by Jason on 16/5/27.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "JTLocalInfoManager.h"
#import <AVOSCloud/AVOSCloud.h>
#define kUserDefaultSetValue(value,key) [[NSUserDefaults standardUserDefaults]  setValue:value forKey:key]
#define kUserDefaultGetValue(key) [[NSUserDefaults standardUserDefaults] objectForKey: key]
@implementation JTLocalInfoManager


// 向本地存入用户信息
+(void)writeUserInfo:(UserInfo *)userInfo {
    kUserDefaultSetValue(userInfo.telNum,@"telNum");
    kUserDefaultSetValue(userInfo.passWord,@"passWord");
    kUserDefaultSetValue(userInfo.userAlias,@"userAlias");
    kUserDefaultSetValue(userInfo.protrait,@"protrait");
}



@end

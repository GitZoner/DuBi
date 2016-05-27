//
//  JTLocalInfoManager.h
//  DuBi
//
//  Created by Jason on 16/5/27.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"
@interface JTLocalInfoManager : NSObject

// 向本地存入用户信息
+(void)writeUserInfo:(UserInfo *)userInfo;
// 取出本地储存的用户信息
+(UserInfo *)getUserInfo;
@end

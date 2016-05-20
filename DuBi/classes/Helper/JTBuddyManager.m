//
//  JTBuddyManager.m
//  DuBi
//
//  Created by Jason on 16/5/20.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "JTBuddyManager.h"
#import <HyphenateFullSDK/EMSDKFull.h>
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
        //AppKey:注册的AppKey，详细见下面注释。
        //apnsCertName:推送证书名（不需要加后缀），详细见下面注释。
        EMOptions *options = [EMOptions optionsWithAppkey:@"douser#istore"];
        options.apnsCertName = @"istore_dev";
        [[EMClient sharedClient] initializeSDKWithOptions:options];
    }
    return self;
}
@end

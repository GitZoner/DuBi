//
//  JTBuddyManager.m
//  DuBi
//
//  Created by Jason on 16/5/20.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "JTBuddyManager.h"
    #import <HyphenateFullSDK/EMSDKFull.h>

@interface JTBuddyManager  ()


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
        [[EMClient sharedClient] initializeSDKWithOptions:options];
    }
    return self;
}
@end

//
//  AppDelegate.m
//  DuBi
//
//  Created by Jason on 16/5/19.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "AppDelegate.h"
#import "JTTabBarController.h"
#import "JTBuddyManager.h"
#import <HyphenateFullSDK/EMSDKFull.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 设置window,并将自定义的TabBarController设置为Window的根视图
    [self setWindowAndRootVC];
    // 初始化好友管理器
    [JTBuddyManager sharedJTBuddyManager];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // 环信进入后台
    [[EMClient sharedClient] applicationDidEnterBackground:application];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // 环信进入前台
    [[EMClient sharedClient] applicationWillEnterForeground:application];
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
   
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}


#pragma  mark - 私有方法

// 设置Window和TabBarController
-(void)setWindowAndRootVC {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [JTTabBarController new];
}
@end

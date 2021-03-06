//
//  AppDelegate.m
//  DuBi
//
//  Created by Jason on 16/5/19.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "AppDelegate.h"
#import "JTTabBarViewController.h"
#import "JTBuddyManager.h"
#import <HyphenateFullSDK/EMSDKFull.h>
#import <AVOSCloud/AVOSCloud.h>
#import "SMS_SDK/SMSSDK.h"
#import "Main_marco.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 设置window,并将自定义的TabBarController设置为Window的根视图
    [self setWindowAndRootVC];
    
    
    // 初始化好友管理器
    [JTBuddyManager sharedJTBuddyManager];
    // 初始化LeanCloud 
    [AVOSCloud setApplicationId:@"8tm8naURIXLSgN6PA1s0WX5k-gzGzoHsz"
                      clientKey:@"D0bIdvMxENczaL99oW4COiTh"];
    // 初始化SMS短信验证
    [SMSSDK registerApp:@"131e887afbb88"  withSecret:@"853b0f044d7694f72c7a9a7de182671b"];
    
    
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
    
    kUserDefaultSetValue(@"NO", kUserInfoKey_hasSign);
}


#pragma  mark - 私有方法

// 设置Window和TabBarController
-(void)setWindowAndRootVC {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[JTTabBarViewController new]];
    UINavigationController * NC = (UINavigationController *)self.window.rootViewController;
    // [UINavigationBar appearance].barTintColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

}
@end

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
    AVObject *post = [AVObject objectWithClassName:@"TestObject"];
    [post setObject:@"Hello World!" forKey:@"words"];
    [post saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // 是大法官保存成功了！
            NSLog(@"sdfgsdfgsd");
        }else {
            NSLog(@"+++++++++%@",error);
            
        }
    }];
    
    
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
    self.window.rootViewController = [JTTabBarViewController new];
}
@end

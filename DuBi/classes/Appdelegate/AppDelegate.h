//
//  AppDelegate.h
//  DuBi
//
//  Created by Jason on 16/5/19.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+(AppDelegate *)getAppDelegate;
-(UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)theTize;
@end


//
//  ChatViewController.h
//  DuBi
//
//  Created by Jason on 16/6/1.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "EaseMessageViewController.h"
#import <AVOSCloud.h>
#define KNOTIFICATIONNAME_DELETEALLMESSAGE @"RemoveAllMessages"
@interface ChatViewController : EaseMessageViewController
@property (strong,nonatomic)AVObject  *user;
@property (strong,nonatomic)UIImage *userAvater;
@property (strong,nonatomic)NSString *avaterUrlString;
@property (strong,nonatomic)NSString *nickName;
@end

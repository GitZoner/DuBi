//
//  Main_marco.h
//  DuBi
//
//  Created by Jason on 16/5/20.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#ifndef Main_marco_h
#define Main_marco_h

#pragma mark - 通知中心的通知名称
// 有人申请添加好友的通知
#define JT_NewFriendInvitationNotification  @"NewFriendInvitation"
// 申请添加好友，对方的处理结果的通知名
#define JT_FriendApplyResult @"FriendApplyResult"

// NSUsrDeflauts中的key
#define kUserInfoKey_telNum @"telNum"
#define kUserInfoKey_passWord @"passWord"
#define kUserInfoKey_protrait @"protrait"
#define kUserInfoKey_userAlias @"userAlias"
#define kUserInfoKey_gender @"gender"
#define kUserInfoKey_userID @"userID"
#define kUserInfoKey_hasSign @"hasSign"

#define kUserDefaultValue_void @"void"

#define kUserDefaultSetValue(value,key) [[NSUserDefaults standardUserDefaults]  setValue:value forKey:key]
#define kUserDefaultGetValue(key) [[NSUserDefaults standardUserDefaults] objectForKey: key]

// 数据库表关键字
#define kLikeModelListKey_likerID @"likerID"
#define kLikeModelListKey_likerName @"likerName"

#define kCommentModelListKey_firstID @"firstID"
#define kCommentModelListKey_secondID @"secondID"
#define kCommentModelListKey_firstName @"firstName"
#define kCommentModelListKey_secondName @"secondName"
#define kCommentModelListKey_comment @"comment"

// 通知名

// 登录通知
#define kNotification_loginIn @"JTLoginNotification"

// 退出登录通知
#define kNotification_loginOut @"JTLoginOutNotification"

#define kNotification_conversationReload @"conversationReload"

#define kScreenWidth [UIScreen mainScreen].bounds.size.width
#define kscreenHeight [UIScreen mainScreen].bounds.size.height

#endif /* Main_marco_h */

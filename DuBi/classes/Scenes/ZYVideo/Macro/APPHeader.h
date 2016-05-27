//
//  APPHeader.h
//  ProjectMusic
//
//  Created by young on 15/7/31.
//  Copyright (c) 2015年 young. All rights reserved.
//  这里存放普通的app宏定义和声明等信息.

#ifndef Project_APPHeader_h
#define Project_APPHeader_h

#define kScreenWidth CGRectGetWidth([UIScreen mainScreen].bounds)
#define kScreenHeight CGRectGetHeight([UIScreen mainScreen].bounds)

#import "RootTableViewController.h"
#import "HeadView.h"
#import "HeardButton.h"
#import "VideoSid.h"
#import "Video.h"
#import "GetVideoDataTools.h"
#import "RootTableViewCell.h"
#import "VideoViewController.h"
#import "HeardTableViewController.h"



// URL
#define homeURL @"http://c.m.163.com/nc/video/home/0-10.html"
#define moreURL @"http://c.m.163.com/nc/video/home/%ld-10.html"
#define listURL @"http://c.3g.163.com/nc/video/list/%@/y/0-10.html"
#define listMoreURL @"http://c.3g.163.com/nc/video/list/%@/y/%ld-10.html"


#import "APPHeader.h"
#import "IMPHeader.h"
#import "KEYHeader.h"
#import "URLHeader.h"


#import "UIImageView+WebCache.h" // 图片请求
#import "FMGVideoPlayView.h"     // 播放器视图
#import "MJRefresh.h"            // 上拉刷新
#import "CFDanmakuView.h"


#define Project_KEYHeader_h









































//TODO 提示
#define STRINGIFY(S) #S
#define DEFER_STRINGIFY(S) STRINGIFY(S)
#define PRAGMA_MESSAGE(MSG) _Pragma(STRINGIFY(message(MSG)))
#define FORMATTED_MESSAGE(MSG) "[TODO-" DEFER_STRINGIFY(__COUNTER__) "] " MSG " \n" \
DEFER_STRINGIFY(__FILE__) " line " DEFER_STRINGIFY(__LINE__)
#define KEYWORDIFY try {} @catch (...) {}
// 最终使用下面的宏
#define TODO(MSG) KEYWORDIFY PRAGMA_MESSAGE(FORMATTED_MESSAGE(MSG))


#endif

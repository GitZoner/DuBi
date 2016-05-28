//
//  Picture.h
//  DuBi
//
//  Created by lanou3g on 16/5/24.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Picture : NSObject
@property(strong,nonatomic)NSString *name;// 用户的名字
@property(strong,nonatomic)NSString *text;// 标题内容
@property(strong,nonatomic)NSString *profile_image;// 用户的头像
@property(strong,nonatomic)NSString *love;// 赞的人数
@property(strong,nonatomic)NSString *hate;// 踩得人数
@property(strong,nonatomic)NSString *comment; // 评论的人数
@property(strong,nonatomic)NSString *weixin_url;// 分享的链接
@property(strong,nonatomic)NSString *cdn_img;// 动态图
@property(assign,nonatomic)CGFloat width; // 图片的宽度
@property(assign,nonatomic)CGFloat height; // 图片的高度
@property(nonatomic)BOOL is_gif;//是否是gif类型
@property(assign,nonatomic)CGFloat type;
@end

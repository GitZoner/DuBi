//
//  Topic.h
//  DuBi
//
//  Created by lanou3g on 16/5/19.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Topic : NSObject
@property(strong,nonatomic)NSString *text; // 段子的内容
@property(strong,nonatomic)NSString *name; // 段子的标题
@property(strong,nonatomic)NSString *commment; // 评论的个数
@property(strong,nonatomic)NSString *love; // 喜欢的人数
@property(strong,nonatomic)NSArray *top_cmt;// 存储评论的数组
@property(strong,nonatomic)NSString *content;// 最热的评论；
@end

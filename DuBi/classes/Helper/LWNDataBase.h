//
//  LWNDataBase.h
//  DuBi
//
//  Created by lanou3g on 16/5/21.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import "Topic.h"
#import <sqlite3.h>
@class Topic;
@interface LWNDataBase : NSObject


#pragma mark 打开数据库
- (void)openDB;
#pragma mark 关闭数据库
- (void)closeDB;




#pragma mark ------------Topic 段子的操作 ,数据库操作--------

#pragma mark 添加新的段子
- (void)insertNewActivity:(Topic *)topic;
#pragma mark 删除某个段子
- (void)deleteActivity:(Topic *)topic;
#pragma mark 获取所有的段子
- (NSMutableArray *)selectAlltopic;
#pragma mark 判断段子是否被收藏
- (BOOL)isFavoriteActivityWithID:(NSString *)ID;





// 单例类的声明
singleton_interface(LWNDataBase);

@end

//
//  InfomationHandle.h
//  DuBi
//
//  Created by lanou3g on 16/5/19.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Topic.h"
#import "NetWorkRequest.h"
#import <UIKit/UIKit.h>
#import "Singleton.h"
typedef void(^Completion) (NSArray *array,NSError *error);
// 请求数据工具类
@interface InfomationHandle : NSObject
// 请求数据并且将数据存储到数组当中
-(void)getModelDataWithUrl:(NSString *)urlString comption:(Completion)completion;
// 返回分区的个数
-(NSInteger)numberOfSections;


// 返回行的个数
-(NSInteger)numberOfRowsInsection:(NSInteger)inSection;



// 返回model对象
-(Topic *)topicForRowAtIndexPath:(NSIndexPath *)indexPath;

// 单例类的声明

singleton_interface(InfomationHandle);

@end

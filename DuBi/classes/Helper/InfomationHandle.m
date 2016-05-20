//
//  InfomationHandle.m
//  DuBi
//
//  Created by lanou3g on 16/5/19.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "InfomationHandle.h"
@interface InfomationHandle ()
@property(strong,nonatomic)NSMutableArray *topicArray;// 存储所有对象的数组
@end
@implementation InfomationHandle
// 懒加载数组
-(NSMutableArray *)topicArray{
    if (!_topicArray) {
        _topicArray = [NSMutableArray array];
    }
    return _topicArray;
}
// 请求数据并且将数据存储到数组当中
-(void)getModelDataWithUrl:(NSString *)urlString comption:(Completion)completion{
   [NetWorkRequest requesType:GET UrlString:urlString Param:nil succedBlock:^(id data) {
       NSError *error = nil;
      // 进行数据解析
       NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
       //
       NSArray *array = dict[@"list"];
       for (NSDictionary *modelDict in array) {
           if (modelDict[@"top_cmt"]) {
               Topic *topic = [Topic new];
               [topic setValuesForKeysWithDictionary:modelDict];
               [self.topicArray addObject:topic];
           }
        }
       if (completion) {
           dispatch_async(dispatch_get_main_queue(), ^{
               completion(_topicArray,error);
           });
       }
   } failedBlock:^(NSError *error) {
       
   }];



}
// 返回分区的个数
-(NSInteger)numberOfSections{
    return 1;
}


// 返回行的个数
-(NSInteger)numberOfRowsInsection:(NSInteger)inSection{
    return _topicArray.count;

}



// 返回model对象
-(Topic *)topicForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    
    return _topicArray[indexPath.row];

}
// 单例类的实现
singleton_implementation(InfomationHandle);
@end

//
//  PictureHandle.m
//  DuBi
//
//  Created by lanou3g on 16/5/24.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "PictureHandle.h"
@interface PictureHandle()
@property(strong,nonatomic)NSMutableArray *pictureArray;
@end
@implementation PictureHandle
// 懒加载数组
-(NSMutableArray *)pictureArray{
    if (!_pictureArray) {
        _pictureArray = [NSMutableArray array];
    }
    return _pictureArray;
}

// 数据请求解析
-(void)getDataWithString:(NSString *)urlString comptionBlock:(PictureHandleBlock )comptionBlock{
  [NetWorkRequest requesType:GET UrlString:urlString Param:nil succedBlock:^(id data) {
      NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
      NSArray *array = dict[@"list"];
   _pictureArray = nil;
      for (NSDictionary *modelDict in array) {
          Picture *picture = [Picture new];
          [picture setValuesForKeysWithDictionary:modelDict];
          [self.pictureArray addObject:picture];
      }
      dispatch_async(dispatch_get_main_queue(), ^{
          comptionBlock(_pictureArray);

      });
  } failedBlock:^(NSError *error) {
      
  }];

}
// 返回分区个数
-(NSInteger)numberOfSections{

    return 1;
}
// 返回cell的个数
-(NSInteger)numofRowsAtSection:(NSInteger)section{
    NSLog(@"%ld",_pictureArray.count);
    return _pictureArray.count;
}

// 返回具体某个对象
-(Picture *)pictureForCellAtIndexPath:(NSIndexPath *)indexPath{
    return _pictureArray[indexPath.row];
}










singleton_implementation(PictureHandle);
@end

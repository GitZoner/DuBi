//
//  LWNTableView.m
//  DuBi
//
//  Created by lanou3g on 16/5/27.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "LWNTableView.h"
#import "PictureHandle.h"
#import "NetWorkRequest.h"
#import "Picture.h"

@implementation LWNTableView
//-(NSMutableArray *)array{
//    if (!_dataArray) {
//        _dataArray = [NSMutableArray array];
//    }
//    return _dataArray;
//}
/*
-(instancetype)initWithFrame:(CGRect)frame withUrl:(NSString *)string{
    if (self = [super initWithFrame:frame]) {
      // 请求数据
          _dataArray = [NSMutableArray array];
        [NetWorkRequest requesType:GET UrlString:string Param:nil succedBlock:^(id data) {
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
            NSArray *array = dict[@"list"];
            for (NSDictionary *modelDict in array) {
                Picture *picture = [Picture new];
                [picture setValuesForKeysWithDictionary:modelDict];
                [self.dataArray addObject:picture];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                //comptionBlock(_pictureArray);
                [self reloadData];
                
            });
        } failedBlock:^(NSError *error) {
            
        }];
        
    }

    return self;
}
 */
/**
 *  返回加载更多数据的数组
 *
 *  @param array 存放数据的数组
 *
 *  @return 返回数组
 */


-(void)getDataWithString:(NSString *)urlString{


    // 请求数据
    [NetWorkRequest requesType:GET UrlString:urlString Param:nil succedBlock:^(id data) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
        NSArray *array = dict[@"list"];
        _dataArray = [NSMutableArray array];
        for (NSDictionary *modelDict in array) {
            Picture *picture = [Picture new];
            [picture setValuesForKeysWithDictionary:modelDict];
            [self.dataArray addObject:picture];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadData];
        });
    } failedBlock:^(NSError *error) {
        
    }];
    



}


-(NSInteger)numberOfRows:(NSInteger)section{

    
    return self.dataArray.count;
}
// 具体的某个对象
-(Picture *)piturForRowInSection:(NSIndexPath*)indexPath{
   
    return self.dataArray[indexPath.row];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
@end

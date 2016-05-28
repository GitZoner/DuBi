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

-(instancetype)initWithFrame:(CGRect)frame withUrl:(NSString *)string{
    if (self = [super initWithFrame:frame]) {
      // 请求数据
       [NetWorkRequest requesType:GET UrlString:string Param:nil succedBlock:^(id data) {
           NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingAllowFragments) error:nil];
           NSArray *array1 = dict[@"list"];
           for (NSDictionary *modelDict in array1) {
               Picture *picture = [Picture new];
               [picture setValuesForKeysWithDictionary:modelDict];
               [self.array addObject:picture];
           }

       } failedBlock:^(NSError *error) {
           
       }];
    }
    

    return self;
}
//-(NSArray *array)arrayWithURL:(NSString *)String
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

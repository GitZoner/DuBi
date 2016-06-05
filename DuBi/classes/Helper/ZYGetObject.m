//
//  ZYGetObject.m
//  DuBi
//
//  Created by lanou3g on 16/6/3.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZYGetObject.h"

#import <AVOSCloud/AVOSCloud.h>
#import "ZYTimeLineCellModel.h"

@interface ZYGetObject ()

/*model*/
@property (strong, nonatomic) ZYTimeLineCellModel *zymodel;

/*存放数据的数组*/
@property (strong, nonatomic) NSMutableArray *arr;

@end


@implementation ZYGetObject
static ZYGetObject *sington = nil;

+ (instancetype)sharedZYGetObject{
    
    if (nil == sington) {
        
        sington = [ZYGetObject new];
    }
    
    return sington;
}

- (NSArray *)userDeliverInfoWithClassName:(NSString *)name {
    
    AVQuery *query = [AVQuery queryWithClassName:name];
    _arr = [NSMutableArray array];
    
    for (AVObject *object in [query findObjects]) {
        
        _zymodel = [ZYTimeLineCellModel new];
        _zymodel.userAlias = object[@"userAlias"];
        _zymodel.publishType = object[@"publishType"];
        _zymodel.msgContent = object[@"msgContent"];
        
        _zymodel.createdAt = object[@"createdAt"];
        
        [_arr addObject:_zymodel];
    }
    
    return _arr;

}
@end

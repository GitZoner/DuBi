//
//  NetWorkRequest.h
//  DuBi
//
//  Created by lanou3g on 16/5/19.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Singleton.h"
typedef NS_ENUM(NSInteger,State) {
    
    loginState,
    registState,
    
};
typedef  NS_ENUM(NSInteger,requestType){
    GET,
    POST,
    DELETE,
    PUT,
};
typedef void(^succedBlock) (id data);
typedef void(^failedBlock) (NSError *error);
@interface NetWorkRequest: NSObject
/**
 *  网络请求
 *
 *  @param type        请求方式
 *  @param urlString   传进来的URL
 *  @param paramDict   请求参数
 *  @param succedBlock 请求成功执行block
 *  @param failedBlock 请求失败返回block
 */
+(void)requesType:(requestType)type UrlString:(NSString *)urlString Param:(NSDictionary *)paramDict succedBlock:(succedBlock )succedBlock failedBlock:(failedBlock)failedBlock;
singleton_interface(NetWorkRequest);
@end

//
//  NetWorkRequest.m
//  DuBi
//
//  Created by lanou3g on 16/5/19.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "NetWorkRequest.h"

@implementation NetWorkRequest
+(void)requesType:(requestType)type UrlString:(NSString *)urlString Param:(NSDictionary *)paramDict succedBlock:(succedBlock )succedBlock failedBlock:(failedBlock)failedBlock{
    switch (type) {
        case GET:{
            // 在这里面创建对象,要用到大括号
            NetWorkRequest *manage = [NetWorkRequest sharedNetWorkRequest];
            [manage  getWithUrlString:urlString param:paramDict succeed:succedBlock failure:failedBlock];
            break;
        }
        case POST:
            
            break;
        case DELETE:
            
            break;
        case PUT:
            
            break;
        default:
            break;
    }
    
    
    
    
    
    
    
}
-(void)getWithUrlString:(NSString *)urlString param:(NSDictionary *)dic succeed:(succedBlock)succeed failure:(failedBlock)failure{
    // 1.使用NSURLSession
    NSURLSession *sessin = [NSURLSession sharedSession];
    // 2.拼接字符串
    NSMutableString *urlStr = [NSMutableString stringWithString:urlString];
    if (dic) {
        [urlStr appendString:@"?"];
        [dic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            [urlStr appendString:[NSString stringWithFormat:@"%@ = %@&",key,obj]];
        }];
        [urlStr substringToIndex:urlStr.length - 2];
    }
    // 3.转码
    // 3.1.先放到集合里面
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:urlStr];
    // 3.2.在调用集合
    NSString *url = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:set];
    // 4. 设置request对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    // 设置请求方式
    [request setHTTPMethod:@"GET"];
    // 链接并发送请求
    NSURLSessionDataTask *dataTask = [sessin dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (data && !error) {
            succeed(data);
        }else{
            if (!data) {
                NSLog(@"请求的数据为空");
            }
            if (error) {
                failure(error);
            }
        }
        
        
    }];
    [dataTask resume];
}
singleton_implementation(NetWorkRequest);
@end

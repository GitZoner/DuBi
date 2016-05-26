//
//  ZDInfo.h
//
//  Created by lanou3g  on 16/5/25
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZDInfo : NSObject <NSCoding, NSCopying>

// 最大的帖子id
@property (nonatomic, strong) NSString *maxid;

//
@property (nonatomic, assign) double count;

// 每次加载下一页的时候，需要传入上一页返回参数中对应的此内容，列如1434112682
@property (nonatomic, strong) NSString *maxtime;

// 一页二十个帖子的情况下的最大页数
@property (nonatomic, assign) double page;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

//
//  ZDBaseClass.h
//
//  Created by lanou3g  on 16/5/25
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZDInfo;

@interface ZDBaseClass : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) ZDInfo *info;
@property (nonatomic, strong) NSArray *list;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

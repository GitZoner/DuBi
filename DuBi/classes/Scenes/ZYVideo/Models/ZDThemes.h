//
//  ZDThemes.h
//
//  Created by lanou3g  on 16/5/25
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZDThemes : NSObject <NSCoding, NSCopying>
// 标签的id，如 微视频的id为55
@property (nonatomic, strong) NSString *themeId;

// 一般为1
@property (nonatomic, strong) NSString *themeType;

// 帖子的所属分类的标签名字
@property (nonatomic, strong) NSString *themeName;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

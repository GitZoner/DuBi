//
//  ZDList.h
//
//  Created by lanou3g  on 16/5/25
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZDList : NSObject <NSCoding, NSCopying>

// 系统审核通过后创建帖子的时间
@property (nonatomic, strong) NSString *createdAt;
//
@property (nonatomic, assign) double listIdentifier;
// 是否是动态图
@property (nonatomic, strong) NSString *isGif;

// 如果含有视频此参数是视频的长度
@property (nonatomic, strong) NSString *voicetime;
@property (nonatomic, strong) NSString *image2;
@property (nonatomic, strong) NSString *forward;
@property (nonatomic, strong) NSString *voicelength;
@property (nonatomic, strong) NSString *playfcount;
@property (nonatomic, strong) NSString *repost;
@property (nonatomic, strong) NSString *image1;
@property (nonatomic, strong) NSArray *topCmt;
@property (nonatomic, strong) NSString *text;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, assign) double themeType;
@property (nonatomic, strong) NSString *hate;
@property (nonatomic, strong) NSString *image0;
@property (nonatomic, strong) NSString *comment;
@property (nonatomic, strong) NSString *passtime;
@property (nonatomic, assign) double type;
@property (nonatomic, strong) NSString *playcount;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, strong) NSString *cdnImg;
@property (nonatomic, strong) NSString *themeName;
@property (nonatomic, strong) NSString *createTime;
@property (nonatomic, strong) NSString *favourite;
@property (nonatomic, strong) NSString *from;
@property (nonatomic, strong) NSArray *themes;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *height;
@property (nonatomic, strong) NSString *status;
@property (nonatomic, strong) NSString *jieV;
@property (nonatomic, strong) NSString *videotime;
@property (nonatomic, strong) NSString *bookmark;
@property (nonatomic, strong) NSString *cai;
@property (nonatomic, strong) NSString *screenName;
@property (nonatomic, strong) NSString *profileImage;
@property (nonatomic, strong) NSString *love;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *mid;
@property (nonatomic, assign) double themeId;
@property (nonatomic, strong) NSString *originalPid;
@property (nonatomic, strong) NSString *sinaV;
@property (nonatomic, strong) NSString *imageSmall;
@property (nonatomic, strong) NSString *weixinUrl;
@property (nonatomic, strong) NSString *voiceuri;
@property (nonatomic, strong) NSString *videouri;
@property (nonatomic, strong) NSString *width;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

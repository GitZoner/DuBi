//
//  ZDList.m
//
//  Created by lanou3g  on 16/5/25
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ZDList.h"
#import "ZDThemes.h"


NSString *const kZDListCreatedAt = @"created_at";
NSString *const kZDListId = @"id";
NSString *const kZDListIsGif = @"is_gif";
NSString *const kZDListVoicetime = @"voicetime";
NSString *const kZDListImage2 = @"image2";
NSString *const kZDListForward = @"forward";
NSString *const kZDListVoicelength = @"voicelength";
NSString *const kZDListPlayfcount = @"playfcount";
NSString *const kZDListRepost = @"repost";
NSString *const kZDListImage1 = @"image1";
NSString *const kZDListTopCmt = @"top_cmt";
NSString *const kZDListText = @"text";
NSString *const kZDListUrl = @"url";
NSString *const kZDListThemeType = @"theme_type";
NSString *const kZDListHate = @"hate";
NSString *const kZDListImage0 = @"image0";
NSString *const kZDListComment = @"comment";
NSString *const kZDListPasstime = @"passtime";
NSString *const kZDListType = @"type";
NSString *const kZDListPlaycount = @"playcount";
NSString *const kZDListTag = @"tag";
NSString *const kZDListCdnImg = @"cdn_img";
NSString *const kZDListThemeName = @"theme_name";
NSString *const kZDListCreateTime = @"create_time";
NSString *const kZDListFavourite = @"favourite";
NSString *const kZDListFrom = @"from";
NSString *const kZDListThemes = @"themes";
NSString *const kZDListName = @"name";
NSString *const kZDListHeight = @"height";
NSString *const kZDListStatus = @"status";
NSString *const kZDListJieV = @"jie_v";
NSString *const kZDListVideotime = @"videotime";
NSString *const kZDListBookmark = @"bookmark";
NSString *const kZDListCai = @"cai";
NSString *const kZDListScreenName = @"screen_name";
NSString *const kZDListProfileImage = @"profile_image";
NSString *const kZDListLove = @"love";
NSString *const kZDListUserId = @"user_id";
NSString *const kZDListMid = @"mid";
NSString *const kZDListThemeId = @"theme_id";
NSString *const kZDListOriginalPid = @"original_pid";
NSString *const kZDListSinaV = @"sina_v";
NSString *const kZDListImageSmall = @"image_small";
NSString *const kZDListWeixinUrl = @"weixin_url";
NSString *const kZDListVoiceuri = @"voiceuri";
NSString *const kZDListVideouri = @"videouri";
NSString *const kZDListWidth = @"width";


@interface ZDList ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZDList

@synthesize createdAt = _createdAt;
@synthesize listIdentifier = _listIdentifier;
@synthesize isGif = _isGif;
@synthesize voicetime = _voicetime;
@synthesize image2 = _image2;
@synthesize forward = _forward;
@synthesize voicelength = _voicelength;
@synthesize playfcount = _playfcount;
@synthesize repost = _repost;
@synthesize image1 = _image1;
@synthesize topCmt = _topCmt;
@synthesize text = _text;
@synthesize url = _url;
@synthesize themeType = _themeType;
@synthesize hate = _hate;
@synthesize image0 = _image0;
@synthesize comment = _comment;
@synthesize passtime = _passtime;
@synthesize type = _type;
@synthesize playcount = _playcount;
@synthesize tag = _tag;
@synthesize cdnImg = _cdnImg;
@synthesize themeName = _themeName;
@synthesize createTime = _createTime;
@synthesize favourite = _favourite;
@synthesize from = _from;
@synthesize themes = _themes;
@synthesize name = _name;
@synthesize height = _height;
@synthesize status = _status;
@synthesize jieV = _jieV;
@synthesize videotime = _videotime;
@synthesize bookmark = _bookmark;
@synthesize cai = _cai;
@synthesize screenName = _screenName;
@synthesize profileImage = _profileImage;
@synthesize love = _love;
@synthesize userId = _userId;
@synthesize mid = _mid;
@synthesize themeId = _themeId;
@synthesize originalPid = _originalPid;
@synthesize sinaV = _sinaV;
@synthesize imageSmall = _imageSmall;
@synthesize weixinUrl = _weixinUrl;
@synthesize voiceuri = _voiceuri;
@synthesize videouri = _videouri;
@synthesize width = _width;


+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict
{
    return [[self alloc] initWithDictionary:dict];
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.createdAt = [self objectOrNilForKey:kZDListCreatedAt fromDictionary:dict];
            self.listIdentifier = [[self objectOrNilForKey:kZDListId fromDictionary:dict] doubleValue];
            self.isGif = [self objectOrNilForKey:kZDListIsGif fromDictionary:dict];
            self.voicetime = [self objectOrNilForKey:kZDListVoicetime fromDictionary:dict];
            self.image2 = [self objectOrNilForKey:kZDListImage2 fromDictionary:dict];
            self.forward = [self objectOrNilForKey:kZDListForward fromDictionary:dict];
            self.voicelength = [self objectOrNilForKey:kZDListVoicelength fromDictionary:dict];
            self.playfcount = [self objectOrNilForKey:kZDListPlayfcount fromDictionary:dict];
            self.repost = [self objectOrNilForKey:kZDListRepost fromDictionary:dict];
            self.image1 = [self objectOrNilForKey:kZDListImage1 fromDictionary:dict];
            self.topCmt = [self objectOrNilForKey:kZDListTopCmt fromDictionary:dict];
            self.text = [self objectOrNilForKey:kZDListText fromDictionary:dict];
            self.url = [self objectOrNilForKey:kZDListUrl fromDictionary:dict];
            self.themeType = [[self objectOrNilForKey:kZDListThemeType fromDictionary:dict] doubleValue];
            self.hate = [self objectOrNilForKey:kZDListHate fromDictionary:dict];
            self.image0 = [self objectOrNilForKey:kZDListImage0 fromDictionary:dict];
            self.comment = [self objectOrNilForKey:kZDListComment fromDictionary:dict];
            self.passtime = [self objectOrNilForKey:kZDListPasstime fromDictionary:dict];
            self.type = [[self objectOrNilForKey:kZDListType fromDictionary:dict] doubleValue];
            self.playcount = [self objectOrNilForKey:kZDListPlaycount fromDictionary:dict];
            self.tag = [self objectOrNilForKey:kZDListTag fromDictionary:dict];
            self.cdnImg = [self objectOrNilForKey:kZDListCdnImg fromDictionary:dict];
            self.themeName = [self objectOrNilForKey:kZDListThemeName fromDictionary:dict];
            self.createTime = [self objectOrNilForKey:kZDListCreateTime fromDictionary:dict];
            self.favourite = [self objectOrNilForKey:kZDListFavourite fromDictionary:dict];
            self.from = [self objectOrNilForKey:kZDListFrom fromDictionary:dict];
    NSObject *receivedZDThemes = [dict objectForKey:kZDListThemes];
    NSMutableArray *parsedZDThemes = [NSMutableArray array];
    if ([receivedZDThemes isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedZDThemes) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedZDThemes addObject:[ZDThemes modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedZDThemes isKindOfClass:[NSDictionary class]]) {
       [parsedZDThemes addObject:[ZDThemes modelObjectWithDictionary:(NSDictionary *)receivedZDThemes]];
    }

    self.themes = [NSArray arrayWithArray:parsedZDThemes];
            self.name = [self objectOrNilForKey:kZDListName fromDictionary:dict];
            self.height = [self objectOrNilForKey:kZDListHeight fromDictionary:dict];
            self.status = [self objectOrNilForKey:kZDListStatus fromDictionary:dict];
            self.jieV = [self objectOrNilForKey:kZDListJieV fromDictionary:dict];
            self.videotime = [self objectOrNilForKey:kZDListVideotime fromDictionary:dict];
            self.bookmark = [self objectOrNilForKey:kZDListBookmark fromDictionary:dict];
            self.cai = [self objectOrNilForKey:kZDListCai fromDictionary:dict];
            self.screenName = [self objectOrNilForKey:kZDListScreenName fromDictionary:dict];
            self.profileImage = [self objectOrNilForKey:kZDListProfileImage fromDictionary:dict];
            self.love = [self objectOrNilForKey:kZDListLove fromDictionary:dict];
            self.userId = [self objectOrNilForKey:kZDListUserId fromDictionary:dict];
            self.mid = [self objectOrNilForKey:kZDListMid fromDictionary:dict];
            self.themeId = [[self objectOrNilForKey:kZDListThemeId fromDictionary:dict] doubleValue];
            self.originalPid = [self objectOrNilForKey:kZDListOriginalPid fromDictionary:dict];
            self.sinaV = [self objectOrNilForKey:kZDListSinaV fromDictionary:dict];
            self.imageSmall = [self objectOrNilForKey:kZDListImageSmall fromDictionary:dict];
            self.weixinUrl = [self objectOrNilForKey:kZDListWeixinUrl fromDictionary:dict];
            self.voiceuri = [self objectOrNilForKey:kZDListVoiceuri fromDictionary:dict];
            self.videouri = [self objectOrNilForKey:kZDListVideouri fromDictionary:dict];
            self.width = [self objectOrNilForKey:kZDListWidth fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.createdAt forKey:kZDListCreatedAt];
    [mutableDict setValue:[NSNumber numberWithDouble:self.listIdentifier] forKey:kZDListId];
    [mutableDict setValue:self.isGif forKey:kZDListIsGif];
    [mutableDict setValue:self.voicetime forKey:kZDListVoicetime];
    [mutableDict setValue:self.image2 forKey:kZDListImage2];
    [mutableDict setValue:self.forward forKey:kZDListForward];
    [mutableDict setValue:self.voicelength forKey:kZDListVoicelength];
    [mutableDict setValue:self.playfcount forKey:kZDListPlayfcount];
    [mutableDict setValue:self.repost forKey:kZDListRepost];
    [mutableDict setValue:self.image1 forKey:kZDListImage1];
    NSMutableArray *tempArrayForTopCmt = [NSMutableArray array];
    for (NSObject *subArrayObject in self.topCmt) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForTopCmt addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForTopCmt addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForTopCmt] forKey:kZDListTopCmt];
    [mutableDict setValue:self.text forKey:kZDListText];
    [mutableDict setValue:self.url forKey:kZDListUrl];
    [mutableDict setValue:[NSNumber numberWithDouble:self.themeType] forKey:kZDListThemeType];
    [mutableDict setValue:self.hate forKey:kZDListHate];
    [mutableDict setValue:self.image0 forKey:kZDListImage0];
    [mutableDict setValue:self.comment forKey:kZDListComment];
    [mutableDict setValue:self.passtime forKey:kZDListPasstime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.type] forKey:kZDListType];
    [mutableDict setValue:self.playcount forKey:kZDListPlaycount];
    [mutableDict setValue:self.tag forKey:kZDListTag];
    [mutableDict setValue:self.cdnImg forKey:kZDListCdnImg];
    [mutableDict setValue:self.themeName forKey:kZDListThemeName];
    [mutableDict setValue:self.createTime forKey:kZDListCreateTime];
    [mutableDict setValue:self.favourite forKey:kZDListFavourite];
    [mutableDict setValue:self.from forKey:kZDListFrom];
    NSMutableArray *tempArrayForThemes = [NSMutableArray array];
    for (NSObject *subArrayObject in self.themes) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForThemes addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForThemes addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForThemes] forKey:kZDListThemes];
    [mutableDict setValue:self.name forKey:kZDListName];
    [mutableDict setValue:self.height forKey:kZDListHeight];
    [mutableDict setValue:self.status forKey:kZDListStatus];
    [mutableDict setValue:self.jieV forKey:kZDListJieV];
    [mutableDict setValue:self.videotime forKey:kZDListVideotime];
    [mutableDict setValue:self.bookmark forKey:kZDListBookmark];
    [mutableDict setValue:self.cai forKey:kZDListCai];
    [mutableDict setValue:self.screenName forKey:kZDListScreenName];
    [mutableDict setValue:self.profileImage forKey:kZDListProfileImage];
    [mutableDict setValue:self.love forKey:kZDListLove];
    [mutableDict setValue:self.userId forKey:kZDListUserId];
    [mutableDict setValue:self.mid forKey:kZDListMid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.themeId] forKey:kZDListThemeId];
    [mutableDict setValue:self.originalPid forKey:kZDListOriginalPid];
    [mutableDict setValue:self.sinaV forKey:kZDListSinaV];
    [mutableDict setValue:self.imageSmall forKey:kZDListImageSmall];
    [mutableDict setValue:self.weixinUrl forKey:kZDListWeixinUrl];
    [mutableDict setValue:self.voiceuri forKey:kZDListVoiceuri];
    [mutableDict setValue:self.videouri forKey:kZDListVideouri];
    [mutableDict setValue:self.width forKey:kZDListWidth];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.createdAt = [aDecoder decodeObjectForKey:kZDListCreatedAt];
    self.listIdentifier = [aDecoder decodeDoubleForKey:kZDListId];
    self.isGif = [aDecoder decodeObjectForKey:kZDListIsGif];
    self.voicetime = [aDecoder decodeObjectForKey:kZDListVoicetime];
    self.image2 = [aDecoder decodeObjectForKey:kZDListImage2];
    self.forward = [aDecoder decodeObjectForKey:kZDListForward];
    self.voicelength = [aDecoder decodeObjectForKey:kZDListVoicelength];
    self.playfcount = [aDecoder decodeObjectForKey:kZDListPlayfcount];
    self.repost = [aDecoder decodeObjectForKey:kZDListRepost];
    self.image1 = [aDecoder decodeObjectForKey:kZDListImage1];
    self.topCmt = [aDecoder decodeObjectForKey:kZDListTopCmt];
    self.text = [aDecoder decodeObjectForKey:kZDListText];
    self.url = [aDecoder decodeObjectForKey:kZDListUrl];
    self.themeType = [aDecoder decodeDoubleForKey:kZDListThemeType];
    self.hate = [aDecoder decodeObjectForKey:kZDListHate];
    self.image0 = [aDecoder decodeObjectForKey:kZDListImage0];
    self.comment = [aDecoder decodeObjectForKey:kZDListComment];
    self.passtime = [aDecoder decodeObjectForKey:kZDListPasstime];
    self.type = [aDecoder decodeDoubleForKey:kZDListType];
    self.playcount = [aDecoder decodeObjectForKey:kZDListPlaycount];
    self.tag = [aDecoder decodeObjectForKey:kZDListTag];
    self.cdnImg = [aDecoder decodeObjectForKey:kZDListCdnImg];
    self.themeName = [aDecoder decodeObjectForKey:kZDListThemeName];
    self.createTime = [aDecoder decodeObjectForKey:kZDListCreateTime];
    self.favourite = [aDecoder decodeObjectForKey:kZDListFavourite];
    self.from = [aDecoder decodeObjectForKey:kZDListFrom];
    self.themes = [aDecoder decodeObjectForKey:kZDListThemes];
    self.name = [aDecoder decodeObjectForKey:kZDListName];
    self.height = [aDecoder decodeObjectForKey:kZDListHeight];
    self.status = [aDecoder decodeObjectForKey:kZDListStatus];
    self.jieV = [aDecoder decodeObjectForKey:kZDListJieV];
    self.videotime = [aDecoder decodeObjectForKey:kZDListVideotime];
    self.bookmark = [aDecoder decodeObjectForKey:kZDListBookmark];
    self.cai = [aDecoder decodeObjectForKey:kZDListCai];
    self.screenName = [aDecoder decodeObjectForKey:kZDListScreenName];
    self.profileImage = [aDecoder decodeObjectForKey:kZDListProfileImage];
    self.love = [aDecoder decodeObjectForKey:kZDListLove];
    self.userId = [aDecoder decodeObjectForKey:kZDListUserId];
    self.mid = [aDecoder decodeObjectForKey:kZDListMid];
    self.themeId = [aDecoder decodeDoubleForKey:kZDListThemeId];
    self.originalPid = [aDecoder decodeObjectForKey:kZDListOriginalPid];
    self.sinaV = [aDecoder decodeObjectForKey:kZDListSinaV];
    self.imageSmall = [aDecoder decodeObjectForKey:kZDListImageSmall];
    self.weixinUrl = [aDecoder decodeObjectForKey:kZDListWeixinUrl];
    self.voiceuri = [aDecoder decodeObjectForKey:kZDListVoiceuri];
    self.videouri = [aDecoder decodeObjectForKey:kZDListVideouri];
    self.width = [aDecoder decodeObjectForKey:kZDListWidth];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_createdAt forKey:kZDListCreatedAt];
    [aCoder encodeDouble:_listIdentifier forKey:kZDListId];
    [aCoder encodeObject:_isGif forKey:kZDListIsGif];
    [aCoder encodeObject:_voicetime forKey:kZDListVoicetime];
    [aCoder encodeObject:_image2 forKey:kZDListImage2];
    [aCoder encodeObject:_forward forKey:kZDListForward];
    [aCoder encodeObject:_voicelength forKey:kZDListVoicelength];
    [aCoder encodeObject:_playfcount forKey:kZDListPlayfcount];
    [aCoder encodeObject:_repost forKey:kZDListRepost];
    [aCoder encodeObject:_image1 forKey:kZDListImage1];
    [aCoder encodeObject:_topCmt forKey:kZDListTopCmt];
    [aCoder encodeObject:_text forKey:kZDListText];
    [aCoder encodeObject:_url forKey:kZDListUrl];
    [aCoder encodeDouble:_themeType forKey:kZDListThemeType];
    [aCoder encodeObject:_hate forKey:kZDListHate];
    [aCoder encodeObject:_image0 forKey:kZDListImage0];
    [aCoder encodeObject:_comment forKey:kZDListComment];
    [aCoder encodeObject:_passtime forKey:kZDListPasstime];
    [aCoder encodeDouble:_type forKey:kZDListType];
    [aCoder encodeObject:_playcount forKey:kZDListPlaycount];
    [aCoder encodeObject:_tag forKey:kZDListTag];
    [aCoder encodeObject:_cdnImg forKey:kZDListCdnImg];
    [aCoder encodeObject:_themeName forKey:kZDListThemeName];
    [aCoder encodeObject:_createTime forKey:kZDListCreateTime];
    [aCoder encodeObject:_favourite forKey:kZDListFavourite];
    [aCoder encodeObject:_from forKey:kZDListFrom];
    [aCoder encodeObject:_themes forKey:kZDListThemes];
    [aCoder encodeObject:_name forKey:kZDListName];
    [aCoder encodeObject:_height forKey:kZDListHeight];
    [aCoder encodeObject:_status forKey:kZDListStatus];
    [aCoder encodeObject:_jieV forKey:kZDListJieV];
    [aCoder encodeObject:_videotime forKey:kZDListVideotime];
    [aCoder encodeObject:_bookmark forKey:kZDListBookmark];
    [aCoder encodeObject:_cai forKey:kZDListCai];
    [aCoder encodeObject:_screenName forKey:kZDListScreenName];
    [aCoder encodeObject:_profileImage forKey:kZDListProfileImage];
    [aCoder encodeObject:_love forKey:kZDListLove];
    [aCoder encodeObject:_userId forKey:kZDListUserId];
    [aCoder encodeObject:_mid forKey:kZDListMid];
    [aCoder encodeDouble:_themeId forKey:kZDListThemeId];
    [aCoder encodeObject:_originalPid forKey:kZDListOriginalPid];
    [aCoder encodeObject:_sinaV forKey:kZDListSinaV];
    [aCoder encodeObject:_imageSmall forKey:kZDListImageSmall];
    [aCoder encodeObject:_weixinUrl forKey:kZDListWeixinUrl];
    [aCoder encodeObject:_voiceuri forKey:kZDListVoiceuri];
    [aCoder encodeObject:_videouri forKey:kZDListVideouri];
    [aCoder encodeObject:_width forKey:kZDListWidth];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZDList *copy = [[ZDList alloc] init];
    
    if (copy) {

        copy.createdAt = [self.createdAt copyWithZone:zone];
        copy.listIdentifier = self.listIdentifier;
        copy.isGif = [self.isGif copyWithZone:zone];
        copy.voicetime = [self.voicetime copyWithZone:zone];
        copy.image2 = [self.image2 copyWithZone:zone];
        copy.forward = [self.forward copyWithZone:zone];
        copy.voicelength = [self.voicelength copyWithZone:zone];
        copy.playfcount = [self.playfcount copyWithZone:zone];
        copy.repost = [self.repost copyWithZone:zone];
        copy.image1 = [self.image1 copyWithZone:zone];
        copy.topCmt = [self.topCmt copyWithZone:zone];
        copy.text = [self.text copyWithZone:zone];
        copy.url = [self.url copyWithZone:zone];
        copy.themeType = self.themeType;
        copy.hate = [self.hate copyWithZone:zone];
        copy.image0 = [self.image0 copyWithZone:zone];
        copy.comment = [self.comment copyWithZone:zone];
        copy.passtime = [self.passtime copyWithZone:zone];
        copy.type = self.type;
        copy.playcount = [self.playcount copyWithZone:zone];
        copy.tag = [self.tag copyWithZone:zone];
        copy.cdnImg = [self.cdnImg copyWithZone:zone];
        copy.themeName = [self.themeName copyWithZone:zone];
        copy.createTime = [self.createTime copyWithZone:zone];
        copy.favourite = [self.favourite copyWithZone:zone];
        copy.from = [self.from copyWithZone:zone];
        copy.themes = [self.themes copyWithZone:zone];
        copy.name = [self.name copyWithZone:zone];
        copy.height = [self.height copyWithZone:zone];
        copy.status = [self.status copyWithZone:zone];
        copy.jieV = [self.jieV copyWithZone:zone];
        copy.videotime = [self.videotime copyWithZone:zone];
        copy.bookmark = [self.bookmark copyWithZone:zone];
        copy.cai = [self.cai copyWithZone:zone];
        copy.screenName = [self.screenName copyWithZone:zone];
        copy.profileImage = [self.profileImage copyWithZone:zone];
        copy.love = [self.love copyWithZone:zone];
        copy.userId = [self.userId copyWithZone:zone];
        copy.mid = [self.mid copyWithZone:zone];
        copy.themeId = self.themeId;
        copy.originalPid = [self.originalPid copyWithZone:zone];
        copy.sinaV = [self.sinaV copyWithZone:zone];
        copy.imageSmall = [self.imageSmall copyWithZone:zone];
        copy.weixinUrl = [self.weixinUrl copyWithZone:zone];
        copy.voiceuri = [self.voiceuri copyWithZone:zone];
        copy.videouri = [self.videouri copyWithZone:zone];
        copy.width = [self.width copyWithZone:zone];
    }
    
    return copy;
}


@end

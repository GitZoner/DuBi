//
//  ZDThemes.m
//
//  Created by lanou3g  on 16/5/25
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ZDThemes.h"


NSString *const kZDThemesThemeId = @"theme_id";
NSString *const kZDThemesThemeType = @"theme_type";
NSString *const kZDThemesThemeName = @"theme_name";


@interface ZDThemes ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZDThemes

@synthesize themeId = _themeId;
@synthesize themeType = _themeType;
@synthesize themeName = _themeName;


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
            self.themeId = [self objectOrNilForKey:kZDThemesThemeId fromDictionary:dict];
            self.themeType = [self objectOrNilForKey:kZDThemesThemeType fromDictionary:dict];
            self.themeName = [self objectOrNilForKey:kZDThemesThemeName fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.themeId forKey:kZDThemesThemeId];
    [mutableDict setValue:self.themeType forKey:kZDThemesThemeType];
    [mutableDict setValue:self.themeName forKey:kZDThemesThemeName];

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

    self.themeId = [aDecoder decodeObjectForKey:kZDThemesThemeId];
    self.themeType = [aDecoder decodeObjectForKey:kZDThemesThemeType];
    self.themeName = [aDecoder decodeObjectForKey:kZDThemesThemeName];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_themeId forKey:kZDThemesThemeId];
    [aCoder encodeObject:_themeType forKey:kZDThemesThemeType];
    [aCoder encodeObject:_themeName forKey:kZDThemesThemeName];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZDThemes *copy = [[ZDThemes alloc] init];
    
    if (copy) {

        copy.themeId = [self.themeId copyWithZone:zone];
        copy.themeType = [self.themeType copyWithZone:zone];
        copy.themeName = [self.themeName copyWithZone:zone];
    }
    
    return copy;
}


@end

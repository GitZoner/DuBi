//
//  ZDInfo.m
//
//  Created by lanou3g  on 16/5/25
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ZDInfo.h"


NSString *const kZDInfoMaxid = @"maxid";
NSString *const kZDInfoCount = @"count";
NSString *const kZDInfoMaxtime = @"maxtime";
NSString *const kZDInfoPage = @"page";


@interface ZDInfo ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZDInfo

@synthesize maxid = _maxid;
@synthesize count = _count;
@synthesize maxtime = _maxtime;
@synthesize page = _page;


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
            self.maxid = [self objectOrNilForKey:kZDInfoMaxid fromDictionary:dict];
            self.count = [[self objectOrNilForKey:kZDInfoCount fromDictionary:dict] doubleValue];
            self.maxtime = [self objectOrNilForKey:kZDInfoMaxtime fromDictionary:dict];
            self.page = [[self objectOrNilForKey:kZDInfoPage fromDictionary:dict] doubleValue];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.maxid forKey:kZDInfoMaxid];
    [mutableDict setValue:[NSNumber numberWithDouble:self.count] forKey:kZDInfoCount];
    [mutableDict setValue:self.maxtime forKey:kZDInfoMaxtime];
    [mutableDict setValue:[NSNumber numberWithDouble:self.page] forKey:kZDInfoPage];

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

    self.maxid = [aDecoder decodeObjectForKey:kZDInfoMaxid];
    self.count = [aDecoder decodeDoubleForKey:kZDInfoCount];
    self.maxtime = [aDecoder decodeObjectForKey:kZDInfoMaxtime];
    self.page = [aDecoder decodeDoubleForKey:kZDInfoPage];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_maxid forKey:kZDInfoMaxid];
    [aCoder encodeDouble:_count forKey:kZDInfoCount];
    [aCoder encodeObject:_maxtime forKey:kZDInfoMaxtime];
    [aCoder encodeDouble:_page forKey:kZDInfoPage];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZDInfo *copy = [[ZDInfo alloc] init];
    
    if (copy) {

        copy.maxid = [self.maxid copyWithZone:zone];
        copy.count = self.count;
        copy.maxtime = [self.maxtime copyWithZone:zone];
        copy.page = self.page;
    }
    
    return copy;
}


@end

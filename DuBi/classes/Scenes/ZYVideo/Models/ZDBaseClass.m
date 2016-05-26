//
//  ZDBaseClass.m
//
//  Created by lanou3g  on 16/5/25
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "ZDBaseClass.h"
#import "ZDInfo.h"
#import "ZDList.h"


NSString *const kZDBaseClassInfo = @"info";
NSString *const kZDBaseClassList = @"list";


@interface ZDBaseClass ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation ZDBaseClass

@synthesize info = _info;
@synthesize list = _list;


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
            self.info = [ZDInfo modelObjectWithDictionary:[dict objectForKey:kZDBaseClassInfo]];
    NSObject *receivedZDList = [dict objectForKey:kZDBaseClassList];
    NSMutableArray *parsedZDList = [NSMutableArray array];
    if ([receivedZDList isKindOfClass:[NSArray class]]) {
        for (NSDictionary *item in (NSArray *)receivedZDList) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [parsedZDList addObject:[ZDList modelObjectWithDictionary:item]];
            }
       }
    } else if ([receivedZDList isKindOfClass:[NSDictionary class]]) {
       [parsedZDList addObject:[ZDList modelObjectWithDictionary:(NSDictionary *)receivedZDList]];
    }

    self.list = [NSArray arrayWithArray:parsedZDList];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:[self.info dictionaryRepresentation] forKey:kZDBaseClassInfo];
    NSMutableArray *tempArrayForList = [NSMutableArray array];
    for (NSObject *subArrayObject in self.list) {
        if([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
            // This class is a model object
            [tempArrayForList addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
        } else {
            // Generic object
            [tempArrayForList addObject:subArrayObject];
        }
    }
    [mutableDict setValue:[NSArray arrayWithArray:tempArrayForList] forKey:kZDBaseClassList];

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

    self.info = [aDecoder decodeObjectForKey:kZDBaseClassInfo];
    self.list = [aDecoder decodeObjectForKey:kZDBaseClassList];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_info forKey:kZDBaseClassInfo];
    [aCoder encodeObject:_list forKey:kZDBaseClassList];
}

- (id)copyWithZone:(NSZone *)zone
{
    ZDBaseClass *copy = [[ZDBaseClass alloc] init];
    
    if (copy) {

        copy.info = [self.info copyWithZone:zone];
        copy.list = [self.list copyWithZone:zone];
    }
    
    return copy;
}


@end

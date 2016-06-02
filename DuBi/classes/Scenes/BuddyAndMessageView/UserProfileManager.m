/************************************************************
 *  * Hyphenate CONFIDENTIAL
 * __________________
 * Copyright (C) 2016 Hyphenate Inc. All rights reserved.
 *
 * NOTICE: All information contained herein is, and remains
 * the property of Hyphenate Inc.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Hyphenate Inc.
 */

#import "UserProfileManager.h"


//#import "MessageModel.h"

#define kCURRENT_USERNAME [[EMClient sharedClient] currentUsername]

@implementation UIImage (UIImageExt)

- (UIImage*)imageByScalingAndCroppingForSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    if (CGSizeEqualToSize(imageSize, targetSize) == NO)
    {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor; // scale to fit height
        else
            scaleFactor = heightFactor; // scale to fit width
        scaledWidth= width * scaleFactor;
        scaledHeight = height * scaleFactor;
        // center the image
        if (widthFactor > heightFactor)
        {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }
        else if (widthFactor < heightFactor)
        {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(targetSize); // this will crop
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width= scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil)
        NSLog(@"could not scale image");
    //pop the context to get back to the default
    UIGraphicsEndImageContext();
    return newImage;
}

@end

static UserProfileManager *sharedInstance = nil;
@interface UserProfileManager ()
{
    NSString *_curusername;
}

@property (nonatomic, strong) NSMutableDictionary *users;
@property (nonatomic, strong) NSString *objectId;


@end

@implementation UserProfileManager

+ (instancetype)sharedInstance{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _users = [NSMutableDictionary dictionary];
        
     
    }
    return self;
}

- (void)initParse
{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    id objectId = [ud objectForKey:[NSString stringWithFormat:@"%@%@",kPARSE_HXUSER,kCURRENT_USERNAME]];
    if (objectId) {
        self.objectId = objectId;
    }
    _curusername = kCURRENT_USERNAME;
    [self initData];
}

- (void)clearParse
{
    self.objectId = nil;
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    [ud removeObjectForKey:[NSString stringWithFormat:@"%@%@",kPARSE_HXUSER,_curusername]];
     _curusername = nil;
    [self.users removeAllObjects];
}

- (void)initData
{
    [self.users removeAllObjects];
  
}

- (void)uploadUserHeadImageProfileInBackground:(UIImage*)image
                           completion:(void (^)(BOOL success, NSError *error))completion
{
    UIImage *img = [image imageByScalingAndCroppingForSize:CGSizeMake(120.f, 120.f)];
    if (_objectId && _objectId.length > 0) {
      
    } else {
        
        [self queryPFObjectWithCompletion:^(PFObject *object, NSError *error) {
            if (object) {
                NSData *imageData = UIImageJPEGRepresentation(img, 0.5);
               
     
             
            } else {
                if (completion) {
                    completion(NO,error);
                }

            }
        }];
    }
}

- (void)updateUserProfileInBackground:(NSDictionary*)param
                           completion:(void (^)(BOOL success, NSError *error))completion
{
    if (_objectId && _objectId.length > 0) {
       
    } else {
        [self queryPFObjectWithCompletion:^(PFObject *object, NSError *error) {
            if (object) {
                if( param!=nil && [[param allKeys] count] > 0) {
                    for (NSString *key in param) {
                        
                    }
                }
                __weak PFObject* weakObj = object;
               
            } else {
                if (completion) {
                    completion(NO,error);
                }
            }
        }];
    }
}

- (void)loadUserProfileInBackgroundWithBuddy:(NSArray*)buddyList
                                saveToLoacal:(BOOL)save
                                  completion:(void (^)(BOOL success, NSError *error))completion
{
    NSMutableArray *usernames = [NSMutableArray array];
    for (NSString *buddy in buddyList)
    {
        if ([buddy length])
        {
            if (![self getUserProfileByUsername:buddy]) {
                [usernames addObject:buddy];
            }
        }
    }
    if ([usernames count] == 0) {
        if (completion) {
            completion(YES,nil);
        }
        return;
    }
    [self loadUserProfileInBackground:usernames saveToLoacal:save completion:completion];
}

- (void)loadUserProfileInBackground:(NSArray*)usernames
                       saveToLoacal:(BOOL)save
                         completion:(void (^)(BOOL success, NSError *error))completion
{
   
   
 
}

- (UserProfileEntity*)getUserProfileByUsername:(NSString*)username
{
    if ([_users objectForKey:username]) {
        return [_users objectForKey:username];
    }
    
    return nil;
}

- (UserProfileEntity*)getCurUserProfile
{
    if ([_users objectForKey:kCURRENT_USERNAME]) {
        return [_users objectForKey:kCURRENT_USERNAME];
    }
    
    return nil;
}

- (NSString*)getNickNameWithUsername:(NSString*)username
{
    UserProfileEntity* entity = [self getUserProfileByUsername:username];
    if (entity.nickname && entity.nickname.length > 0) {
        return entity.nickname;
    } else {
        return username;
    }
}

#pragma mark - private

- (void)savePFUserInDisk:(PFObject*)object
{
    if (object) {
      
        [self savePFUserInMemory:object];
    }
}

- (void)savePFUserInMemory:(PFObject*)object
{
    if (object) {
        UserProfileEntity *entity = [UserProfileEntity initWithPFObject:object];
        [_users setObject:entity forKey:entity.username];
    }
}

- (void)queryPFObjectWithCompletion:(void (^)(PFObject *object, NSError *error))completion
{
  
}

@end

@implementation UserProfileEntity

+ (instancetype) initWithPFObject:(PFObject *)object
{
    UserProfileEntity *entity = [[UserProfileEntity alloc] init];
       return entity;
}

@end

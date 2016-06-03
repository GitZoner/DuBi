//
//  ZYTimeLineCellModel.h
//  ZYProject1
//
//  Created by lanou3g on 16/5/28.
//  Copyright © 2016年 橙子. All rights reserved.
//

#import <Foundation/Foundation.h>


@class ZYTimeLineCellLikeItemModel, ZYTimeLineCellCommentItemModel;
@interface ZYTimeLineCellModel : NSObject


/*用户名*/
@property (strong, nonatomic) NSString *name;

/*发表内容的类型*/
@property (strong, nonatomic) NSString *publishType;

/*发表段子*/
@property (strong, nonatomic) NSString *msgContent;

/*发表图片*/
@property (strong, nonatomic) NSArray *picNamesArray;


//@property (nonatomic, copy) NSString *iconName;
//@property (nonatomic, copy) NSString *name;
//@property (nonatomic, copy) NSString *msgContent;
//@property (nonatomic, strong) NSArray *picNamesArray;

@property (nonatomic, assign, getter = isLiked) BOOL liked;

@property (nonatomic, strong) NSArray<ZYTimeLineCellLikeItemModel *> *likeItemsArray;
@property (nonatomic, strong) NSArray<ZYTimeLineCellCommentItemModel *> *commentItemsArray;

@property (nonatomic, assign) BOOL isOpening;

@property (nonatomic, assign, readonly) BOOL shouldShowMoreButton;
@end
@interface ZYTimeLineCellLikeItemModel : NSObject

@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userId;

@end


@interface ZYTimeLineCellCommentItemModel : NSObject

@property (nonatomic, copy) NSString *commentString;

@property (nonatomic, copy) NSString *firstUserName;
@property (nonatomic, copy) NSString *firstUserId;

@property (nonatomic, copy) NSString *secondUserName;
@property (nonatomic, strong) NSString *secondUserId;

@end
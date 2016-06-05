//
//  ZYTimeLineCell.h
//  ZYProject1
//
//  Created by lanou3g on 16/5/28.
//  Copyright © 2016年 橙子. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVOSCloud/AVOSCloud.h>
@protocol ZYTimeLineCellDelegate <NSObject>

- (void)didClickLikeButtonInCell:(UITableViewCell *)cell;
- (void)didClickcCommentButtonInCell:(UITableViewCell *)cell;

@end

@class ZYTimeLineCellModel;




@interface ZYTimeLineCell : UITableViewCell


@property (nonatomic, weak) id<ZYTimeLineCellDelegate> delegate;

@property (nonatomic, strong) ZYTimeLineCellModel *model;

@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, copy) void (^moreButtonClickedBlock)(NSIndexPath *indexPath);

@property (nonatomic, copy) void (^didClickCommentLabelBlock)(NSString *commentId, CGRect rectInWindow, NSIndexPath *indexPath);

/*avObject对象*/

@property (strong, nonatomic) AVObject *contentAVObject;


@end

//
//  ZYTimeLineCellCommentView.h
//  ZYProject1
//
//  Created by lanou3g on 16/5/28.
//  Copyright © 2016年 橙子. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobalDefines.h"
@interface ZYTimeLineCellCommentView : UIView
- (void)setupWithLikeItemsArray:(NSArray *)likeItemsArray commentItemsArray:(NSArray *)commentItemsArray;

@property (nonatomic, copy) void (^didClickCommentLabelBlock)(NSString *commentId, CGRect rectInWindow);


@end

//
//  ZYTimeLineCellModel.m
//  ZYProject1
//
//  Created by lanou3g on 16/5/28.
//  Copyright © 2016年 橙子. All rights reserved.
//

#import "ZYTimeLineCellModel.h"
#import <UIKit/UIKit.h>



extern const CGFloat contentLabelFontSize;
extern CGFloat maxContentLabelHeight;


@implementation ZYTimeLineCellModel
{
    CGFloat _lastContentWidth;
}

@synthesize msgContent = _msgContent;

- (void)setMsgContent:(NSString *)msgContent
{
    _msgContent = msgContent;
}

- (NSString *)msgContent
{
    CGFloat contentW = [UIScreen mainScreen].bounds.size.width - 70;
    if (contentW != _lastContentWidth) {
    _lastContentWidth = contentW;
    
        CGRect textRect = [_msgContent boundingRectWithSize:CGSizeMake(contentW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:contentLabelFontSize]} context:nil];

    
        if (textRect.size.height > maxContentLabelHeight) {
            _shouldShowMoreButton = YES;
        } else {
            _shouldShowMoreButton = NO;
        }

    }
    return _msgContent;

}

- (void)setIsOpening:(BOOL)isOpening
{
    if (!_shouldShowMoreButton) {
        _isOpening = NO;
    } else {
        _isOpening = isOpening;
    }
}


@end


@implementation ZYTimeLineCellLikeItemModel


@end

@implementation ZYTimeLineCellCommentItemModel



@end

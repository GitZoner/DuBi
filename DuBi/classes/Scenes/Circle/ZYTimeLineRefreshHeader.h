//
//  ZYTimeLineRefreshHeader.h
//  ZYProject1
//
//  Created by lanou3g on 16/5/28.
//  Copyright © 2016年 橙子. All rights reserved.
//

#import "ZYBaseRefresView.h"
#import "ZYBaseRefresView.h"
@interface ZYTimeLineRefreshHeader : ZYBaseRefresView
+ (instancetype)refreshHeaderWithCenter:(CGPoint)center;

@property (nonatomic, copy) void(^refreshingBlock)();


@end

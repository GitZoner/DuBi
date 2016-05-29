//
//  ZYTimeLinerefreshFooter.h
//  ZYProject1
//
//  Created by lanou3g on 16/5/28.
//  Copyright © 2016年 橙子. All rights reserved.
//

#import "ZYBaseRefresView.h"

@interface ZYTimeLinerefreshFooter : ZYBaseRefresView

+ (instancetype)refreshFooterWithRefreshingText:(NSString *)text;

- (void)addToScrollView:(UIScrollView *)scrollView refreshOpration:(void(^)())refrsh;

@property (nonatomic, strong) UILabel *indicatorLabel;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;

@property (nonatomic, copy) void (^refreshBlock)();

@end

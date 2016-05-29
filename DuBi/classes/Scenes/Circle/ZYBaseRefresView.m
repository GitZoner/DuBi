//
//  ZYBaseRefresView.m
//  ZYProject1
//
//  Created by lanou3g on 16/5/28.
//  Copyright © 2016年 橙子. All rights reserved.
//

#import "ZYBaseRefresView.h"

NSString *const kSDBaseRefreshViewObserveKeyPath = @"contentOffset";
@implementation ZYBaseRefresView

- (void)setScrollView:(UIScrollView *)scrollView
{
    _scrollView = scrollView;
    
    [scrollView addObserver:self forKeyPath:kSDBaseRefreshViewObserveKeyPath options:NSKeyValueObservingOptionNew context:nil];
}

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview) {
        [self.scrollView removeObserver:self forKeyPath:kSDBaseRefreshViewObserveKeyPath];
    }
}

- (void)endRefreshing
{
    self.refreshState = SDWXRefreshViewStateNormal;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    // 子类实现
}
@end

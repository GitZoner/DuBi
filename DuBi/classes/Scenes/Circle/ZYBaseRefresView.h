//
//  ZYBaseRefresView.h
//  ZYProject1
//
//  Created by lanou3g on 16/5/28.
//  Copyright © 2016年 橙子. All rights reserved.
//

#import <UIKit/UIKit.h>


UIKIT_EXTERN NSString *const kSDBaseRefreshViewObserveKeyPath;
typedef enum {
    SDWXRefreshViewStateNormal,
    SDWXRefreshViewStateWillRefresh,
    SDWXRefreshViewStateRefreshing,
} SDWXRefreshViewState;



@interface ZYBaseRefresView : UIView
@property (nonatomic, strong) UIScrollView *scrollView;

- (void)endRefreshing;

@property (nonatomic, assign) UIEdgeInsets scrollViewOriginalInsets;
@property (nonatomic, assign) SDWXRefreshViewState refreshState;
@end

//
//  JTCircleMainController.m
//  DuBi
//
//  Created by Jason on 16/5/30.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "JTCircleMainController.h"
#import "JTSegmentControl.h"
#import "Color_marco.h"
#import "Main_marco.h"
#import "ZYTimeLineTableViewController.h"
#import "EaseUI.h"
#import <Masonry.h>
#import "UIView+XYWidthHeight.h"
#import "JTSignInChoiceViewController.h"
#import "JTSignInViewController.h"
#import "ContactListViewController.h"
#import "ConversationListController.h"
#import "JTSearchViewController.h"
#import "JTNotificationViewController.h"
#import "EaseUsersListViewController.h"
#import "JTBuddyManager.h"
@interface JTCircleMainController ()<UIScrollViewDelegate,JTSegmentControlDelegate>

@property (strong,nonatomic)JTSegmentControl *segmentControl;
@property (strong,nonatomic)UIScrollView *scrollView;
// 各自控制器
@property (strong,nonatomic)ZYTimeLineTableViewController *circleViewController; // 圈子动态控制器
@property (strong,nonatomic)ConversationListController *conversationController; // 会话界面控制器
@property (strong,nonatomic)EaseUsersListViewController *userListController; // 好友界面
@property (strong,nonatomic)JTNotificationViewController *noticeMessageController ;// 通知控制器
@property (strong,nonatomic)UIViewController *attentionController; // 关注控制器
@property (strong,nonatomic)UIView *contentView;


@end

@implementation JTCircleMainController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
        [[JTBuddyManager sharedJTBuddyManager] loginWithUsername:kUserDefaultGetValue(kUserInfoKey_telNum) password:kUserDefaultGetValue(kUserInfoKey_passWord) successed:^{
            NSLog(@"自动登录成功");
        } failed:^(NSError *error) {
            NSLog(@"自动登录失败");
        }];
        
    
  
    [self setUpSubViews];
    [self setUpChildControllers];
    [self addChildControllerView];
    
}
// self控制器视图布局
-(void)setUpSubViews{
    self.automaticallyAdjustsScrollViewInsets = NO;
    // 添加segmentControl;
    UIView *navgationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    navgationView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    [self.view addSubview:navgationView];
    
    self.segmentControl = [[JTSegmentControl alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 44) normalColor:[UIColor blackColor] selectColor:tGreenColor titles:[NSArray arrayWithObjects:@"动态",@"会话",@"朋友",@"通知",@"关注", nil] SegmentSize:CGSizeMake(kScreenWidth,44) ItemSize:CGSizeMake(50, 20) titleFont:[UIFont systemFontOfSize:13]];
    self.navigationItem.titleView = self.segmentControl;
    [self.segmentControl.searchButton  addTarget:self action:@selector(pushSearchVCACtion:) forControlEvents:(UIControlEventTouchUpInside)];
   //  [self.view addSubview:self.segmentControl];
    
    // 添加搜索按钮
    
    // 添加scrollView
    self.scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
     self.scrollView.contentSize = CGSizeMake(kScreenWidth * 5, kscreenHeight);
     // self.scrollView.contentOffset = CGPointMake(0, 0);
    self.scrollView.showsHorizontalScrollIndicator = YES;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    // self.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
   //  self.scrollView.contentSize = CGSizeMake(kScreenWidth * 5, kscreenHeight);
    
    [self.view addSubview:self.scrollView ];
    // [self.view insertSubview:self.scrollView belowSubview:self.segmentControl];
  
   
    
}
-(void)pushSearchVCACtion:(UIButton *)button {
    [self.navigationController pushViewController:[JTSearchViewController new] animated:YES];
}


// 添加子控制器
-(void)setUpChildControllers {
    // 动态
    self.circleViewController = [ZYTimeLineTableViewController new] ;
    [self addChildViewController:self.circleViewController];
    // 会话
    self.conversationController = [ConversationListController new] ;
    [self addChildViewController:self.conversationController];
    // 好友
    self.userListController = [EaseUsersListViewController new] ;
    [self addChildViewController:self.userListController];
    // 通知
    self.noticeMessageController = [JTNotificationViewController new] ;
    [self addChildViewController:self.circleViewController];
    // 关注
    self.attentionController = [UIViewController new] ;
    [self addChildViewController:self.circleViewController];

    
    
    
}

#pragma mark - JTSegmentControllerDelegate
-(void)segment:(JTSegmentControl *)segment didSelectColumnIndex:(NSUInteger)index {
    // 当点击button的时候，使scrollView进行偏移
    self.scrollView.contentOffset = CGPointMake(index * self.scrollView.width, 0);
}



 // 向ScrollView中添加子控制器的视图

-(void)addChildControllerView {
    
    // 动态
    self.circleViewController.view.frame = self.view.bounds;
    //self.circleViewController.automaticallyAdjustsScrollViewInsets = NO;
    UIEdgeInsets edgeInset = self.circleViewController.tableView.contentInset;
    edgeInset.top = 44;
    edgeInset.bottom = 49;
    self.circleViewController.tableView.contentInset = edgeInset ;
    [self.scrollView addSubview:self.circleViewController.view];
    
    // 会话
    self.conversationController.view.frame = self.view.bounds;
    self.conversationController.view.x = CGRectGetMaxX(self.circleViewController.view.frame);
    [self.scrollView addSubview:self.conversationController.view];
    
    // 好友列表
    self.userListController.view.frame = self.view.bounds;
    self.userListController.view.x = CGRectGetMaxX(self.conversationController.view.frame);
    [self.scrollView addSubview:self.userListController.view];
    
    // 通知
    self.noticeMessageController.view.frame = self.view.bounds;
    self.noticeMessageController.view.x = CGRectGetMaxX(self.userListController.view.frame);
    [self.scrollView addSubview:self.noticeMessageController.view];
    
    // 关注
    
    
}

#pragma mark - UIScrollViewDelegate

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    NSInteger index = self.scrollView.contentOffset.x / self.scrollView.width;
    
    UIViewController *childVC = self.childViewControllers[index];
    childVC.view.x = self.scrollView.contentOffset.x;
    [self.scrollView addSubview:childVC.view];
}


- (void)searchButttonAction:(UIButton *)button {
    
}
@end

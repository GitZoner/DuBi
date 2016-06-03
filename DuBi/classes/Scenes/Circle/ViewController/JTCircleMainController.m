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
@interface JTCircleMainController ()<UIScrollViewDelegate>

@property (strong,nonatomic)JTSegmentControl *segmentControl;
@property (strong,nonatomic)UIScrollView *scrollView;
// 各自控制器
@property (strong,nonatomic)ZYTimeLineTableViewController *circleViewController; // 圈子动态控制器
@property (strong,nonatomic)ConversationListController *conversationController; // 会话界面控制器
@property (strong,nonatomic)ContactListViewController *userListController; // 好友界面
@property (strong,nonatomic)UIViewController *noticeMessageController ;// 通知控制器
@property (strong,nonatomic)UIViewController *attentionController; // 关注控制器
@property (strong,nonatomic)UIView *contentView;


@end

@implementation JTCircleMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
  
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
    
    self.segmentControl = [[JTSegmentControl alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 44) normalColor:[UIColor blackColor] selectColor:tGreenColor titles:[NSArray arrayWithObjects:@"动态",@"会话",@"消息",@"朋友",@"关注",@"其他1",@"其他2",@"其他3",@"其他4",@"其他5",@"其他6", nil] SegmentSize:CGSizeMake(kScreenWidth,44) ItemSize:CGSizeMake(50, 20) titleFont:[UIFont systemFontOfSize:13]];
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

    self.circleViewController = [ZYTimeLineTableViewController new] ;
    [self addChildViewController:self.circleViewController];

    self.conversationController = [ConversationListController new] ;
    [self addChildViewController:self.conversationController];
    
    self.userListController = [ContactListViewController new] ;
    [self addChildViewController:self.userListController];
    
    self.noticeMessageController = [UIViewController new] ;
    [self addChildViewController:self.circleViewController];
    
    self.attentionController = [UIViewController new] ;
    [self addChildViewController:self.circleViewController];

    
    
    
}


 // 向ScrollView中添加子控制器的视图

-(void)addChildControllerView {
    self.circleViewController.view.frame = self.view.bounds;
    //self.circleViewController.automaticallyAdjustsScrollViewInsets = NO;
    UIEdgeInsets edgeInset = self.circleViewController.tableView.contentInset;
    edgeInset.top = 44;
    edgeInset.bottom = 49;
    self.circleViewController.tableView.contentInset = edgeInset ;
    [self.scrollView addSubview:self.circleViewController.view];
    
    self.conversationController.view.frame = self.view.bounds;
    self.conversationController.view.x = CGRectGetMaxX(self.circleViewController.view.frame);
    [self.scrollView addSubview:self.conversationController.view];
    
    self.userListController.view.frame = self.view.bounds;
    self.userListController.view.x = CGRectGetMaxX(self.conversationController.view.frame);
    [self.scrollView addSubview:self.userListController.view];
    
}

#pragma mark - UIScrollViewDelegate

- (void)searchButttonAction:(UIButton *)button {
    
}
@end

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
@interface JTCircleMainController ()

@property (strong,nonatomic)JTSegmentControl *segmentControl;
@property (strong,nonatomic)UIScrollView *scrollView;
// 各自控制器
@property (strong,nonatomic)JTSignInChoiceViewController *circleViewController; // 圈子动态控制器
@property (strong,nonatomic)EaseConversationListViewController *conversationController; // 会话界面控制器
@property (strong,nonatomic)EaseUsersListViewController *userListController; // 好友界面
@property (strong,nonatomic)UIViewController *noticeMessageController ;// 通知控制器
@property (strong,nonatomic)JTSignInViewController *attentionController; // 关注控制器
@property (strong,nonatomic)UIView *contentView;


@end

@implementation JTCircleMainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIView *navgationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 20)];
    navgationView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    [self.view addSubview:navgationView];
    
    self.segmentControl = [[JTSegmentControl alloc] initWithFrame:CGRectMake(0, 20, kScreenWidth, 44) normalColor:[UIColor blackColor] selectColor:tGreenColor titles:[NSArray arrayWithObjects:@"会话",@"动态",@"消息",@"朋友",@"关注",@"其他1",@"其他2",@"其他3",@"其他4",@"其他5",@"其他6", nil] SegmentSize:CGSizeMake(kScreenWidth,44) ItemSize:CGSizeMake(70, 20) titleFont:[UIFont systemFontOfSize:13]];
    [self.view addSubview:self.segmentControl];
    [self setUpSubViews];
    
    
}
// self控制器视图布局
-(void)setUpSubViews{
    __weak typeof (JTCircleMainController *)mainController = self;
    [self.view addSubview:self.segmentControl];
    self.scrollView = [UIScrollView new];
     self.scrollView.contentSize = CGSizeMake(kScreenWidth * 5, kscreenHeight - self.segmentControl.height);
     // self.scrollView.contentOffset = CGPointMake(0, 0);
    self.scrollView.showsHorizontalScrollIndicator = YES;
    self.scrollView.pagingEnabled = YES;
    self.scrollView.bounces = NO;
    self.scrollView.contentInset = UIEdgeInsetsMake(64, 0, 49, 0);
    [self.view addSubview:self.scrollView];
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mainController.segmentControl.mas_bottom);
        make.left.equalTo(mainController.view.mas_left);
        make.right.equalTo(mainController.view.mas_right);
        make.bottom.equalTo(mainController.view.mas_bottom);
        
    }];
    
    self.contentView = [UIView new];
   [self.scrollView addSubview:self.contentView];
    [self.contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mainController.scrollView.mas_top);
        make.left.equalTo(mainController.scrollView.mas_left);
        make.bottom.equalTo(mainController.scrollView.mas_bottom);
        make.right.equalTo(mainController.scrollView.mas_right);
        make.width.mas_equalTo(kScreenWidth * 5);
        make.height.mas_equalTo(mainController.scrollView.height);
    }];
    // 在scrollView上布局子控制器视图
    [self setUpChildControllers];
    
}



-(void)setUpChildControllers {
    __weak typeof (JTCircleMainController *)mainController = self;
    // 动态
    self.circleViewController = [JTSignInChoiceViewController new];
    
    [self addChildViewController:self.circleViewController];
    self.circleViewController.view.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.circleViewController.view];
    [self.circleViewController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mainController.segmentControl.mas_top);
        make.left.equalTo(mainController.segmentControl.mas_left);
        make.bottom.equalTo(mainController.scrollView.mas_bottom);
        make.width.equalTo(mainController.scrollView.mas_width);
    }];
    
    // 会话
    self.conversationController = [EaseConversationListViewController new];
    [self addChildViewController:self.conversationController];
    self.conversationController.view.backgroundColor = [UIColor blueColor];
    [self.contentView addSubview:self.conversationController.view];
    [self.conversationController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mainController.circleViewController.view.mas_top);
        make.left.equalTo(mainController.circleViewController.view.mas_right);
        make.bottom.equalTo(mainController.circleViewController.view.mas_bottom);
        make.width.equalTo(mainController.circleViewController.view.mas_width);
    }];
    
    // 好友
    self.userListController = [EaseUsersListViewController new];
    [self addChildViewController:_userListController];
    self.userListController.view.backgroundColor = [UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0];
    [self.contentView addSubview:self.userListController.view];
    [self.userListController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mainController.circleViewController.view.mas_top);
        make.left.equalTo(mainController.conversationController.view.mas_right);
        make.bottom.equalTo(mainController.circleViewController.view.mas_bottom);
        make.width.equalTo(mainController.circleViewController.view.mas_width);
    }];
    
    // 关注
    self.attentionController = [JTSignInViewController new];
    [self addChildViewController: self.attentionController];
    self.attentionController.view.backgroundColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0];
    [self.contentView addSubview:self.attentionController.view];
    [self.attentionController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mainController.circleViewController.view.mas_top);
        make.left.equalTo(mainController.userListController.view.mas_right);
        make.bottom.equalTo(mainController.circleViewController.view.mas_bottom);
        make.width.equalTo(mainController.circleViewController.view.mas_width);
    }];
    
    // 消息
    self.noticeMessageController = [UIViewController new];
    [self addChildViewController:self.noticeMessageController];
    self.noticeMessageController.view.backgroundColor = [UIColor colorWithRed:0.5 green:0.0 blue:0.5 alpha:1.0];
    [self.contentView addSubview:self.noticeMessageController.view];
    [self.noticeMessageController.view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mainController.circleViewController.view.mas_top);
        make.left.equalTo(mainController.attentionController.view.mas_right);
        make.bottom.equalTo(mainController.circleViewController.view.mas_bottom);
        make.width.equalTo(mainController.circleViewController.view.mas_width);
    }];
    
    
    
}


@end

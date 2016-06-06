//
//  MainViewController.m
//  DuBi
//
//  Created by lanou3g on 16/5/19.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "MainViewController.h"
#import "InfomationHandle.h"
#import "MainViewCell.h"
#import "MBProgressHUD+gifHUD.h"
#import "InfomationHandle.h"
#import "LWNMainPageUrl.h"
#import "PictureController.h"
#import "PictureHandle.h"
#define kInfomationHandle [InfomationHandle sharedInfomationHandle]
#define kPictureHandle [PictureHandle sharedPictureHandle]
#import "PictureViewCell.h"
#import "LWNViewController.h"
#import "LWNTableView.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
static NSString *const reuseIdentifier = @"cellID";
@interface MainViewController ()<UITableViewDataSource,UITableViewDelegate,UIScrollViewDelegate>
@property(strong,nonatomic)UIScrollView *scrollView;
@property(strong,nonatomic)LWNTableView *topicTableView;
@property(strong,nonatomic)LWNTableView *pictureTableView;
@property(strong,nonatomic)LWNTableView *mainTableView;

@end
@implementation MainViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViews];
    
    // 注册cell
    [self.topicTableView registerClass:[PictureViewCell class] forCellReuseIdentifier:reuseIdentifier];
}
-(void)setUpViews{
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWidth , kHeight)];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.userInteractionEnabled = YES;
   // self.scrollView.delegate = self;
    self.scrollView.contentSize = CGSizeMake(kWidth * 3, 0);
    self.scrollView.bounces = NO;
    //self.scrollView.scrollEnabled = YES;
   // self.scrollView.contentOffset= CGPointMake(kWidth, 0);
    [self.view addSubview:_scrollView];
    
//    LWNTableView *table1 = [[LWNTableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
//    [self.scrollView addSubview:table1];
//    
   
    self.mainTableView = [[LWNTableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight) ];
    [self.mainTableView getDataWithString:[NSString stringWithFormat:kTopicUrl,@""]];
    self.mainTableView.tag = 100;
    self.mainTableView.backgroundColor = [UIColor orangeColor];
    self.mainTableView.delegate = self;
    self.mainTableView.dataSource = self;
    self.topicTableView = [[LWNTableView alloc]initWithFrame:CGRectMake(kWidth, 0, kWidth, kHeight)];
    self.topicTableView.backgroundColor = [UIColor greenColor];
    [self.topicTableView getDataWithString:[NSString stringWithFormat:kTopicUrl,@""]];
    self.topicTableView.tag = 101;
    self.topicTableView.delegate = self;
    self.topicTableView.dataSource = self;
    self.pictureTableView = [[LWNTableView alloc]initWithFrame:CGRectMake(kWidth * 2, 0, kWidth, kHeight)];
    //self.pictureTableView.backgroundColor = [UIColor redColor];
    [self.pictureTableView getDataWithString:[NSString stringWithFormat:kPictureUrl,@""]];
    self.pictureTableView.tag = 102;
    self.pictureTableView.delegate = self;
    self.pictureTableView.dataSource = self;
    // 三个tableView 添加到scrollview
    [self.scrollView addSubview:self.mainTableView];
    [self.scrollView addSubview:self.topicTableView];
    [self.scrollView addSubview:self.pictureTableView];
    



}


//-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
//    NSInteger number = scrollView.contentOffset.x / kWidth;
//    if (number == 0) {
//        
//    }else if (number == 1){
//    
//    }else if (number == 2){
//    
//    }
//    
//    
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView.tag == 100) {
        NSLog(@"%ld",self.topicTableView.dataArray.count);
        return [self.mainTableView numberOfRows:section] ;

    } else if (tableView.tag == 101 ) {
    
        return [self.topicTableView numberOfRows:section] ;
        
    }else{
        return [self.pictureTableView numberOfRows:section] ;

    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PictureViewCell *cell = [self.topicTableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    if (tableView.tag == 100) {
        Picture *picture = [self.mainTableView piturForRowInSection:indexPath];
      cell.picture =  picture;
        NSLog(@"%@11",cell.picture);
    
    } else if (tableView.tag == 101) {
        Picture *picture = [self.topicTableView piturForRowInSection:indexPath];
        cell.picture = picture;
        NSLog(@"%@22",cell.picture);

    }else{
        Picture *picture = [self.pictureTableView piturForRowInSection:indexPath];
        cell.picture = picture;
    }
 //   cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{



}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView.tag == 100) {
      Picture * picture =  self.mainTableView.dataArray[indexPath.row] ;
        return [PictureViewCell heightFor:picture];
    } else if (tableView.tag == 101) {
      Picture * picture =  self.topicTableView.dataArray[indexPath.row] ;
        return [PictureViewCell heightFor:picture];

    }else{
      Picture * picture =  self.pictureTableView.dataArray[indexPath.row] ;
        return [PictureViewCell heightFor:picture];

    }

}
#pragma mark ----收藏,分享功能-----
// 点击cell会模态出AlertController,在这这里进行分享,收藏的操作

-(void)shareActionWithTopic:(Topic *)topic{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"" preferredStyle:(UIAlertControllerStyleActionSheet)];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"收藏" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        // 收藏
        // 收藏之前要判断是否登录,已经登录,直接收藏
        
        // 否则,进入登录界面
        
        
        
    }];
    UIAlertAction *shareAction = [UIAlertAction actionWithTitle:@"分享" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertController addAction:cancleAction];
    [alertController addAction:shareAction];
    [alertController addAction:action];
    [self presentViewController:alertController animated:YES completion:nil];
}
#pragma mark ----点击button进行不同的页面跳转--------

/*
- (IBAction)pictureAction:(id)sender {
  // 点击button,进行不同的数据请求
    [self requestPictureData];
}
-(void)requestPictureData{
  
}

- (IBAction)pushAction:(id)sender {
    LWNViewController *lwn = [LWNViewController new];
    [self.navigationController pushViewController:lwn animated:YES];
}
*/



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

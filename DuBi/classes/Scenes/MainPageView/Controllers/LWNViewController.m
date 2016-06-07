//
//  LWNViewController.m
//  DuBi
//
//  Created by lanou3g on 16/5/26.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "LWNViewController.h"
#define kWidth [UIScreen mainScreen].bounds.size.width
#define kHeight [UIScreen mainScreen].bounds.size.height
#import "PictureHandle.h"
#define kHandle [PictureHandle sharedPictureHandle]
#import "PictureViewCell.h"
#import "LWNMainPageUrl.h"
#import <MBProgressHUD.h>
#import "LWNTableView.h"
@interface LWNViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *TopicButton;
@property (weak, nonatomic) IBOutlet UIButton *PictureButton;
@property (weak, nonatomic) IBOutlet UIButton *MovieButton;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) IBOutlet UITableView *topicTableView;
@property (strong, nonatomic) IBOutlet UITableView *pictureTableView;
@property (strong, nonatomic) IBOutlet UITableView *MovieTableView;
@property(strong,nonatomic)UIView *middleView;
@end

@implementation LWNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.topicTableView = [[LWNTableView alloc]initWithFrame:CGRectMake(0, 0, kWidth, kHeight) withUrl:[NSString stringWithFormat:kTopicUrl,@""]];
    self.topicTableView.delegate = self;
    //self.tableView.backgroundColor = [UIColor yellowColor];
   // self.pictureTableView = [[LWNTableView alloc]initWithFrame:CGRectMake(kWidth, 0, kWidth, kHeight) withUrl:[NSString stringWithFormat:kPictureUrl,@""]];
    self.pictureTableView.delegate = self;
    
//    self.tableView2.backgroundColor = [UIColor blackColor];
//    self.tableView3 = [[LWNTableView alloc]initWithFrame:CGRectMake(kWidth * 2, 0, kWidth, kHeight) withUrl:@""];
//    self.tableView3.backgroundColor = [UIColor redColor];
//    self.tableView3.delegate = self;
//    
    self.scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, kWidth * 3, kHeight)];
    [self.scrollView addSubview:self.topicTableView];
    [self.scrollView addSubview:self.pictureTableView];
   // [self.scrollView addSubview:self.tableView3];
    self.scrollView.contentSize = CGSizeMake(kWidth, 0);
    self.scrollView.pagingEnabled = YES;
    // 添加下面的视图
    /*
    NSLog(@"%f",_MovieButton.center.x);
    self.middleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 46, 5)];
    self.middleView.backgroundColor = [UIColor cyanColor];
    self.middleView.center = self.TopicButton.center;
    [self.view addSubview:self.middleView];
     */
    // 数据请求
    kHandle.pictureArray = nil;
    [self requestData];
    [self showHUD];
    // 设置代理
//    self.scrollView.delegate = self;
//    self.scrollView.pagingEnabled = YES;
//    self.topicTableView.delegate = self;
//    self.topicTableView.dataSource = self;
//    self.pictureTableView.delegate = self;
//    self.pictureTableView.dataSource = self;
    // 注册cell
    [self.topicTableView registerNib:[UINib nibWithNibName:@"PictureViewCell" bundle:nil] forCellReuseIdentifier:@"topicID"];
    [self.pictureTableView registerNib:[UINib nibWithNibName:@"PictureViewCell" bundle:nil] forCellReuseIdentifier:@"pictureID"];
}
-(void)requestData{
    [kHandle getDataWithString:[NSString stringWithFormat:kTopicUrl,@""] comptionBlock:^(NSMutableArray *array) {
        dispatch_async(dispatch_get_main_queue(), ^{
             [self updateData];
        });
       
    }];
}

-(void)updateData{
  
    [self.topicTableView reloadData];
    [self hideHUD];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)showHUD{
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.pictureTableView animated:YES];
    HUD.labelText = @"玩命加载中";
}
-(void)hideHUD{
    [MBProgressHUD hideHUDForView:self.pictureTableView animated:YES];
}
#pragma mark ---scrollView的代理方法----
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger number = scrollView.contentOffset.x / kWidth;
    if (number == 0) {
        kHandle.pictureArray = nil;
        [self.topicTableView reloadData];
        [self requestData];
        [self showHUD];
       
    }
    if (number == 1) {
        kHandle.pictureArray = nil;
        [self.pictureTableView reloadData];

        [self requestPictureData];
        [self showHUD];

    }

}
-(void)requestPictureData{
    
    [kHandle getDataWithString:[NSString stringWithFormat:kPictureUrl,@""] comptionBlock:^(NSMutableArray *array) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updatePictureData];
        });
        

    }];



}
-(void)updatePictureData{
    [self.pictureTableView reloadData];
    [self hideHUD];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return 1;
}
/*
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    if ([tableView isEqual:_topicTableView]) {
        return self.topicTableView.array.count ;
        
    } else if ([tableView isEqual:_tableView2]) {
        
        return self.tableView2.array.count ;
        
    }else{
        return self.tableView3.array.count ;
        
    }

}
*/
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView.tag == 100) {
        //[self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        // [_pictureTableView reloadData];
        PictureViewCell *cell = [_pictureTableView  dequeueReusableCellWithIdentifier:@"pictureID" forIndexPath:indexPath];
        cell.picture = [kHandle pictureForCellAtIndexPath:indexPath];
        return cell;
    }
    
  // 获取cell
    else{
    PictureViewCell *cell = [_topicTableView dequeueReusableCellWithIdentifier:@"topicID" forIndexPath:indexPath];
    cell.picture = [kHandle pictureForCellAtIndexPath:indexPath];
    return cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    Picture *picture = [kHandle pictureForCellAtIndexPath:indexPath];
    return [PictureViewCell heightFor:picture];
}
- (IBAction)topicAction:(id)sender {
    
    self.scrollView.contentOffset = CGPointMake(0, 0);
    
}
- (IBAction)pictureAction:(id)sender {
    self.scrollView.contentOffset = CGPointMake(kWidth, 0);
    
    
}
- (IBAction)movieAction:(id)sender {
    self.scrollView.contentOffset = CGPointMake(kWidth * 2, 0);
}
-(void)viewDidAppear:(BOOL)animated{
    self.scrollView.contentSize = CGSizeMake(kWidth * 3, 0);
    
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

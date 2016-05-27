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
@interface LWNViewController ()<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *TopicButton;
@property (weak, nonatomic) IBOutlet UIButton *PictureButton;
@property (weak, nonatomic) IBOutlet UIButton *MovieButton;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITableView *topicTableView;
@property (weak, nonatomic) IBOutlet UITableView *pictureTableView;
@property (weak, nonatomic) IBOutlet UITableView *MovieTableView;
@property(strong,nonatomic)UIView *middleView;
@end

@implementation LWNViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 添加下面的视图
    /*
    NSLog(@"%f",_MovieButton.center.x);
    self.middleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 46, 5)];
    self.middleView.backgroundColor = [UIColor cyanColor];
    self.middleView.center = self.TopicButton.center;
    [self.view addSubview:self.middleView];
     */
    // 数据请求
    [self requestData];
    [self showHUD];
    // 设置代理
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = YES;
    self.topicTableView.delegate = self;
    self.topicTableView.dataSource = self;
    self.pictureTableView.delegate = self;
    self.pictureTableView.dataSource = self;
    // 注册cell
    [self.topicTableView registerNib:[UINib nibWithNibName:@"PictureViewCell" bundle:nil] forCellReuseIdentifier:@"topicID"];
    [self.pictureTableView registerNib:[UINib nibWithNibName:@"PictureViewCell" bundle:nil] forCellReuseIdentifier:@"pictureID"];
}
-(void)requestData{
    [kHandle getDataWithString:[NSString stringWithFormat:kTopicUrl,@""] comptionBlock:^(NSMutableArray *array) {
        [self updateData];
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
    MBProgressHUD *HUD = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    HUD.labelText = @"玩命加载中";
}
-(void)hideHUD{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}
#pragma mark ---scrollView的代理方法----
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger number = scrollView.contentOffset.x / kWidth;
    if (number == 0) {
        [self requestData];
        [self showHUD];
       
    }
    if (number == 1) {
        [self requestPictureData];
        [self showHUD];
    }

}
-(void)requestPictureData{
    
    [kHandle getDataWithString:[NSString stringWithFormat:kPictureUrl,@""] comptionBlock:^(NSMutableArray *array) {
        [self updatePictureData];
    }];



}
-(void)updatePictureData{
    [self.pictureTableView reloadData];
    [self hideHUD];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{

    return [kHandle numberOfSections];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return [kHandle numofRowsAtSection:section];
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([tableView isEqual:_pictureTableView]) {
        PictureViewCell *cell = [_pictureTableView  dequeueReusableCellWithIdentifier:@"pictureID" forIndexPath:indexPath];
        cell.picture = [kHandle pictureForCellAtIndexPath:indexPath];
        return cell;
    }
    
  // 获取cell
  
    PictureViewCell *cell = [_topicTableView dequeueReusableCellWithIdentifier:@"topicID" forIndexPath:indexPath];
    cell.picture = [kHandle pictureForCellAtIndexPath:indexPath];
    return cell;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

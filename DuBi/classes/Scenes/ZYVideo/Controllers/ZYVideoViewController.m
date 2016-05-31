//
//  ZYVideoViewController.m
//  DuBi
//
//  Created by lanou3g on 16/5/23.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZYVideoViewController.h"
#import "ZYVideoCell.h"
#import "ZDCustomVedioCell.h"
#import "UIView+XYWidthHeight.h"
#import "DataModels.h" // model
#import <AFNetworking.h>
#import "MJRefresh.h"
#import "TLFZAVplayer.h"

#define kUrl @"http://api.budejie.com/api/api_open.php"

@interface ZYVideoViewController ()

/**
 *  // 装在所有 ZDList model 的数组
 */
@property(strong,nonatomic)NSMutableArray * listArry;

/**
 *  // 装所有  ZDThemes model
 */
@property(strong,nonatomic)NSMutableArray * themesArray;

/**
 *  // 装所有  ZDInfo model
 */
@property(strong,nonatomic)NSMutableArray * infoArray;

@property(strong,nonatomic)NSString * maxtime;

@property(assign,nonatomic)NSInteger  page;

@property(strong,nonatomic)TLFZAVplayer * tlPlayer;
@end



static NSString * const registerId = @"ZDCustomVedioCell";
@implementation ZYVideoViewController

#pragma mark --- setter getter 方法
-(NSMutableArray *)listArry
{
    if (!_listArry) {
    
        _listArry = [NSMutableArray array];
    }
    return _listArry;
}

-(NSMutableArray *)themesArray
{
    if (!_themesArray) {
     
        _themesArray = [NSMutableArray array];
    }
    return _themesArray;
}

-(NSMutableArray *)infoArray
{
    if (!_infoArray) {
        
        _infoArray = [NSMutableArray array];
    }
    return _infoArray;
}

#pragma mark --- viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];

    // 注册tableView和title一些其他设置
    [self setTableViewAndTitle];
    
    // 下拉加载上啦刷新
    [self  setupRefresh];
    
    
}




-(void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestAction)];
    self.tableView.separatorStyle = UITableViewScrollPositionNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    // 根据拖拽比例切换透明度
    [self.tableView.mj_header beginRefreshing];
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
}



/**
 *  数据请求 -- 解析
 */
#pragma mark --- 数据请求
-(void)requestAction
{
    __weak typeof(ZYVideoViewController *) temp = self;
    NSMutableDictionary * paramet = [NSMutableDictionary dictionary];
    paramet[@"a"] = @"list";
    paramet[@"c"] = @"data";
    paramet[@"type"] = @(41);
    [[AFHTTPSessionManager manager] GET:kUrl parameters:paramet progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        // NSLog(@"%@",responseObject);
        NSArray * array = responseObject[@"list"];
//        NSLog(@"%@",array);
        self.maxtime = responseObject[@"info"][@"maxtime"];
        ZDInfo *  infoModel = [[ZDInfo alloc]initWithDictionary:responseObject[@"info"]];
        [temp.infoArray addObject:infoModel];
       // NSLog(@"infoArray --------------  %ld",temp.infoArray.count);
        
        for (NSDictionary * dict in array) {
            
            ZDList * model = [[ZDList alloc]initWithDictionary:dict];
            [temp.listArry addObject:model];
          //  NSLog(@"listArray ---------------  %ld",self.listArry.count);
            
            for (NSDictionary * dic in temp.listArry) {
                
                ZDThemes * themesModel = [[ZDThemes alloc]initWithDictionary:dic];
                [temp.themesArray addObject:themesModel];
            //    NSLog(@"themesArray --------------- %ld",temp.themesArray.count);
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [temp.tableView reloadData];
                [self.tableView.mj_header endRefreshing];
            });
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
         //   NSLog(@"-------------------- error = %@",error);
    }];
}
-(void)loadMoreTopics
{
    self.page++;
    NSMutableDictionary * params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @(41);
    params[@"page"] = @(self.page);
    params[@"maxtime"] = self.maxtime;
    
    [[AFHTTPSessionManager manager] GET:kUrl parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, NSDictionary *  _Nullable responseObject) {
        // 存储maxttime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        
        for (NSDictionary * dict in responseObject[@"list"])
        {
            ZDList * model = [[ZDList alloc]initWithDictionary:dict];
            [self.listArry addObject:model];
        }
        [self.tableView reloadData];
        [self.tableView.mj_footer endRefreshing];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
       
        // 如果网络不好而又请求了下一页，那么客户会永远看不到那一页。所以page--
        [self.tableView.mj_footer endRefreshing];
        self.page--;
    }];

}

/**
 *  tableView的设置
 */
#pragma mark --- 注册tableView和title一些其他设置

-(void)setTableViewAndTitle
{
    self.view.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.773060344827586];
    self.navigationItem.title = @"花心大罗卜";
    
    //  [self.tableView registerNib:[UINib nibWithNibName:[NSStringFromClass([ZDCustomVedioCell class])] bundle:nil] forCellReuseIdentifier:registerId];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([ZDCustomVedioCell class]) bundle:nil] forCellReuseIdentifier:registerId];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   //  NSLog(@"%@",self.listArry);
    
    return self.listArry.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   //  ZYVideoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ZYCellID" forIndexPath:indexPath];
    ZDCustomVedioCell * cell = [tableView dequeueReusableCellWithIdentifier:registerId forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellAccessoryNone;
     cell.listModel = self.listArry[indexPath.row];
   //  cell.infoModel = self.infoArray[indexPath.row];
    cell.themesModel = self.themesArray[indexPath.row];
    
//    self.tlPlayer = [TLFZAVplayer shareAVPlayer];
//    [self.tlPlayer drawAVPlayer];
//    self.tlPlayer.frame = cell.backgroundView.frame;
//    [self.tlPlayer playWithString:cell.listModel.videouri];
//    [cell.contentView addSubview:self.tlPlayer];
//    
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.view.height/ 9 * 4 ;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
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

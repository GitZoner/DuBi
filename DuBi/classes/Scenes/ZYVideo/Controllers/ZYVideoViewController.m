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
    
    // 数据请求
    [self requestAction];
    
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
        
        ZDInfo *  infoModel = [[ZDInfo alloc]initWithDictionary:responseObject[@"info"]];
        [temp.infoArray addObject:infoModel];
        NSLog(@"infoArray --------------  %ld",temp.infoArray.count);
        
        for (NSDictionary * dict in array) {
            
            ZDList * model = [[ZDList alloc]initWithDictionary:dict];
            [temp.listArry addObject:model];
            NSLog(@"listArray ---------------  %ld",self.listArry.count);
            
            for (NSDictionary * dic in temp.listArry) {
                
                ZDThemes * themesModel = [[ZDThemes alloc]initWithDictionary:dic];
                [temp.themesArray addObject:themesModel];
                NSLog(@"themesArray --------------- %ld",temp.themesArray.count);
            }
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [temp.tableView reloadData];
            });
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
            NSLog(@"-------------------- error = %@",error);
    }];
}


/**
 *  tableView的设置
 */
#pragma mark --- 注册tableView和title一些其他设置

-(void)setTableViewAndTitle
{
    self.view.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.773060344827586];
    self.navigationItem.title = @"爱AV";
    
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
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return self.view.height/ 9 * 4 ;
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

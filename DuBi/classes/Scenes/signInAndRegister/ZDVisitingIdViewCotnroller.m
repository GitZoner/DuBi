//
//  ZDVisitingIdViewCotnroller.m
//  DuBi
//
//  Created by lanou3g on 16/6/5.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZDVisitingIdViewCotnroller.h"

@interface ZDVisitingIdViewCotnroller ()
/**
 *  头像属性
 */
@property (weak, nonatomic) IBOutlet UIImageView *protraitImageView;

/**
 *  别名儿
 */
@property (weak, nonatomic) IBOutlet UILabel *aliasLabel;

/**
 * tableView
 */
@property (weak, nonatomic) IBOutlet UITableView *tableView;

// 数组存放信息类别
@property(strong,nonatomic)NSMutableArray * typeArray;

// 存放信息
@property(strong,nonatomic)NSMutableArray * infoArray;
@end

@implementation ZDVisitingIdViewCotnroller

-(NSMutableArray *)typeArray
{
    if (!_typeArray) {
     
        _typeArray = [NSMutableArray array];
    }
    return _typeArray;
}

-(NSMutableArray *)infoArray
{
    if (!_infoArray) {
     
        _infoArray = [NSMutableArray array];
    }
    return _infoArray;
}

-(void)addDataForArray{

    NSArray * typeArr = @[@"昵称",@"性别",@"生日",@"爱好",@"个人说明"];
    
    
    NSArray * dataArr = @[];
    

}







- (void)viewDidLoad {
    [super viewDidLoad];
    
    
}

// 返回上一页面
- (IBAction)dismissAction {
}

























@end


//
//  ZDSendJokes.m
//  DuBi
//
//  Created by lanou3g on 16/5/31.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZDSendJokes.h"
#import <FMDB.h>

@interface ZDSendJokes ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

//
@property(strong,nonatomic) FMDatabase * dataBase;
// 同时处理多任务操作，用来 代替人为多线程访问数据库资源
@property(strong,nonatomic) FMDatabaseQueue * queue;


@end

@implementation ZDSendJokes

- (void)viewDidLoad {
    [super viewDidLoad];
  // 构造表路径
    NSString * path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * fileName = [path stringByAppendingPathComponent:@"shuoshuo.sqlite"];
    
    // 获取数据库
    FMDatabase * db = [FMDatabase databaseWithPath:fileName];
    
    if ([db open]) {
        [db executeUpdate:@"CREATE TABLE IF NOT EXISTE "];
    }

}

// 返回按钮
- (IBAction)back:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

// 发表按钮
- (IBAction)faBiao:(UIButton *)sender {
    
    
    
    
}


- (IBAction)placeDian:(UIButton *)sender {
}


- (IBAction)fenXiangTime:(UIButton *)sender {
}

- (IBAction)fenXiangWeiXin:(UIButton *)sender {
}

- (IBAction)fenXiangQQ:(UIButton *)sender {
}




















@end

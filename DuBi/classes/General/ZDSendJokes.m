
//
//  ZDSendJokes.m
//  DuBi
//
//  Created by lanou3g on 16/5/31.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZDSendJokes.h"
#import <FMDB.h>
#import <AVOSCloud/AVOSCloud.h>
#import "Main_marco.h"
@interface ZDSendJokes ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;

//
@property(strong,nonatomic) FMDatabase * dataBase;
// 同时处理多任务操作，用来 代替人为多线程访问数据库资源
@property(strong,nonatomic) FMDatabaseQueue * queue;

@property (weak, nonatomic) IBOutlet UILabel *tipLabel;

@end

@implementation ZDSendJokes

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.textView.delegate = self;
    
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
    
    
    AVObject *userDeliverInfo = [AVObject  objectWithClassName:@"userDeliverInfo"];// 构建对象
    
    
    
//    AVObject *todo1 = [[AVObject alloc] initWithClassName:@"userInfo"];
//    AVObject *todo2 = [[AVObject alloc] initWithClassName:@"userInfo"];
//    AVObject *todo3 = [[AVObject alloc] initWithClassName:@"userInfo"];
//    
//#warning 一共两个字段需要关联所以不能这样写吧；
//    
//    
//[AVObject saveAllInBackground:@[todo1,todo2,todo3] block:^(BOOL succeeded, NSError *error) {
//        if (error) {
//            // 出现错误
//            NSLog(@"%@",error);
//        } else {
//            // 保存成功
//            AVRelation *relation = [userDeliverInfo relationforKey:@"likeItems"];// 新建一个 AVRelation
//            [relation addObject:todo1];
//            [relation addObject:todo2];
//            [relation addObject:todo3];
//            // 上述 3 行代码表示 relation 关联了 3 个 Todo 对象
//            
//            [userDeliverInfo saveInBackground];// 保存到云端
//        }
//    }];
//

    
    [userDeliverInfo setObject:kUserDefaultGetValue(kUserInfoKey_telNum) forKey:@"name"];// 设置名称
//    [userDeliverInfo setObject:kUserDefaultGetValue(kUserInfoKey_userAlias) forKey:@"userAlias"];
    [userDeliverInfo setObject:@"纯文本" forKey:@"publishType"];// 设置名称
    [userDeliverInfo setObject:@1 forKey:@"priority"];// 设置优先级
    [userDeliverInfo setObject:self.textView.text forKey:@"msgContent"];
    
    
    
   
    
    
    
    
    
    [userDeliverInfo saveInBackground];// 保存到服务端
    [self.textView resignFirstResponder];
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您已发表成功！" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
      
        
    }];
    
    
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:YES completion:nil];



    
}


- (IBAction)placeDian:(UIButton *)sender
{
    
    
}


- (IBAction)fenXiangTime:(UIButton *)sender
{
}

- (IBAction)fenXiangWeiXin:(UIButton *)sender
{
}

- (IBAction)fenXiangQQ:(UIButton *)sender
{
}


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    
    NSLog(@"SDFERfgre");
    [self.tipLabel removeFromSuperview];
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
    [super touchesBegan:touches withEvent:event];
    [self.view endEditing:YES];
    NSLog(@"EFERg");
}


















@end

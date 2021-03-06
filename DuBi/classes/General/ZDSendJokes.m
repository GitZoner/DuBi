
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
    
    
    
    
    [userDeliverInfo setObject:kUserDefaultGetValue(kUserInfoKey_telNum) forKey:@"name"];// 设置名称
    [userDeliverInfo setObject:@"纯文本" forKey:@"publishType"];// 设置名称
    [userDeliverInfo setObject:@1 forKey:@"priority"];// 设置优先级
    [userDeliverInfo setObject:self.textView.text forKey:@"msgContent"];
    [userDeliverInfo setObject:kUserDefaultGetValue(kUserInfoKey_userAlias) forKey:@"userAlias"];
    [userDeliverInfo setObject:kUserDefaultGetValue(kUserInfoKey_protrait) forKey:@"iconName"];
    
        
    [userDeliverInfo saveInBackground];// 保存到服务端
    [self.textView resignFirstResponder];
    
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您已发表成功！" preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"确定" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
      
        [self dismissViewControllerAnimated:YES completion:nil];
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
   
}


















@end

//
//  JTRegisterViewController.m
//  DuBi
//
//  Created by Jason on 16/5/24.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "JTRegisterViewController.h"
#import <SMS_SDK/SMSSDK.h>
#import "RegularUtils.h"
#import "XHToast.h"
#import "JTBuddyManager.h"
#import "JTAliasViewController.h"
#import "JTSignInChoiceViewController.h"


@interface JTRegisterViewController ()
// 返回按钮

// 手机号输入框
@property (weak, nonatomic) IBOutlet UITextField *telNumTextField;
// 短信验证码输入框
@property (weak, nonatomic) IBOutlet UITextField *verCodeTextField;
// 获取短信验证码的按钮
@property (weak, nonatomic) IBOutlet UIButton *requestVerCodeButton;
// 密码输入框
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
// 立即注册按钮
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation JTRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    // 设置子视图
    [self setSubViews];
}

// 设置子视图相关属性
-(void)setSubViews {
    self.requestVerCodeButton.layer.cornerRadius = 5;
    self.requestVerCodeButton.layer.masksToBounds = YES;
    
    self.registerButton.layer.cornerRadius = 5;
    self.registerButton.layer.masksToBounds = YES;
}

// 获取短信验证码的点击事件
- (IBAction)requestVerCodeButtonAction:(UIButton *)sender {
    
    if ([RegularUtils checkTelNumber:self.telNumTextField.text]) {
        [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.telNumTextField.text zone:@"86" customIdentifier:nil result:^(NSError *error){
            if (!error) {
                [XHToast showBottomWithText:@"验证码已发送" bottomOffset:100 duration:3];
                // 打开计时器，计算验证码发送时间
                [NSTimer timerWithTimeInterval:1 target:self selector:@selector(verCodeTimerAction:) userInfo:nil repeats:YES];
            } else {
                NSLog(@"错误信息：%@",error);
            }
         }];
    }else {
        // 使用第三个HUD，提示错误信息
        [XHToast showBottomWithText:@"请输入正确的手机号" bottomOffset:100 duration:3];
    }
   
  
    
}
-(void)verCodeTimerAction:(NSTimer *)timer {
    static NSInteger i = 60;
    self.requestVerCodeButton.enabled = NO;
    [self.requestVerCodeButton setTitle:[NSString stringWithFormat:@"重获验证码：%ld",i ] forState:(UIControlStateNormal)];
    NSLog(@"%ld",i);
    --i;
    if (i <= 0) {
        [self.requestVerCodeButton setTitle:@"获取验证码" forState:(UIControlStateNormal)];
        self.requestVerCodeButton.enabled = YES;
        [timer invalidate];
        i = 60;
    }
    
}



// 注册按钮点击事件
- (IBAction)registerButtonAction:(id)sender {


    // 首先校验密码强度
    if ([RegularUtils checkPassword:self.passWordTextField.text]) {
        // 密码校验正确，然后检验验证码的正确性
        [SMSSDK commitVerificationCode:self.verCodeTextField.text phoneNumber:_telNumTextField.text zone:@"86" result:^(NSError *error) {
            
            if (!error) {
                // 验证码输入正确，进行后台注册
                [[JTBuddyManager sharedJTBuddyManager] registerWithUsername:self.telNumTextField.text password:self.passWordTextField.text successed:^{
                    // 注册成功，弹出昵称界面
                    // 弹出注册成功的提示
                    [XHToast showBottomWithText:@"注册成功" bottomOffset:100 duration:3];
                    // 进入昵称界面
                    [self presentViewController:[JTAliasViewController new] animated:YES completion:nil];
                } failed:^(NSError * error) {
                    // 注册失败，弹出提示窗口
                    [XHToast showBottomWithText:error.domain bottomOffset:100 duration:3];
                } ];
                
            }
            else
            {
                // 验证码输入错误，弹出提示
                [XHToast showBottomWithText:@"验证码输入错误" bottomOffset:100 duration:3];
            }
        }];
    }else {
        
        [XHToast showBottomWithText:@"密码强度较弱，请重新输入密码" bottomOffset:100 duration:3];
    }
    
}

// 返回按钮事件
- (IBAction)goBackButtonAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



-(void)dismissSelf {
    [self dismissViewControllerAnimated:YES completion:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

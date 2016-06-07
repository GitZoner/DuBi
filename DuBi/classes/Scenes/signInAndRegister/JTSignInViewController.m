//
//  JTSignInViewController.m
//  DuBi
//
//  Created by Jason on 16/5/27.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "JTSignInViewController.h"
#import "JTRegisterViewController.h"
#import "RegularUtils.h"
#import "XHToast.h"
#import "JTBuddyManager.h"
#import "Main_marco.h"
@interface JTSignInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;

@end

@implementation JTSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.signInButton.layer.cornerRadius = 7;
    self.signInButton.layer.masksToBounds = YES;
}

// 重设密码按钮
- (IBAction)resetPasswordAction:(UIButton *)sender {
    
    
}

// 注册按钮
- (IBAction)registerAction:(UIButton *)sender {
    [self.navigationController pushViewController:[JTRegisterViewController new] animated:YES];
}

// 登录按钮
- (IBAction)signInButtonAction:(UIButton *)sender {

    if ([RegularUtils checkTelNumber:self.userNameTextField.text ]&& [RegularUtils checkPassword:self.passWordTextField.text]) {
        [[JTBuddyManager sharedJTBuddyManager] loginWithUsername:self.userNameTextField.text password:self.passWordTextField.text successed:^{
            [XHToast showBottomWithText:@"登录成功" bottomOffset:100 duration:3];
            
            if (_delegate && [_delegate respondsToSelector:@selector(reloadView)]) {
                [_delegate reloadView];
            }
            
            [[NSNotificationCenter  defaultCenter] postNotificationName:kNotification_loginIn object:nil];
            
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        } failed:^(NSError * error) {
            [XHToast showBottomWithText:error.domain bottomOffset:100 duration:0];
        }];
    }else {
        [XHToast showBottomWithText:@"请输入合法的手机号和密码" bottomOffset:100 duration:3];
    }
    
    
}
- (IBAction)goBackAction:(UIButton *)sender {
    
    
    [self.navigationController popViewControllerAnimated:YES];
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

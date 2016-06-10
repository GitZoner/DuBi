//
//  JTRegisterViewController.m
//  DuBi
//
//  Created by Jason on 16/5/24.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "JTSignInChoiceViewController.h"
#import "UIView+XYWidthHeight.h"
#import "JTRegisterViewController.h"
#import "JTAliasViewController.h"
#import "RegularUtils.h"
#import "JTSignInViewController.h"

@interface JTSignInChoiceViewController ()
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;
@property (weak, nonatomic) IBOutlet UIButton *notSignInButton;
@property (weak, nonatomic) IBOutlet UIButton *qqSignInButton;
@property (weak, nonatomic) IBOutlet UIButton *weiboSignInButton;
@property (weak, nonatomic) IBOutlet UIButton *phoneSignInButton;


@end

@implementation JTSignInChoiceViewController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
    self.navigationController.navigationBarHidden = YES;
  
    self.tabBarController.tabBar.hidden= YES;

}

- (void)viewDidLoad {
    [super viewDidLoad];
   // 设置视图上button的相关属性
    [self setButtons];
  
   
    
    
}
- (IBAction)back {
    [self dismissViewControllerAnimated:YES completion:nil];
}


// 设置视图上button的相关属性
-(void)setButtons {
    self.signInButton.layer.cornerRadius = 5;
    self.signInButton.layer.masksToBounds= YES;
    self.signInButton.layer.borderWidth = 1;
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    
    CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){114/ 255.0,124/ 255.0,127/ 255.0,1});
    
    [self.signInButton.layer setBorderColor:color];
    
    self.registerButton.layer.cornerRadius = 5;
    self.registerButton.layer.masksToBounds= YES;
    self.registerButton.layer.borderWidth = 1;
    [self.registerButton.layer setBorderColor:color];
    
    self.qqSignInButton.layer.cornerRadius = self.qqSignInButton.width / 2;
    self.qqSignInButton.layer.masksToBounds = YES;
    
}

#pragma  mark --各button的点击事件

// 登录已有账户 按钮的事件
- (IBAction)signInButtonAction:(UIButton *)sender {
    [self.navigationController pushViewController:[JTSignInViewController new] animated:YES];
    
}

// 新用户注册 按钮的事件
- (IBAction)registerNewUserButtonAction:(UIButton *)sender {
    JTRegisterViewController *registerVC = [JTRegisterViewController new];
   [self.navigationController pushViewController:registerVC animated:YES];
    

    
    
}

// 暂不注册 按钮的事件
- (IBAction)notRegisterButtonAction:(UIButton *)sender {
    
//    [self popoverPresentationController];
    [self.navigationController popToRootViewControllerAnimated:YES
     ];
    
}

// QQ登录按钮
- (IBAction)qqSignInButtonAction:(UIButton *)sender {
    
}

// 新浪微博登录按钮
- (IBAction)weiboSignInButtonAction:(UIButton *)sender {
}

// 手机验证码登录按钮
- (IBAction)phoneSignInButtonAction:(UIButton *)sender {
    
}


-(void)layoutSublayersOfLayer:(CALayer *)layer {
    [super layoutSublayersOfLayer:layer];
    
    self.view.frame = [UIScreen mainScreen].bounds;
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

//
//  JTSignInViewController.m
//  DuBi
//
//  Created by Jason on 16/5/27.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "JTSignInViewController.h"
#import "JTRegisterViewController.h"
@interface JTSignInViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;

@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;

@end

@implementation JTSignInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)resetPasswordAction:(UIButton *)sender {
    
    
}
- (IBAction)registerAction:(UIButton *)sender {
    [self presentViewController:[JTRegisterViewController new] animated:YES completion:nil];
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

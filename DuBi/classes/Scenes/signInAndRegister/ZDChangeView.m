//
//  ZDChangeView.m
//  DuBi
//
//  Created by lanou3g on 16/5/29.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZDChangeView.h"
#import "Main_marco.h"
#import "UIView+XYWidthHeight.h"
#import "JTSignInChoiceViewController.h"
#import <Masonry.h>
#import "JTRegisterViewController.h"
#import "ZDUIAlert.h"
#import <UIImageView+WebCache.h>

#define kpresent [UIApplication sharedApplication].keyWindow.rootViewController

@interface ZDChangeView ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
// 登录状态
@property(strong,nonatomic)NSString * hasSign;

// 调用相册
@property(strong,nonatomic)UIImagePickerController * pickerController;



@end
@implementation ZDChangeView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
     
        [self drawView];
        
    }
    return self;
}

-(UIImagePickerController *)pickerController
{
    if (!_pickerController) {
        _pickerController = [UIImagePickerController new];
    }
    
    return _pickerController;
}
-(void)drawView{
    
   // 背景图片的设置
    [self addSubview:self.imageViewForHeader];
    // 头像的设置
    [self.imageViewForHeader addSubview:self.imageViewForUser];
    // 标题文字
    [self.imageViewForHeader addSubview:self.titleLabel];
    // 昵称
    [self.imageViewForHeader addSubview:self.nameButton];
    // 设置毛玻璃效果
    // [self fuzzyView];
}

#pragma mark imageViewForHeader ========================================================
// 背景图片的设置
-(UIImageView *)imageViewForHeader
{
    if (!_imageViewForHeader) {
      
        _imageViewForHeader = [[UIImageView alloc]initWithFrame:self.bounds];
        _imageViewForHeader.userInteractionEnabled = YES;
        _imageViewForHeader.image = [UIImage imageNamed:@"bgimage-2"];
        [self addSubview:_imageViewForHeader];
        
    }
    return _imageViewForHeader;
}
#pragma mark imageViewForUser ========================================================
-(UIImageView *)imageViewForUser
{
    if (!_imageViewForUser) {
        
        
        _imageViewForUser = [[UIImageView alloc]initWithFrame:CGRectMake(10 + 20, self.imageViewForHeader.height -55 - 55, 45, 45)];
        _imageViewForUser.userInteractionEnabled = YES;
       
        if ([[[NSUserDefaults standardUserDefaults]objectForKey:@"hasSign"] isEqualToString:@"YES"]) {
            
            NSString * imgStr = [[NSUserDefaults standardUserDefaults]objectForKey:kUserInfoKey_protrait];
          
             [_imageViewForUser sd_setImageWithURL:[NSURL URLWithString:imgStr] placeholderImage:[UIImage imageNamed:@"pro"]];
            
            //   _imageViewForUser.image = [[UIImage alloc]initWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imgStr]]];
        }else
        {
            _imageViewForUser.image = [UIImage imageNamed:@"touxiang"];
        }
        
       
        self.imageViewForUser.layer.cornerRadius = self.imageViewForUser.height / 2;
        self.imageViewForUser.layer.masksToBounds = YES;
        UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapImageViewForUserAction:)];
        [_imageViewForUser addGestureRecognizer:tap];
//         [self.imageViewForHeader addSubview:self.imageViewForUser];
    }
    
    return _imageViewForUser;
}

-(void)tapImageViewForUserAction:(UITapGestureRecognizer *)tap
{
    
    self.hasSign = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfoKey_hasSign];
    if ([self.hasSign isEqualToString:@"YES"]) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message: nil preferredStyle:(UIAlertControllerStyleActionSheet)];
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"相册" style:(UIAlertActionStyleCancel) handler:^(UIAlertAction * _Nonnull action) {
            // 调用系统相册
            [self invokePhoto];
            
            
        }];
        UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"相机" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction * action3 = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDestructive) handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alert addAction:action1];
        [alert addAction:action2];
        [alert addAction:action3];
        [kpresent presentViewController:alert animated:YES completion:nil];
    }else{
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"请先登录!" message:nil preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction * action = [UIAlertAction actionWithTitle:@"取消" style:(UIAlertActionStyleDestructive) handler:nil];
        [alert addAction:action];
        UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"去注册" style:(UIAlertActionStyleDefault) handler:^(UIAlertAction * _Nonnull action) {
            JTRegisterViewController * regtVC = [JTRegisterViewController new];
            [kpresent presentViewController:regtVC animated:YES completion:nil];
            
        }];
        [alert addAction:action1];
        [kpresent presentViewController:alert animated:YES completion:nil];
    
        /*
        ZDUIAlert * alert = [[ZDUIAlert alloc]initWithFrame:CGRectMake(0, 0, self.frame.size.width * 0.33, 90)];
        alert.center = CGPointMake(self.center.x, self.frame.size.height / 2);
        
        [self addSubview:alert];
         */
    }
}
-(void)invokePhoto
{
    self.pickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    // 设置代理
    self.pickerController.delegate = self;
    // 允许编辑图片
    self.pickerController.allowsEditing = YES;
    // 设置相册选完照片，是否跳到编辑模式，进行图片的剪辑
    [kpresent presentViewController:self.pickerController animated:YES completion:nil];
}
// pickerCotnroller的代理方法
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage * image= nil;
    // 判断一下我们从哪里获取图片
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        // 修改当前image
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    }else {
        // 可编辑UIImagePickerControllerEditedImage（获取编辑后的图片）
        image = [info objectForKey:UIImagePickerControllerEditedImage];
    }
    NSLog(@"修改前~~~~~~~~~~~~~~~%@",[[NSUserDefaults standardUserDefaults]objectForKey:kUserInfoKey_protrait]);
    // 设置图片
    self.imageViewForUser.image = image;
    NSData * data = UIImageJPEGRepresentation(self.imageViewForUser.image, 1);
    NSURL * url = [NSURL URLWithDataRepresentation:data relativeToURL:nil];
    
    NSString * proaitl = [[NSString alloc]initWithContentsOfURL:url encoding:NSUTF8StringEncoding   error:nil];
    
    [[NSUserDefaults standardUserDefaults]setObject:proaitl forKey:kUserInfoKey_protrait];
    
    
    NSLog(@"修改后~~~~~~~~~~~~~~~%@",[[NSUserDefaults standardUserDefaults]objectForKey:kUserInfoKey_protrait]);
    [kpresent dismissViewControllerAnimated:YES completion:nil];
    
}



#pragma mark label========================================================
// 设置标题label
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.imageViewForUser.x, CGRectGetMaxY(self.imageViewForUser.frame)+10,self.width - self.imageViewForUser.x - (10 + self.imageViewForUser.width) , 25)];
        self.titleLabel.text = @"别让现实挡住了你梦想的去路";
        self.titleLabel.font = [UIFont systemFontOfSize:15];
        self.titleLabel.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        [self.imageViewForHeader addSubview:self.titleLabel];
    }
    
    return _titleLabel;
}

#pragma mark nameButton ========================================================
-(UIButton *)nameButton
{
    if (!_nameButton) {
     
        _nameButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
        
        // 登录状态
        self.hasSign = [[NSUserDefaults standardUserDefaults] objectForKey:kUserInfoKey_hasSign];
        
        _nameButton.frame = CGRectMake(CGRectGetMaxX(_imageViewForUser.frame) + 10, CGRectGetMinY(_imageViewForUser.frame) + 5, _titleLabel.width, _titleLabel.height);
        _nameButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _nameButton.titleLabel.font = [UIFont systemFontOfSize:16];
        if ([self.hasSign isEqualToString:@"YES"])
        {
            
            [_nameButton setTitle:[[NSUserDefaults standardUserDefaults]objectForKey:kUserInfoKey_userAlias] forState:(UIControlStateNormal)];
            
        }else {
          
            [_nameButton setTitle:@"登录/注册" forState:(UIControlStateNormal)];
        }
      
        [_nameButton addTarget:self action:@selector(nameButtonAction) forControlEvents:(UIControlEventTouchUpInside)];
        
        
        //_nameButton.text = @"登录/注册";
        //_nameButton.textColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.866460129310345];
    }
    return _nameButton;
}
-(void)nameButtonAction
{
    if (_delegate && [_delegate respondsToSelector:@selector(clickTitleLabel)]) {
        
        [_delegate clickTitleLabel];
    }
}

#pragma mark 毛玻璃 ========================================================
// 毛玻璃方法
-(void)fuzzyView
{
    // 首先声明一个UIVisualEffectView 的对象
    self.visualEffectView = [[UIVisualEffectView alloc]initWithFrame:self.imageViewForHeader.frame];
    // 设置毛玻璃的效果
    UIBlurEffect * blur = [UIBlurEffect effectWithStyle:1];
    self.visualEffectView.effect = blur;
    // 透明度设置为0，后面会让它的透明度跟着tablkeView的偏移量改变，用来实现渐变模糊的效果
    self.visualEffectView.alpha = 0;
    
    [self insertSubview:self.visualEffectView atIndex:0];

}

@end

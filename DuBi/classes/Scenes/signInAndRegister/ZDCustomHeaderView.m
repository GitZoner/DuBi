//
//  ZDCustomHeaderView.m
//  DuBi
//
//  Created by lanou3g on 16/5/24.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZDCustomHeaderView.h"
#import "UIView+XYWidthHeight.h"
@interface ZDCustomHeaderView ()


@end

@implementation ZDCustomHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self drawView];
    }
    return self;
}

-(void)drawView{
    
    


    [self addSubview:self.bgImgView];
     [self.bgImgView addSubview:self.touXimageView];
    [self.bgImgView addSubview:self.registerOrLoginButton];
}

-(UIButton *)registerOrLoginButton
{
    if (!_registerOrLoginButton) {
        
        self.registerOrLoginButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.width / 5 , 30)];
        [self.registerOrLoginButton addTarget:self action:@selector(registerOrLoginAction) forControlEvents:(UIControlEventTouchUpOutside)];
        [_registerOrLoginButton setTitle:@"登录/注册" forState:(UIControlStateNormal)];
        
        _registerOrLoginButton.center = CGPointMake(self.touXimageView.center.x, self.touXimageView.center.y + 70);
    }
    return _registerOrLoginButton;
}
-(void)registerOrLoginAction
{
    NSLog(@"------------------------------");
}
-(UIImageView *)bgImgView
{
    if (!_bgImgView) {

       
        self.bgImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"tableViewHeader.jpg"]];
         self.bgImgView.userInteractionEnabled = YES;
        self.bgImgView.frame =CGRectMake(0, 0, self.width, self.height);
    }
    return _bgImgView;
}
-(UIImageView *)touXimageView
{
    if (!_touXimageView) {
        
        _touXimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.width / 5, self.width / 5)];
        _touXimageView.userInteractionEnabled = YES;
        _touXimageView.center = self.center;
        _touXimageView.image = [UIImage imageNamed:@"tableViewHeader.jpg"];
        _touXimageView.layer.cornerRadius = self.width / 10;
        _touXimageView.layer.masksToBounds = YES;
    }
    return _touXimageView;
}






@end

//
//  ZDUIAlert.m
//  
//
//  Created by lanou3g on 16/6/1.
//
//

#import "ZDUIAlert.h"

@implementation ZDUIAlert

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
     
        [self drawView];
    }
    return self;
}

// 绘图
-(void)drawView
{
    // 添加背景视图
    UIView * bgView = [[UIView alloc]initWithFrame:self.bounds];
    bgView.backgroundColor = [UIColor whiteColor];
    bgView.layer.cornerRadius = 10;
    [self addSubview:bgView];
    
    // 标题栏
    UILabel * topLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, bgView.frame.size.width, 30)];
    topLabel.layer.cornerRadius = 10;
    topLabel.backgroundColor = [UIColor colorWithRed:0.1287 green:0.1567 blue:0.1794 alpha:1.0];
    topLabel.text = @"去注册";
    topLabel.font = [UIFont systemFontOfSize: 13];
    topLabel.textAlignment = NSTextAlignmentCenter;
    topLabel.textColor = [UIColor whiteColor];
    [bgView addSubview:topLabel];
    
    // 取消按钮
    UIButton * backbutton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backbutton.layer.cornerRadius = 10;
    backbutton.frame = CGRectMake(0, bgView.frame.size.height - 30, (bgView.frame.size.width - 3) * 0.5, 30);
    [backbutton setTitle:@"取消" forState:(UIControlStateNormal)];
    [backbutton setTitleColor:[UIColor colorWithRed:246 /255.0 green:144 / 255.0 blue:58 / 255.0 alpha:1] forState:(UIControlStateNormal)];
    [backbutton setTitleColor:[UIColor colorWithRed:0.1287 green:0.1567 blue:0.1794 alpha:1.0] forState:(UIControlStateHighlighted)];
    [backbutton setBackgroundColor:[UIColor whiteColor]];
    [backbutton addTarget:self action:@selector(backAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [bgView addSubview:backbutton];
    // 确定按钮
    UIButton * OKbutton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    OKbutton.layer.cornerRadius = 10;
    OKbutton.frame = CGRectMake(bgView.frame.size.width / 2 + 1, bgView.frame.size.height - 30,(bgView.frame.size.width - 3) * 0.5 , 30);
    [OKbutton setTitle:@"好的" forState:(UIControlStateNormal)];
    [OKbutton setTitleColor:[UIColor colorWithRed:246 /255.0 green:144 / 255.0 blue:58 / 255.0 alpha:1] forState:(UIControlStateNormal)];
    [OKbutton setTitleColor:[UIColor colorWithRed:0.1287 green:0.1567 blue:0.1794 alpha:1.0] forState:(UIControlStateHighlighted)];
    [OKbutton setBackgroundColor:[UIColor whiteColor]];
    [OKbutton addTarget:self action:@selector(OkAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [bgView addSubview:OKbutton];
    
    // 上下分隔线
    UIView * topHr = [[UIView alloc]initWithFrame:CGRectMake(0, bgView.frame.size.height - 31, self.frame.size.width, 1)];
    topHr.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.705172413793103];
    [bgView addSubview:topHr];
    
    // 左右分隔线
    UIView * leftRightHr = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 1, OKbutton.frame.size.height - 4)];
    leftRightHr.center = CGPointMake(backbutton.center.x + backbutton.frame.size.width / 2 + 1, backbutton.center.y);
    leftRightHr.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:0.705172413793103];
    [bgView addSubview:leftRightHr];
    
}
-(void)backAction:(UIButton *)button
{
    [self removeFromSuperview];
}

-(void)OkAction:(UIButton *)button
{
    
}
@end


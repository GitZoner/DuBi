//
//  ZDPublishHaflView.m
//  DuBi
//
//  Created by lanou3g on 16/5/26.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZDPublishHaflView.h"
#import "ZDCustomButton.h"
#import "UIView+XYWidthHeight.h"
#import "JTTabBar.h"

@interface ZDPublishHaflView ()

@end

@implementation ZDPublishHaflView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
     
        [self  drawView];
    }
    return self;
}

-(void)drawView{

    
    UIImageView * imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"shareBottomBackground"]];
    imageView.frame = [UIScreen mainScreen].bounds;
    imageView.userInteractionEnabled = YES;
    // [self insertSubview:imageView atIndex:0];
       [self addSubview:imageView];
    
    NSArray * images = @[@"publish-text",@"publish-picture"];
    NSArray * texts = @[@"发段子",@"发图片"];
    CGFloat buttonW = 72;
    CGFloat buttonH = 72 + 30;
    CGFloat buttonY = self.frame.size.height / 4;
    CGFloat buttonX =( [UIScreen mainScreen].bounds.size.width - buttonW * 2) / 3;
    // button之间的距离
    // CGFloat xMargin = self.width - buttonW * 2  - 2 * buttonX;
    for (int i = 0 ; i < texts.count; i++) {
        ZDCustomButton * button = [[ZDCustomButton alloc]init];
        [imageView addSubview:button];
        
        [button setTitle:texts[i] forState:(UIControlStateNormal)];
        [button setTitleColor:[UIColor blackColor] forState:(UIControlStateNormal)];
       
        button.titleLabel.font = [UIFont systemFontOfSize:15];
        button.titleLabel.textColor = [UIColor blackColor];
        
        [button setTintColor:[UIColor colorWithRed:0.496 green:0.496 blue:0.496 alpha:1.0]];
        button.imageView.image =[UIImage imageNamed:images[i]];
        button.frame = CGRectMake(buttonX + (i * buttonW) + i * buttonX,buttonY,buttonW, buttonH);
    }

    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(self.width /2 - 15, self.height - 30, 30, 30)];
    [button setTitle:@"x" forState:(UIControlStateNormal)];
    button.titleLabel.font = [UIFont systemFontOfSize:30];
    [button setTitleColor:[UIColor redColor] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:(UIControlEventTouchUpInside)];
    [imageView addSubview:button];

}
-(void)buttonAction
{
    JTTabBar * bar = [JTTabBar new];
    bar.window.hidden = YES;
    // window.hidden = YES;
}


@end

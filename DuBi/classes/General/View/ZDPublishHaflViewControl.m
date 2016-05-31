//
//  ZDPublishHaflViewControl.m
//  DuBi
//
//  Created by lanou3g on 16/5/30.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZDPublishHaflViewControl.h"
#import "ZDPublishHaflView.h"
#import "UIView+XYWidthHeight.h"

@interface ZDPublishHaflViewControl ()

@property(strong,nonatomic)ZDPublishHaflView * publishView;


@end

@implementation ZDPublishHaflViewControl

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor redColor];
    [self creatView];
}

-(void)creatView
{
    ZDPublishHaflView * publishView = [[ZDPublishHaflView alloc]initWithFrame:CGRectMake(0, self.view.height / 3 * 2, self.view.width, self.view.height / 3)];
    [self.view addSubview:publishView];
}
-(void)presetController{
    
    [self.publishView.button addTarget:self action:@selector(buttonAction:) forControlEvents:(UIControlEventTouchUpInside)];
}

-(void)buttonAction:(UIButton *)button
{
    if (button.tag == 101) {
        
}
}

@end

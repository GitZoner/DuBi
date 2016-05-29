//
//  JTSelectTopView.m
//  DuBi
//
//  Created by Jason on 16/5/29.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "JTSelectTopView.h"
#import "UIView+XYWidthHeight.h"
@interface JTSelectTopView ()


@end

@implementation JTSelectTopView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSubViews ];
    }
    return self;
}


-(void)setSubViews  {
    self.imageView = [UIImageView new];
    self.imageView.image  =[UIImage imageNamed:@"head_tab_btn1"];
    self.imageView.userInteractionEnabled = YES;
    self.imageView.frame = self.bounds;
    [self addSubview:self.imageView];
    
    // self.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"head_tab_btn1副本"]];
    self.button1  =[[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.width / 3, self.height)];
    self.button1.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.button1 setTitle:@"图文" forState:(UIControlStateNormal)];
    [self.button1 addTarget:self action:@selector(ButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    self.button1.tag = 201;
    [self addSubview:self.button1];
    
    self.button2  =[[UIButton alloc] initWithFrame:CGRectMake(self.width / 3, 0, self.width / 3 , self.height)];
    [self.button2 setTitle:@"纯文字" forState:(UIControlStateNormal)];
    [self.button2 setTitleColor:[UIColor colorWithRed:0.1062 green:0.6261 blue:0.5489 alpha:1.0] forState:(UIControlStateNormal)];
    [self.button2 addTarget:self action:@selector(ButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.button2.titleLabel.font = [UIFont systemFontOfSize:13];
    self.button2.tag = 202;
    [self addSubview:self.button2];
    
    self.button3  =[[UIButton alloc] initWithFrame:CGRectMake(self.width / 3 * 2, 0, self.width / 3, self.height)];
    [self.button3 setTitle:@"纯图片" forState:(UIControlStateNormal)];
    [self.button3 addTarget:self action:@selector(ButtonAction:) forControlEvents:(UIControlEventTouchUpInside)];
    [self.button3 setTitleColor:[UIColor colorWithRed:0.1062 green:0.6261 blue:0.5489 alpha:1.0] forState:(UIControlStateNormal)];
    self.button3.titleLabel.font = [UIFont systemFontOfSize:13];
    self.button3.tag = 203;
    
    [self addSubview:self.button3];
    
    
}


-(void)ButtonAction:(UIButton *)button {
    if (button.tag == 201) {
        [self.button1 setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [self.button2 setTitleColor:[UIColor colorWithRed:0.1062 green:0.6261 blue:0.5489 alpha:1.0] forState:(UIControlStateNormal)];
        [self.button3 setTitleColor:[UIColor colorWithRed:0.1062 green:0.6261 blue:0.5489 alpha:1.0] forState:(UIControlStateNormal)];
        self.imageView.image = [UIImage imageNamed:@"head_tab_btn1"];
    }else if (button.tag == 202) {
        [self.button1 setTitleColor:[UIColor colorWithRed:0.1062 green:0.6261 blue:0.5489 alpha:1.0] forState:(UIControlStateNormal)];
        [self.button2 setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        [self.button3 setTitleColor:[UIColor colorWithRed:0.1062 green:0.6261 blue:0.5489 alpha:1.0] forState:(UIControlStateNormal)];
        self.imageView.image = [UIImage imageNamed:@"head_tab_btn2"];
    }else {
        [self.button1 setTitleColor:[UIColor colorWithRed:0.1062 green:0.6261 blue:0.5489 alpha:1.0] forState:(UIControlStateNormal)];
        [self.button2 setTitleColor:[UIColor colorWithRed:0.1062 green:0.6261 blue:0.5489 alpha:1.0] forState:(UIControlStateNormal)];
        [self.button3 setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
        self.imageView.image = [UIImage imageNamed:@"head_tab_btn3"];
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(clickButtonAction:)]) {
        [_delegate clickButtonAction:button];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

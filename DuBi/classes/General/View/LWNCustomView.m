//
//  LWNCustomView.m
//  DuBi
//
//  Created by lanou3g on 16/5/23.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "LWNCustomView.h"
#import "LWNCustomButton.h"
@interface LWNCustomView ()
@property(strong,nonatomic)LWNCustomButton *button1;
@property(strong,nonatomic)LWNCustomButton *button2;
@property(strong,nonatomic)LWNCustomButton *button3;

@end
@implementation LWNCustomView
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.button1 = [LWNCustomButton createCustomButton];
        self.button2 = [LWNCustomButton createCustomButton];
        self.button3 = [LWNCustomButton createCustomButton];
        [self addSubview:_button1];
        [self addSubview:_button2];
        [self addSubview:_button3];
    }
    return self;
}
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat width = self.frame.size.width / 4;
    CGFloat height = self.frame.size.height;
    self.button1.frame = CGRectMake(2 + width * 0, 2, width, height);
    self.button1.frame = CGRectMake(2 + width * 2, 2, width, height);
    self.button1.frame = CGRectMake(2 + width * 3, 2, width, height);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

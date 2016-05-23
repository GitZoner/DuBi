//
//  LWNCustomButton.m
//  DuBi
//
//  Created by lanou3g on 16/5/23.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "LWNCustomButton.h"

@implementation LWNCustomButton
// 初始化
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
    }
    return self;
}
// 类方法创建自定义的button
+(instancetype)createCustomButton{
    LWNCustomButton *button = [LWNCustomButton new];
   // [button setImage:[UIImage imageNamed:imageName] forState:(UIControlStateNormal)];
   // [button setImage:[UIImage imageNamed:clickName] forState:(UIControlStateHighlighted)];
 
    return button;
}
// 重新布局button,左边imageView,右边titleLabel。
-(void)layoutSubviews{
    [super layoutSubviews];
    CGFloat imgView = self.bounds.size.width * 0.5;
    self.imageView.bounds = CGRectMake(2, 2, imgView, self.bounds.size.height - 4);
    self.titleLabel.bounds = CGRectMake(imgView + 4, 2,imgView - 2, self.bounds.size.height - 4);
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

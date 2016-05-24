//
//  ZYButton.m
//  DuBi
//
//  Created by lanou3g on 16/5/23.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZYButton.h"
#import "UIView+XYWidthHeight.h"
@implementation ZYButton

//-(instancetype)initWithFrame:(CGRect)frame
//{
//    if (self = [super initWithFrame:frame]) {
//        
//        [self setUp];
//    }
//    return self;
//}

+(instancetype)creatWithButton
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
    
}

-(void)awakeFromNib
{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}


-(void)layoutSubviews
{
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width / 5 * 3;
    self.imageView.height = self.height;
    
    self.titleLabel.x = self.imageView.width;
    self.titleLabel.y = 0;
    self.titleLabel.width = self.width - self.imageView.width;
    self.titleLabel.height = self.height;
}


//// 初始化button的大小
//- (instancetype)initWithFrame:(CGRect)frame {
//    
//    if (self = [super initWithFrame:frame]) {
//        
//        self.titleLabel.textAlignment = NSTextAlignmentCenter;
//        self.frame = CGRectMake(0, 0, 93.5, 30);
//    }
//    
//    return self;
//}
//// 重新布局button上的内容
//- (void)layoutSubviews {
//    
//    [super layoutSubviews];
//    // 设置图片的大小
//    CGFloat imageViewWidth = self.bounds.size.width * 1 / 3;
//    CGFloat imageViewHeight = self.bounds.size.height;
//    // 设置titleLabel的高度
//    CGFloat labelWidth = self.bounds.size.width * 2 / 3;
//    CGFloat labelHeight = self.bounds.size.height;
//    // 间距大小
//    CGFloat veticalMargin = 0;
//    // 设置imageView
//    

//    
//}
//UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(50, 100, 300, 300)];
////设置文字
//[button setTitle:@"测试" forState:UIControlStateNormal];
//[button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//button.titleLabel.font = [UIFont systemFontOfSize:25];
////为了有所区分，设置按钮背景颜色为黑色
//button.backgroundColor = [UIColor blackColor];
////设置图片
//[button setImage:[UIImage imageNamed:@"联系人"] forState:UIControlStateNormal];
//[self.view addSubview:button];




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

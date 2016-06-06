//
//  ZDVisitingIdView.m
//  DuBi
//
//  Created by lanou3g on 16/6/5.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZDVisitingIdView.h"

@interface ZDVisitingIdView ()


@end

@implementation ZDVisitingIdView

-(instancetype)initWithFrame:(CGRect)frame imageView:(UIImage *)protrait lable:(NSString *)alias
{
    if (self = [super initWithFrame: frame]) {
     
        [self drawView:protrait label:alias];
    }
    return self;
}




// 绘图
-(void)drawView:(UIImage *)protrait label:(NSString *)alias{
    
    [self addSubview:self.protrait];
    self.protrait.image = protrait;
    
    [self addSubview:self.alias];
    self.alias.text = alias;
}


#pragma mark  -  getter
// 头像
-(UIImageView *)protrait
{
    if (!_protrait) {
     
        _protrait = [[UIImageView alloc ]initWithFrame:CGRectMake(0, 0, 70, 70)];
        _protrait.center = CGPointMake(self.frame.size.width / 2,self.frame.size.height -60 - (_protrait.frame.size.height / 2));
    }
    return _protrait;
}

// 别名
-(UILabel *)alias
{
    if (_alias) {
     
        _alias = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 70, 30)];
        _alias.center = CGPointMake(_protrait.center.x, _protrait.center.y + (_protrait.frame.size.height / 2) + 20 + (_alias.frame.size.height / 2));
    }
    return _alias;
}










@end

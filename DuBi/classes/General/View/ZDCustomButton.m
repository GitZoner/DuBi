//
//  ZDCustomButton.m
//  DuBi
//
//  Created by lanou3g on 16/5/21.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZDCustomButton.h"
#import "UIView+XYWidthHeight.h"


@implementation ZDCustomButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setup];
    }
    return self;
}

-(void)awakeFromNib
{
    [self setup];
}


-(void)setup{
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
}

-(void)layoutSubviews
{
    self.imageView.x = 0;
    self.imageView.y = 0;
    self.imageView.width = self.width;
    self.imageView.height = self.width;
//    self.imageView.layer.cornerRadius = self.imageView.height / 2;
//    self.imageView.layer.masksToBounds = YES;
    
    self.titleLabel.width = self.width;
    self.titleLabel.height = self.height - self.width;
    self.titleLabel.x = 0;
    self.titleLabel.y = self.width - self.titleLabel.height;
    self.titleLabel.font = [UIFont systemFontOfSize:12];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    
    
}

@end

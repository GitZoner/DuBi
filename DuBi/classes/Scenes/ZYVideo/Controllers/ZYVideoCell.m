//
//  ZYVideoCell.m
//  DuBi
//
//  Created by lanou3g on 16/5/23.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZYVideoCell.h"
#import "ZYButton.h"
#import "UIView+XYWidthHeight.h"
@implementation ZYVideoCell

- (void)awakeFromNib {
    ZYButton * button = [[ZYButton alloc]initWithFrame:CGRectMake(0, self.height - 30, 100, 30)];
    [self.contentView addSubview:button];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  JTCircleHeaderView.m
//  DuBi
//
//  Created by Jason on 16/5/29.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "JTCircleHeaderView.h"
#import <Masonry.h>
#import "UIView+XYWidthHeight.h"
@implementation JTCircleHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setSubViews];
    }
    return self;
}

-(void)setSubViews{
    
    
    self.backImageView = [UIImageView new];
    self.backImageView.frame  = self.frame;
    self.backImageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"backPicture%d.jpg",arc4random() % 6]];
    self.backImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self addSubview:self.backImageView];

    self.midView = [[UIView alloc] initWithFrame:self.frame];
    self.midView.backgroundColor = [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.657839439655172];
    [self addSubview:self.midView];
    
    __weak typeof (JTCircleHeaderView *) headView = self;
    
    self.attentionLabel = [UILabel new];
    self.attentionLabel.text = @"000";
    self.attentionLabel.textColor = [UIColor whiteColor];
    [self.midView addSubview:self.attentionCountLabel];
    
    [self.attentionCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(headView.midView.mas_bottom).offset(-10);
        make.left.equalTo(headView.midView.mas_left).offset(headView.width / 8);
        make.width.equalTo(headView.midView.mas_width).multipliedBy(0.125);
        make.height.mas_equalTo(20);
        
    }];
    
    
}
@end

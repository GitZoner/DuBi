//
//  ZYVideoCell.m
//  DuBi
//
//  Created by lanou3g on 16/5/23.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZYVideoCell.h"
#import "ZYButton.h"

@implementation ZYVideoCell


- (void)layoutSubviews {
    
 _button = [ZYButton creatWithButton:_button Title:@"0000" image:@"like_C" selectImage:@"like_H" target:self action:@selector(likeAction:) frame:CGRectMake(20, CGRectGetMaxY(self.videoView.frame) + 15, 70, 30)];
    
//    [_button creatWithButtTitle:@"0000" image:@"like_C" selectImage:@"like_H" target:self action:@selector(likeAction:) frame:CGRectMake(20, CGRectGetMaxY(self.videoView.frame) + 15, 70, 30)];
//    [_button creatWithTitle:@"0000" image:@"hate_C" selectImage:@"hate_H" target:self action:@selector(likeAction:) frame:CGRectMake(90 +56.3, CGRectGetMaxY(self.videoView.frame) + 15, 70, 30)];
//    [_button creatWithTitle:@"0000" image:@"share" selectImage:nil target:self action:@selector(likeAction:) frame:CGRectMake(90 +56.3 +70 + 56.3, CGRectGetMaxY(self.videoView.frame) + 15, 70, 30)];
//    [_button creatWithTitle:@"0000" image:@"comment" selectImage:nil target:self action:@selector(likeAction:) frame:CGRectMake(90 + 70 +56.3 + 56.3+70, CGRectGetMaxY(self.videoView.frame) + 15, 70, 30)];
//
    [self.contentView addSubview:_button];
    
    
    
}


- (void)likeAction:(UIButton *)button{
    
    
    NSLog(@"ewfhiuerhf");
    
}
-(void)awakeFromNib {
    
 
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

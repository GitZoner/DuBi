//
//  ZDCustomUserTableViewCell.m
//  DuBi
//
//  Created by lanou3g on 16/5/24.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "ZDCustomUserTableViewCell.h"
#import "UIView+XYWidthHeight.h"

@implementation ZDCustomUserTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 画cell
        [self drawView];
    }
    
    return self;
}
-(void)drawView
{
//    self.contentlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.contentView.width, self.contentView.height)];
    [self.contentView addSubview:self.bgImgView];
    [self.bgImgView addSubview:self.contentlabel];
    [self.bgImgView addSubview:self.tuBImg];
//    

   
}

#pragma mark --- setter getter 方法
-(UIImageView *)bgImgView
{
    if (!_bgImgView) {
     
        _bgImgView = [[UIImageView alloc]initWithFrame:CGRectMake(16, 0, self.contentView.width, self.contentView.height)];
    }
    return _bgImgView;
}

-(UIImageView *)tuBImg
{
    if (!_tuBImg) {
     
        _tuBImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 16, 16)];
        _tuBImg.center = CGPointMake(0, self.contentlabel.center.y);
    }
    return _tuBImg;
}

-(UILabel *)contentlabel
{
    if (!_contentlabel) {
        
        _contentlabel = [[UILabel alloc]initWithFrame:CGRectMake(self.tuBImg.width + 10, 0, self.bgImgView.width - 20, self.bgImgView.height)];
        _contentlabel.backgroundColor = [UIColor clearColor];
        _contentlabel.textColor = [UIColor colorWithRed:0.5181 green:0.5227 blue:0.5134 alpha:1.0];
        _contentlabel.font = [UIFont systemFontOfSize:15];
    }
    return _contentlabel;
}


// 重写frame的setter方法
-(void)setFrame:(CGRect)frame
{
   // frame.origin.x = 5;
   // frame.size.width -= 10;
    frame.size.height -= 2;
    
    [super setFrame:frame];
    
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

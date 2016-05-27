//
//  ZDCustomUserTableViewCell.h
//  DuBi
//
//  Created by lanou3g on 16/5/24.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDCustomUserTableViewCell : UITableViewCell

@property(strong,nonatomic)UILabel * contentlabel;

// 背景图片
@property(strong,nonatomic)UIImageView * bgImgView;

// 图标
@property(strong,nonatomic)UIImageView * tuBImg;
@end

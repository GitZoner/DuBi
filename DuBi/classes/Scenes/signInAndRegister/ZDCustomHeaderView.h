//
//  ZDCustomHeaderView.h
//  DuBi
//
//  Created by lanou3g on 16/5/24.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDCustomHeaderView : UIView
// 背景图片
@property(strong,nonatomic)UIImageView * bgImgView;
// 用户头像
@property(strong,nonatomic)UIImageView * touXimageView;
// 用户名
@property (strong,nonatomic)UILabel *userNameLabel;
@end

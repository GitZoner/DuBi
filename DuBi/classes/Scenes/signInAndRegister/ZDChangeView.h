//
//  ZDChangeView.h
//  DuBi
//
//  Created by lanou3g on 16/5/29.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDChangeView : UIView

// 背景 大图
@property(strong,nonatomic)UIImageView * imageViewForHeader;

// 头像
@property(strong,nonatomic)UIImageView * imageViewForUser;

// 标题的文字

@property(strong,nonatomic)UILabel * titleLabel;

// 毛玻璃
@property(strong,nonatomic)UIVisualEffectView * visualEffectView;

// 昵称
@property(strong,nonatomic)UIButton * nameButton;

@end

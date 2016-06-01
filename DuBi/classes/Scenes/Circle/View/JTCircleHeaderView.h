//
//  JTCircleHeaderView.h
//  DuBi
//
//  Created by Jason on 16/5/29.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JTCircleHeaderView : UIView

@property (strong,nonatomic)UIImageView *backImageView; // 背景图片
@property (strong,nonatomic)UIView *midView ;// 半透明层
@property (strong,nonatomic)UIImageView *protraitImageView; // 用户头像
@property (strong,nonatomic)UILabel *attentionLabel;
@property (strong,nonatomic)UILabel *attentionCountLabel;

@property (strong,nonatomic)UILabel *fanLabel;
@property (strong,nonatomic)UILabel *fanCountLabel;

@property (strong,nonatomic)UILabel *visitorLabel;
@property (strong,nonatomic)UIImageView *visitorImageView;

@property (strong,nonatomic)UILabel *noticeLabel;
@property (strong,nonatomic)UIImageView *noticeImageView;



@end

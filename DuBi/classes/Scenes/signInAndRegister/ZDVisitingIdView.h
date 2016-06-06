//
//  ZDVisitingIdView.h
//  DuBi
//
//  Created by lanou3g on 16/6/5.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDVisitingIdView : UIView

//  头像
@property(strong,nonatomic) UIImageView * protrait;

//  别名
@property(strong,nonatomic) UILabel * alias;


-(instancetype)initWithFrame:(CGRect)frame imageView :(UIImage * )protrait lable :(NSString *)alias;

@end

//
//  JTSelectTopView.h
//  DuBi
//
//  Created by Jason on 16/5/29.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JTSelectTopViewDelegate <NSObject>

@optional
-(void)clickButtonAction:(UIButton *)button;

@end
@interface JTSelectTopView : UIView
@property (weak,nonatomic)id<JTSelectTopViewDelegate> delegate;
@property (strong,nonatomic)UIImageView *imageView;
@property (strong,nonatomic)UIButton *button1;
@property (strong,nonatomic)UIButton *button2;
@property (strong,nonatomic)UIButton *button3;
@end

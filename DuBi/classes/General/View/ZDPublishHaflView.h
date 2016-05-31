//
//  ZDPublishHaflView.h
//  DuBi
//
//  Created by lanou3g on 16/5/26.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZDPublishHaflViewDelegate <NSObject>

-(void)hidderWindow;

@end


@interface ZDPublishHaflView : UIView
@property(strong,nonatomic)UIButton * button;

@property(weak,nonatomic)id<ZDPublishHaflViewDelegate>myDelegate;
@end

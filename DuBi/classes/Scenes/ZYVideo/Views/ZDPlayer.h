//
//  ZDPlayer.h
//  DuBi
//
//  Created by lanou3g on 16/5/27.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZDPlayer : UIView

-(instancetype)initWithFrame:(CGRect)frame vedioUrl:(NSString *)vedioStr;
-(void)stater;
-(void)pasue;

@end

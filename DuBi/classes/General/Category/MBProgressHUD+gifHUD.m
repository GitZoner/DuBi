//
//  MBProgressHUD+gifHUD.m
//  DouBanProject
//
//  Created by lanou3g on 16/5/10.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import "MBProgressHUD+gifHUD.h"
#import <SDWebImage/UIImage+GIF.h>
#include "Color_marco.h"
@implementation MBProgressHUD (gifHUD)
+(void)setUpHUDWithFrame:(CGRect)frame gifName:(NSString *)gifName andShowToView:(UIView *)view{
    UIImage *image = [UIImage sd_animatedGIFNamed:gifName];
    UIImageView *gifImgView = [[UIImageView alloc]initWithFrame:frame];
    gifImgView.image = image;
   MBProgressHUD *hud = [self showHUDAddedTo:view animated:YES];
    hud.color = kColor(190, 123, 255, 0.5);
    hud.mode = MBProgressHUDModeCustomView;
    hud.labelText = @"皮卡丘玩命儿加载中";
    hud.customView = gifImgView;


}
@end

//
//  MBProgressHUD+gifHUD.h
//  DouBanProject
//
//  Created by lanou3g on 16/5/10.
//  Copyright © 2016年 lanou3g. All rights reserved.
//

#import <MBProgressHUD/MBProgressHUD.h>

@interface MBProgressHUD (gifHUD)
/**
 *  加载GIF动画的Hud功能
 *
 *  @param frame   hud图片的大小
 *  @param gifName gif图片的名字
 *  @param view    hud显示在哪个view上
 */
+(void)setUpHUDWithFrame:(CGRect)frame gifName:(NSString *)gifName andShowToView:(UIView *)view;
@end

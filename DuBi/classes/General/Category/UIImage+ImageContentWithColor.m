//
//  UIImage+ImageContentWithColor.m
//  DouBanProject
//
//  Created by lanou3g on 16/5/6.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "UIImage+ImageContentWithColor.h"
#import "RootViewController.h"
@implementation UIImage (ImageContentWithColor)
/**
 *  给定一个颜色，和一个尺寸生成相应颜色的纯色图片
 *
 *  @param color     需要生成的颜色
 *  @param imageRect 图片的大小（像素）
 *
 *  @return 生成的图片（UIImage）
 */

+(UIImage *)imageWithColor:(UIColor *)color imageSize:(CGRect)imageRect{
  
    // 绘制图片
    UIGraphicsBeginImageContextWithOptions(imageRect.size, NO, 0);
    // 填充图片
    // 设置填充色
    [color setFill];
    // 对Rect 进行填充
    UIRectFill(imageRect);
    UIImage *image =  UIGraphicsGetImageFromCurrentImageContext();
    // 结束绘制
    UIGraphicsEndImageContext();
    return image;
    
    


    
}
@end

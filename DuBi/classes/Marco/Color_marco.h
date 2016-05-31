//
//  Color_marco.h
//  DouBanProject
//
//  Created by lanou3g on 16/5/6.
//  Copyright © 2016年 Jason. All rights reserved.
//

#ifndef Color_marco_h
#define Color_marco_h

// 设置颜色
#define kCOLOR(r,g,b,a) [UIColor colorWithRed:(r)/ 255.0 green:(g)/ 255.0 blue:(b)/ 255.0 alpha:a]
// 随机颜色
#define kRANDOM_COLOR JT_COLOR(arc4random_uniform(255),arc4random_uniform(255),arc4random_uniform(255),1.0)

// 主题颜色
#define THEME_COLOR [UIColor whiteColor]

// 主体黄
#define tYellowColor [UIColor colorWithRed:0.9712 green:0.7187 blue:0.0345 alpha:1.0]
// 主体绿
#define tGreenColor [UIColor colorWithRed:0.0879 green:0.6911 blue:0.5427 alpha:1.0]
#endif /* Color_marco_h */

//
//  LWNCustomButton.h
//  DuBi
//
//  Created by lanou3g on 16/5/23.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWNCustomButton : UIButton

// 初始化
-(instancetype)initWithFrame:(CGRect)frame;
// 类方法创建自定义的button
/**
 *  创建button的方法
 *
 *  @param imageName 未点击的图片的名字
 *  @param clickName 点击后图片的名字
 *
 *  @return 返回一个自定好的的button
 */
+(instancetype)createCustomButton;
@end

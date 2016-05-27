//
//  ZYButton.h
//  DuBi
//
//  Created by lanou3g on 16/5/23.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZYButton : UIButton

+ (instancetype)creatWithButton:(UIButton *)button Title:(NSString *)title image:(NSString *)image selectImage:(NSString *)selectImage target:(id)target action:(SEL)action frame:(CGRect)frame;

@end

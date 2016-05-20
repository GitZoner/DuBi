//
//  UIView+XYWidthHeight.h
//  Bester
//
//  Created by lanou3g on 16/5/16.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (XYWidthHeight)
@property (assign,nonatomic)CGFloat x;
@property (assign,nonatomic)CGFloat y;
@property (assign,nonatomic)CGFloat width;
@property (assign,nonatomic)CGFloat height;

@property(assign,nonatomic)CGFloat centerX;
@property(assign,nonatomic)CGFloat centerY;

// 在类目中@property,只会生成方法的声明，而不会生成方法的实现和带有_下划线的成员变量，声明属性的 setter 和 getter 方法，需要自己书写
@end

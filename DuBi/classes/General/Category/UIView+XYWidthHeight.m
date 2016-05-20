//
//  UIView+XYWidthHeight.m
//  Bester
//
//  Created by lanou3g on 16/5/16.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import "UIView+XYWidthHeight.h"

@implementation UIView (XYWidthHeight)

// width的 setter 和 getter 方法
-(void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

-(CGFloat)width {
    return self.frame.size.width;
}

// height的 setter 和 getter 方法
-(void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

-(CGFloat)height {
    return self.frame.size.height;
}
// x 的 setter 和 getter 方法
-(void)setX:(CGFloat)x {
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
    
}

-(CGFloat)x {
    return self.frame.origin.x;
}

// y 的 setter 和 getter 方法
-(void)setY:(CGFloat)y {
    CGRect frme = self.frame;
    frme.origin.y = y;
    self.frame = frme;
}

-(CGFloat)y {
    return self.frame.origin.y;
}


// 中心店x,y的setter getter 方法
-(void)setCenterX:(CGPoint)centerX
{
    CGPoint point;
}












@end

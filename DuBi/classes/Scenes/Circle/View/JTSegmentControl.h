//
//  JTSegmentControl.h
//  DuBi
//
//  Created by Jason on 16/5/30.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Main_marco.h"
#import "Color_marco.h"

@class JTSegmentControl;
@protocol JTSegmentControlDelegate <NSObject>
-(void)segment:(JTSegmentControl *)segment didSelectColumnIndex:(NSUInteger)index;
@end

@interface JTSegmentControl : UIView


@property (weak,nonatomic)id<JTSegmentControlDelegate> delegate; // 选择器的代理对象

-(instancetype)initWithFrame:(CGRect)frame normalColor:(UIColor *)normalColor selectColor:(UIColor *)selectColor titles:(NSArray *)titleArray SegmentSize:(CGSize)segmentSize ItemSize:(CGSize)itemSize titleFont:(UIFont *)font;
@end

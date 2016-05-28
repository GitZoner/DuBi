//
//  LWNImgView.h
//  DuBi
//
//  Created by lanou3g on 16/5/25.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Picture.h"
@interface LWNImgView : UIView
@property(strong,nonatomic)Picture *picture;
+ (instancetype)imgView;
@end

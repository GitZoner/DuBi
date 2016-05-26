//
//  JTTabBar.h
//  Bester
//
//  Created by lanou3g on 16/5/16.
//  Copyright © 2016年 Jason. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JTTaBarDelegate <NSObject>

/**
 *  模态出一个控制器
 */
-(void)presentView;

@end

@interface JTTabBar : UITabBar

@property(weak,nonatomic)id<JTTaBarDelegate>wodeDelegate;
@end

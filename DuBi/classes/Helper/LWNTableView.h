//
//  LWNTableView.h
//  DuBi
//
//  Created by lanou3g on 16/5/27.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LWNTableView : UITableView
-(instancetype)initWithFrame:(CGRect)frame withUrl:(NSString *)string;
@property(strong,nonatomic)NSMutableArray *array;
@end

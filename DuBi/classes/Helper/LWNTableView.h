//
//  LWNTableView.h
//  DuBi
//
//  Created by lanou3g on 16/5/27.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Picture.h"
@interface LWNTableView : UITableView
@property(strong,nonatomic)NSMutableArray *dataArray;


/**
 *  初始化并请求数据
 *
 *  @param frame  大小
 *  @param string URL
 *
 *  @return self
 */
//-(instancetype)initWithFrame:(CGRect)frame;
-(void)getDataWithString:(NSString *)urlString;
-(NSInteger)numberOfRows:(NSInteger)section;
-(Picture *)piturForRowInSection:(NSIndexPath*)indexPath;
//+(NSMutableArray *)arrayWithURL:(NSString *)string;

@end

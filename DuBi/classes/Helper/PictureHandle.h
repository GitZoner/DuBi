//
//  PictureHandle.h
//  DuBi
//
//  Created by lanou3g on 16/5/24.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Picture.h"
#import "Singleton.h"
#import "NetWorkRequest.h"
typedef void(^PictureHandleBlock)(NSMutableArray *array);
@interface PictureHandle : NSObject
@property(strong,nonatomic)PictureHandleBlock comptionBlock;
// 数据请求解析
-(void)getDataWithString:(NSString *)urlString comptionBlock:(PictureHandleBlock )comptionBlock;
// 返回分区个数
-(NSInteger)numberOfSections;
// 返回cell的个数
-(NSInteger)numofRowsAtSection:(NSInteger)section;

// 返回具体某个对象
-(Picture *)pictureForCellAtIndexPath:(NSIndexPath *)indexPath;



singleton_interface(PictureHandle);

@end

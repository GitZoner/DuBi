//
//  ZYGetObject.h
//  DuBi
//
//  Created by lanou3g on 16/6/3.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZYGetObject : NSObject
- (NSArray *)userDeliverInfoWithClassName:(NSString *)name;
+ (instancetype)sharedZYGetObject;
@end

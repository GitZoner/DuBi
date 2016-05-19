//
//  Singleton.h
//  DuBi
//
//  Created by lanou3g on 16/5/19.
//  Copyright © 2016年 JasonTian. All rights reserved.
//
#ifndef Singleton_h
#define Singleton_h

// 单例的声明
#define singleton_interface(classsName)\
+(instancetype)shared##classsName



// 单例的实现
#define singleton_implementation(classsName)\
static classsName *manager;\
+(instancetype)shared##classsName{\
static dispatch_once_t onceToken;\
dispatch_once(&onceToken, ^{\
manager = [[[self class]alloc]init];\
});\
return manager;\
}

#endif /* Singleton_h */

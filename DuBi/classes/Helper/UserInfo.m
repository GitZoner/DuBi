//
//  UserInfo.m
//  DuBi
//
//  Created by Jason on 16/5/27.
//  Copyright © 2016年 JasonTian. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

-(instancetype)initWithTelNum:(NSString *)telNum passWord:(NSString *)passWord userAlias:(NSString *)userAlias protrait:(NSString *)protrait gender:(NSString *)gender{
    if (self = [super init]) {
        _telNum = telNum;
        _passWord  =passWord;
        _userAlias = userAlias;
        _protrait = protrait;
        _gender = gender;
    }
    return self;
}
+(instancetype)userInfoWithTelNum:(NSString *)telNum passWord:(NSString *)passWord userAlias:(NSString *)userAlias protrait:(NSString *)protrait gender:(NSString *)gender{
    return [[[self class ] alloc] initWithTelNum:telNum passWord:passWord userAlias:userAlias protrait:protrait gender:gender];
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}


- (NSString *)description
{
    return [NSString stringWithFormat:@"手机号：%@ 密码：%@  昵称：%@ 头像 ：%@，性别：%@", _telNum ,_passWord,_userAlias,_protrait,_gender];
}
@end

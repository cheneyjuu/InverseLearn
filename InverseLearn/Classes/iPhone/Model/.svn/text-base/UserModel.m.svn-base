//
//  UserModel.m
//  InverseLearn
//
//  Created by 大知 on 14-7-24.
//  Copyright (c) 2014年 DaZhi. All rights reserved.
//

#import "UserModel.h"

@implementation UserModel

-(instancetype)initWithDict:(NSDictionary *)dict{
    self = [super init];
    if (!self) return nil;
    
    _token = [dict objectForKey:@"token"];
    _userName = [dict objectForKey:@"UserId"];
    _password = [dict objectForKey:@"PassWord"];
    _trueName = [dict objectForKey:@"UserName"];
    _phoneNumber = [dict objectForKey:@"Mobile"];
    _sex = [[dict objectForKey:@"Sex"] integerValue];
    _schoolId = [[dict objectForKey:@"SchoolID"] integerValue];
    
    return self;
}

@end

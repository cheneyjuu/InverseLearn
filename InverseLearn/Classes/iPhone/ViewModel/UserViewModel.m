//
//  UserViewModel.m
//  InverseLearn
//
//  Created by 大知 on 14-7-24.
//  Copyright (c) 2014年 DaZhi. All rights reserved.
//

#import "UserViewModel.h"
#import "UserModel.h"

@implementation UserViewModel

-(instancetype)initWithUserModel:(UserModel *)userModel{
    self = [super init];
    if (!self) return nil;
    
    _userModel = userModel;
    _token = userModel.token;
    _userName = userModel.userName;
    _password = userModel.password;
    _trueName = userModel.trueName;
    _phoneNumber = userModel.phoneNumber;
    if (userModel.sex == 1) {
        _sex = @"男";
    } else{
        _sex = @"女";
    }
    if (userModel.schoolId == 1) {
        _inSchool = @"是";
    } else {
        _inSchool = @"否";
    }
    
    return self;
}

@end

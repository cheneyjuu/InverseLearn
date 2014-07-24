//
//  UserViewModel.h
//  InverseLearn
//
//  Created by 大知 on 14-7-24.
//  Copyright (c) 2014年 DaZhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserModel;

@interface UserViewModel : NSObject

-(instancetype)initWithUserModel:(UserModel*) userModel;

@property (nonatomic, readonly) UserModel *userModel;

@property (nonatomic, readonly) NSString *token;
@property (nonatomic, readonly) NSString *userName;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, readonly) NSString *trueName;
@property (nonatomic, copy) NSString *phoneNumber;
@property (nonatomic, readonly) NSString *sex;
@property (nonatomic, readonly) NSString *inSchool;

@end

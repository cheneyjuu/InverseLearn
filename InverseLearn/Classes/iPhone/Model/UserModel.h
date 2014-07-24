//
//  UserModel.h
//  InverseLearn
//
//  Created by 大知 on 14-7-24.
//  Copyright (c) 2014年 DaZhi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserModel : NSObject

@property (nonatomic, readonly) NSString *token;
@property (nonatomic, readonly) NSString *userName;
@property (nonatomic, copy) NSString *password;
@property (nonatomic, readonly) NSString *trueName;
@property (nonatomic, copy) NSString *phoneNumber;
@property (assign, readonly) int sex;
@property (assign, readonly) int schoolId;

-(instancetype) initWithDict:(NSDictionary *) dict;

@end

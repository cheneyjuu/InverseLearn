//
//  LoginViewController.h
//  InverseLearn
//
//  Created by 大知 on 14-7-23.
//  Copyright (c) 2014年 DaZhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class UserModel;

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordTextField;
@property (weak, nonatomic) IBOutlet UIButton    *loginButton;

@property (nonatomic, readonly) UserModel *userModel;
@property (nonatomic, assign  ) BOOL      isVisitor;

- (IBAction)loginAction:(id)sender;
- (IBAction)visitorAction:(id)sender;

@end

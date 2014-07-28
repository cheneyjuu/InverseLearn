//
//  RegisterViewController.h
//  InverseLearn
//
//  Created by 大知 on 14-7-24.
//  Copyright (c) 2014年 DaZhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRadioButton.h"

@class UserModel;

@interface RegisterViewController : UIViewController <QRadioButtonDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *rePasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *trueNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;

@property (nonatomic, assign) int inSchool;
@property (nonatomic, assign) int sex;
@property (nonatomic, assign) int userId;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSDictionary *userData;
@property (nonatomic, copy) UserModel *userModel;

@property (weak, nonatomic) IBOutlet UIView *sexView;
@property (weak, nonatomic) IBOutlet UIView *schoolView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)registerAction:(id)sender;
@end

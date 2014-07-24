//
//  RegisterViewController.h
//  InverseLearn
//
//  Created by 大知 on 14-7-24.
//  Copyright (c) 2014年 DaZhi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRadioButton.h"

@interface RegisterViewController : UIViewController <QRadioButtonDelegate>

@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *rePasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *trueNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumberTextField;

- (IBAction)registerAction:(id)sender;
@end

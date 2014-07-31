//
//  LoginViewController.m
//  InverseLearn
//
//  Created by 大知 on 14-7-23.
//  Copyright (c) 2014年 DaZhi. All rights reserved.
//

#import "LoginViewController.h"
#import "UserViewModel.h"
#import "UserModel.h"
#import "AppCenterViewController.h"
#import "RegisterViewController.h"
#import "FBShimmeringView.h"

@interface LoginViewController ()
@property (nonatomic, weak) RegisterViewController *registerVC;
@property (nonatomic, strong) FBShimmeringView *shimmeringView;
@property (nonatomic, weak) NSTimer *myTimer;
@end

@implementation LoginViewController{
    NSString *userName;
    NSString *password;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self customTextFieldStyle];
    _isVisitor = NO;
    NSLog(@"!!FROM LOGIN VIEW CONTROLLER -- navigation: %@", self.navigationController);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}

- (void)customTextFieldStyle{
    _userNameTextField.borderStyle=UITextBorderStyleLine;
    _userPasswordTextField.borderStyle=UITextBorderStyleLine;
    
    if ([_userNameTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor orangeColor];
        _userNameTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"请输入用户名" attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
    }
    
    if ([_userPasswordTextField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor orangeColor];
        _userPasswordTextField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"******" attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
    }
    
    _userNameTextField.layer.cornerRadius = 20.0;
    _userPasswordTextField.layer.cornerRadius = 20.0;
    
    _userNameTextField.layer.masksToBounds=YES;
    _userPasswordTextField.layer.masksToBounds=YES;
    
    _userNameTextField.layer.borderWidth = 1;
    _userPasswordTextField.layer.borderWidth = 1;
    
    _userNameTextField.layer.borderColor = [[UIColor orangeColor] CGColor];
    _userPasswordTextField.layer.borderColor = [[UIColor orangeColor] CGColor];
    
    CGRect frame = _userNameTextField.frame;
    frame.size.height = frame.size.height + 10;
    _userNameTextField.frame = frame;
    
    frame = _userPasswordTextField.frame;
    frame.size.height = frame.size.height + 10;
    _userPasswordTextField.frame = frame;
}

-(void)customeButtonStyle{
    [_loginButton setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    _loginButton.layer.cornerRadius = 20.0;
    _loginButton.backgroundColor = [UIColor colorWithRed:237.0 green:130.0 blue:34.0 alpha:1];
}

#pragma mark -

- (void) requestLogin{
    NSString *loginUrl = [NSString stringWithFormat:@"%@/account/login", baseUrl];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params = @{@"name":userName, @"pwd":password};
    [manager GET:loginUrl parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *result = responseObject;
        _userModel = [[UserModel alloc] initWithDict:[result objectForKey:@"data"]];
        
        if ([[result objectForKey:@"erro"] integerValue] == 1) {
            [TSMessage showNotificationInViewController:self title:@"提示信息" subtitle:[result objectForKey:@"msg"] type:TSMessageNotificationTypeWarning];
        } else {
            NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
            NSString *myUserId = [[result objectForKey:@"data"] objectForKey:@"ID"];
            NSString *myUserName =[[result objectForKey:@"data"] objectForKey:@"UserName"];
            [userDefault setObject:myUserId forKey:@kUserId];
            [userDefault setObject:myUserName forKey:@kUserName];
            [userDefault setObject:[[result objectForKey:@"data"] objectForKey:@"Head"] forKey:@kUserHead];
        }
        
        [UIView transitionWithView:_shimmeringView duration:1 options:UIViewAnimationOptionTransitionNone animations:^{
            _shimmeringView.alpha = 0.75f;
        } completion:^(BOOL finished) {
            [self.navigationController popViewControllerAnimated:NO];
            [_shimmeringView removeFromSuperview];
        }];
        NSLog(@"!!FROM LOGIN ACTION -- result data: %@", result);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (_shimmeringView) {
            [_shimmeringView removeFromSuperview];
        }
        NSLog(@"error: %@", error);
    }];
}

/*
 */
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

#pragma mark -

-(void) shimmerLabel{
    _shimmeringView = [[FBShimmeringView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_shimmeringView];
    
    UILabel *loadingLabel = [[UILabel alloc] initWithFrame:_shimmeringView.bounds];
    loadingLabel.textAlignment = NSTextAlignmentCenter;
    UIFont *font = [UIFont fontWithName:@"HelveticaNeue" size:48];
    loadingLabel.font = font;
    loadingLabel.text = @"PHATENT";
    loadingLabel.textColor = [UIColor blackColor];
    
    _shimmeringView.contentView = loadingLabel;
    [_shimmeringView setBackgroundColor:UIColorFromRGB(0xF9E1A0)];
    
    // Start shimmering.
    _shimmeringView.shimmering = YES;
}

#pragma mark login action
- (IBAction)loginAction:(id)sender {
    
    IQKeyboardManager *keyboardManager = [IQKeyboardManager sharedManager];
    [keyboardManager resignFirstResponder];
    userName = _userNameTextField.text;
    password = _userPasswordTextField.text;
    if (userName.length <= 0 || userName.length < 6 || userName.length > 18) {
        [TSMessage showNotificationInViewController:self title:@"提示信息" subtitle:@"用户名长度为6-18个字符" type:TSMessageNotificationTypeWarning];
    } else if (password.length <= 0){
        [TSMessage showNotificationInViewController:self title:@"提示信息" subtitle:@"密码不能为空" type:TSMessageNotificationTypeWarning];
    } else {
        [self shimmerLabel];
        [self requestLogin];
    }
}

- (IBAction)visitorAction:(id)sender {
    _isVisitor = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)registerAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)aboutAction:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end

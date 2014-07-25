//
//  RegisterViewController.m
//  InverseLearn
//
//  Created by 大知 on 14-7-24.
//  Copyright (c) 2014年 DaZhi. All rights reserved.
//

#import "RegisterViewController.h"
#import "CQSegmentControl.h"
#import "UserModel.h"

@interface RegisterViewController ()

@end

@implementation RegisterViewController

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
    // Do any additional setup after loading the view.
    self.title = @"用户注册";
    self.navigationController.navigationBarHidden = NO;
    UIBarButtonItem *leftButtonItem = [self createBackButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    [self customTextFieldStyle];
    [self customeSexStyle];
    
    NSArray *titleItems = @[@"", @""];
    UIImage *unSelectYesImage = [UIImage imageNamed:@"unSelectYes.png"];
    UIImage *unSelectNoImage = [UIImage imageNamed:@"unSelectNo.png"];
    
    UIImage *selectedYesImage = [UIImage imageNamed:@"selectedYes.png"];
    UIImage *selectedNoImage = [UIImage imageNamed:@"selectedNo.png"];
    
    NSMutableArray *unselectImageArray = [NSMutableArray arrayWithObjects:unSelectYesImage, unSelectNoImage, nil];
    NSMutableArray *selectedImageArray = [NSMutableArray arrayWithObjects:selectedYesImage, selectedNoImage, nil];
    
    CQSegmentControl *segmentedControl= [[CQSegmentControl alloc] initWithItemsAndStype:titleItems stype:TitleAndImageSegmented];
    for (UIView *subView in segmentedControl.subviews)
	{
		[subView removeFromSuperview];
	}
	segmentedControl.normalImageItems = unselectImageArray;
	segmentedControl.highlightImageItems = selectedImageArray;
	segmentedControl.unselectedItemColor = UIColorFromRGB(0xED8222);
    segmentedControl.selectedItemColor = UIColorFromRGB(0x6F2A22);
	segmentedControl.selectedSegmentIndex = 0;
    segmentedControl.frame = CGRectMake(40.0f, 10.0f, 64.0f, 58.0f);
    [segmentedControl addTarget:self action:@selector(schoolAction:) forControlEvents:UIControlEventValueChanged];
    [self.schoolView addSubview:segmentedControl];
    
    // setting default value
    _sex = 1;
    _inSchool = 1;
    _userData = [[NSDictionary alloc] init];
}

-(void)viewWillAppear:(BOOL)animated{
    // IOS7 适配
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
}

-(UIBarButtonItem*) createBackButton{
    
    UIImage* image= [UIImage imageNamed:@"btn_backLogin"];
    CGRect backframe= CGRectMake(0, 0, image.size.width, image.size.height);
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = backframe;
    [backButton setBackgroundImage:image forState:UIControlStateNormal];
    [backButton setTitle:@"返回登录" forState:UIControlStateNormal];
    [backButton setTitleColor:UIColorFromRGB(0x6F2A22) forState:UIControlStateNormal];
    backButton.titleLabel.font=[UIFont systemFontOfSize:14];
    backButton.titleLabel.textAlignment = NSTextAlignmentLeft;
    backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 240, 0, 0);
    [backButton addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    //定制自己的风格的  UIBarButtonItem
    UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
    return someBarButtonItem;
}

-(void)popself{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)customTextFieldStyle{
    
    [self textFieldWithCustomStype:_userNameTextField placeHolder:@"用户名"];
    [self textFieldWithCustomStype:_passwordTextField placeHolder:@"密码"];
    [self textFieldWithCustomStype:_rePasswordTextField placeHolder:@"确认密码"];
    [self textFieldWithCustomStype:_trueNameTextField placeHolder:@"真实姓名"];
    [self textFieldWithCustomStype:_phoneNumberTextField placeHolder:@"手机号码"];
    
}

-(void)customeSexStyle{
    
    QRadioButton *maleButton = [[QRadioButton alloc] initWithDelegate:self groupId:@"sexGroup"];
    QRadioButton *femaleButton = [[QRadioButton alloc] initWithDelegate:self groupId:@"sexGroup"];
    
    maleButton.frame = CGRectMake(100, 10, 80, 40);
    [maleButton setTitle:@"男" forState:UIControlStateNormal];
    [maleButton setTitleColor:UIColorFromRGB(0xED8222) forState:UIControlStateNormal];
    [maleButton.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [maleButton setChecked:YES];
    maleButton.tag = 1;
    [self.sexView addSubview:maleButton];
    
    femaleButton.frame = CGRectMake(160, 10, 80, 40);
    [femaleButton setTitle:@"女" forState:UIControlStateNormal];
    [femaleButton setTitleColor:UIColorFromRGB(0xED8222) forState:UIControlStateNormal];
    [femaleButton.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    femaleButton.tag = 0;
    [self.sexView addSubview:femaleButton];
    
    [maleButton addTarget:self action:@selector(selectSexAction:) forControlEvents:UIControlEventTouchUpInside];
    [femaleButton addTarget:self action:@selector(selectSexAction:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)selectSexAction:(QRadioButton *) button{
    _sex = button.tag;
    NSLog(@"sex: %d", _sex);
}

-(void)textFieldWithCustomStype:(UITextField*) textField placeHolder:(NSString *) placeHolder{
    textField.borderStyle=UITextBorderStyleLine;
    if ([textField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        UIColor *color = [UIColor orangeColor];
        textField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:placeHolder attributes:@{NSForegroundColorAttributeName: color}];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
    }
    
    textField.layer.cornerRadius = 20.0;
    textField.layer.masksToBounds=YES;
    textField.layer.borderColor = [[UIColor orangeColor] CGColor];
    textField.layer.borderWidth = 1;
    CGRect frame = textField.frame;
    frame.size.height += 10;
    textField.frame = frame;
    
    UILabel *paddingView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 25)];
    paddingView.text = @"  ";
    paddingView.textColor = [UIColor darkGrayColor];
    paddingView.backgroundColor = [UIColor clearColor];
    textField.leftView = paddingView;
    textField.leftViewMode = UITextFieldViewModeAlways;
}

#pragma mark  是否在校
-(void)schoolAction:(CQSegmentControl*)segmented{
    if (segmented.selectedSegmentIndex == 0) {
        _inSchool = 1;
    } else {
        _inSchool = 0;
    }
}

- (IBAction)registerAction:(id)sender {
    //数据验证
    if (_userNameTextField.text.length < 6 || _userNameTextField.text.length > 18){
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"用户名必须在6-18个字符之间" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
    } else if (_passwordTextField.text.length < 6){
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"密码必须大于6个字符" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
    } else if (![_rePasswordTextField.text isEqualToString:_passwordTextField.text]){
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"两次密码输入不一致" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
    } else if (_trueNameTextField.text.length < 2 || _trueNameTextField.text.length > 4){
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"姓名必须在2-4个字符之间" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
    } else if (_phoneNumberTextField.text.length < 11){
        UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示信息" message:@"手机号码输入有误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [av show];
    } else {
        // 数据验证通过后，调用注册接口
        AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
        NSDictionary *params = @{@"account":_userNameTextField.text, @"pwd":_passwordTextField.text, @"nickname":_trueNameTextField.text, @"phone":_phoneNumberTextField.text, @"sex":[NSNumber numberWithInt:_sex], @"type":@2, @"schoolid":@1};
        _userData = params;
        NSString *registerURL = [NSString stringWithFormat:@"%@/account/regist", baseUrl];
        [manager POST:registerURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            if ([[responseObject objectForKey:@"erro"] intValue] == 0) {
                _userId = [responseObject objectForKey:@"data"];
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"注册信息" message:[responseObject objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                av.tag = 1000;
                [av show];
                av.delegate = self;
            } else {
                // 出错时提示用户
                UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示信息" message:[responseObject objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
                [av show];
            }
            NSLog(@"register response: %@", responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"register failed: %@", operation);
        }];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    // tag=1000 在注册成功时，会弹出“注册成功”提醒，此alterView的tag=1000
    if (alertView.tag == 1000) {
        // 将用户信息写入UserModel,并将用户带入“应用中心”页面
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setValue:[_userData objectForKey:@"account"] forKey:@"UserId"];
        [dict setValue:[_userData objectForKey:@"pwd"] forKey:@"PassWord"];
        [dict setValue:[_userData objectForKey:@"nickname"] forKey:@"UserName"];
        [dict setValue:[_userData objectForKey:@"phone"] forKey:@"Mobile"];
        [dict setValue:[_userData objectForKey:@"sex"] forKey:@"Sex"];
        [dict setValue:[_userData objectForKey:@"schoolid"] forKey:@"SchoolID"];
        _userModel = [[UserModel alloc] initWithDict:dict];
        [self performSegueWithIdentifier:@"AppCenterStoryBoard" sender:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end

//
//  RegisterViewController.m
//  InverseLearn
//
//  Created by 大知 on 14-7-24.
//  Copyright (c) 2014年 DaZhi. All rights reserved.
//

#import "RegisterViewController.h"
#import "CQSegmentControl.h"

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
    self.navigationController.navigationBarHidden = NO;
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
	segmentedControl.selectedSegmentIndex = 1;
    segmentedControl.frame = CGRectMake(40.0f, 10.0f, 64.0f, 58.0f);
    [segmentedControl addTarget:self action:@selector(schoolAction:) forControlEvents:UIControlEventValueChanged];
    [self.schoolView addSubview:segmentedControl];
}

-(void)viewWillAppear:(BOOL)animated{
    // IOS7 适配
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
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
    [self.sexView addSubview:maleButton];
    
    femaleButton.frame = CGRectMake(160, 10, 80, 40);
    [femaleButton setTitle:@"女" forState:UIControlStateNormal];
    [femaleButton setTitleColor:UIColorFromRGB(0xED8222) forState:UIControlStateNormal];
    [femaleButton.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
    [self.sexView addSubview:femaleButton];
    
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
-(void)schoolAction:(id)sender{
    
}

- (IBAction)registerAction:(id)sender {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSDictionary *params = @{@"account":@"123123", @"pwd":@"123123", @"nickname":@"123123", @"phone":@"13867564532123", @"sex":@1, @"type":@2, @"schoolid":@1003};
    NSString *registerURL = [NSString stringWithFormat:@"%@/account/regist", baseUrl];
    [manager POST:registerURL parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([[responseObject objectForKey:@"erro"] intValue] == 1) {
            UIAlertView *av = [[UIAlertView alloc] initWithTitle:@"提示信息" message:[responseObject objectForKey:@"msg"] delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [av show];
        }
        NSLog(@"register successful: %@", [responseObject objectForKey:@"msg"]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"register failed: %@", operation);
    }];
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

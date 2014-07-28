//
//  AppCenterViewController.m
//  InverseLearn
//
//  Created by 大知 on 14-7-25.
//  Copyright (c) 2014年 DaZhi. All rights reserved.
//

#import "AppCenterViewController.h"
#import "RKTabView.h"
#import "LoginViewController.h"

@interface AppCenterViewController ()

@end

@implementation AppCenterViewController

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
    [self createTabView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userDefaults objectForKey:@kUserId];
    NSLog(@"FROM APP CENTER -- USER ID:%@", userId);
    if (userId == nil) {
        [self performSegueWithIdentifier:@"LoginSBI" sender:self];
    } else {
        self.navigationItem.leftBarButtonItem = nil;
        self.navigationItem.hidesBackButton = YES;
    }
}

-(void)createTabView{
    RKTabItem *tabItemPassword = [RKTabItem createUsualItemWithImageEnabled:[UIImage imageNamed:@"btn_key_press.png"] imageDisabled:[UIImage imageNamed:@"btn_key.png"]];
    RKTabItem *tabItemInfo = [RKTabItem createUsualItemWithImageEnabled:[UIImage imageNamed:@"btn_info_press.png"] imageDisabled:[UIImage imageNamed:@"btn_info.png"]];
    RKTabItem *tabItemClasses = [RKTabItem createUsualItemWithImageEnabled:[UIImage imageNamed:@"btn_class_press.png"] imageDisabled:[UIImage imageNamed:@"btn_class.png"]];
    tabItemPassword.tabState = TabStateEnabled;
    
    NSArray *items = @[tabItemPassword, tabItemInfo, tabItemClasses];
    CGRect frame = self.view.frame;
    frame.size.height = 54;
    frame.origin.y = self.view.frame.size.height - 44;
    RKTabView *tabView = [[RKTabView alloc] initWithFrame:frame andTabItems:items];
    tabView.delegate = self;
    [tabView setBackgroundColor:UIColorFromRGB(0xF9E1A0)];
    [tabView setBounds:CGRectMake(0, 10, self.view.frame.size.width, 44)];
    [self.view addSubview:tabView];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - TabView delegate
- (void)tabView:(RKTabView *)tabView tabBecameEnabledAtIndex:(int)index tab:(RKTabItem *)tabItem{
    
}

- (void)tabView:(RKTabView *)tabView tabBecameDisabledAtIndex:(int)index tab:(RKTabItem *)tabItem{
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    LoginViewController *vc = [segue destinationViewController];
    vc.navigationController = self.navigationController;
}

- (IBAction)backToLoginAction:(id)sender {
    [self performSegueWithIdentifier:@"BackToLoginSBI" sender:self];
}
@end

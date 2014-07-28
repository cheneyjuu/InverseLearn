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
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userDefault objectForKey:@kUserId];
    if (userId) {
        [self createTabView];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userId = [userDefaults objectForKey:@kUserId];
    NSLog(@"FROM APP CENTER -- USER ID:%@", userId);
    if (userId == nil) {
        UIBarButtonItem *backButtonItem = [self createBackButton];
        self.navigationItem.leftBarButtonItem = backButtonItem;
        [self performSegueWithIdentifier:@"LoginSBI" sender:self];
    } else {
        UIBarButtonItem *logoutButtonItem = [self createLogoutButton];
        self.navigationItem.leftBarButtonItem = logoutButtonItem;
        self.title = [userDefaults objectForKey:@kUserName];
    }
}

#pragma mark - Create custom tabView and barButtonItem
-(void)createTabView{
    // TODO: 创建TabBar
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
    // TODO: 返回到登录界面按钮
    UIImage* image= [UIImage imageNamed:@"btn_backLogin"];
    CGRect backframe= CGRectMake(0, 0, image.size.width + 100, image.size.height);
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = backframe;
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -60, 0, 0)];
    [backButton setTitle:@"返回登录" forState:UIControlStateNormal];
    [backButton setTitleEdgeInsets:UIEdgeInsetsMake(2, -60, 0, 0)];
    UIFont *font = [UIFont fontWithName:@"System" size:16];
    backButton.titleLabel.font = font;
    [backButton setTitleColor:UIColorFromRGB(0xF9E1A0) forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backToLoginAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
    return someBarButtonItem;
}

-(UIBarButtonItem*) createLogoutButton{
    // TODO: 注销按钮
    UIImage* image= [UIImage imageNamed:@"btn_logout"];
    CGRect backframe= CGRectMake(0, 0, image.size.width + 40, image.size.height);
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = backframe;
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton setImageEdgeInsets:UIEdgeInsetsMake(0, -40, 0, 0)];
    [backButton setTitle:@"注销" forState:UIControlStateNormal];
    [backButton setTitleEdgeInsets:UIEdgeInsetsMake(2, -40, 0, 0)];
    UIFont *font = [UIFont fontWithName:@"System" size:16];
    backButton.titleLabel.font = font;
    [backButton setTitleColor:UIColorFromRGB(0xF9E1A0) forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(logout) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
    return someBarButtonItem;
}

- (void)backToLoginAction {
    //TODO: 返回到登录界面
    [self performSegueWithIdentifier:@"LoginSBI" sender:self];
}

-(void)logout{
    // TODO: 用户登出
    // 用户注销后，删除用户基本信息，并返回到登录界面
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault removeObjectForKey:@kUserId];
    [userDefault removeObjectForKey:@kUserName];
    [self performSegueWithIdentifier:@"LoginSBI" sender:self];
}
#pragma mark - TabView delegate
- (void)tabView:(RKTabView *)tabView tabBecameEnabledAtIndex:(int)index tab:(RKTabItem *)tabItem{
    
}

- (void)tabView:(RKTabView *)tabView tabBecameDisabledAtIndex:(int)index tab:(RKTabItem *)tabItem{
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    // 页面跳转之前，将navigationController赋值给LoginViewController
    LoginViewController *vc = [segue destinationViewController];
    vc.navigationController = self.navigationController;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end

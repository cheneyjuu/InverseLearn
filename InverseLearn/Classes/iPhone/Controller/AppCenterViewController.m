//
//  AppCenterViewController.m
//  InverseLearn
//
//  Created by 大知 on 14-7-25.
//  Copyright (c) 2014年 DaZhi. All rights reserved.
//

#import "AppCenterViewController.h"
#import "LoginViewController.h"
#import "OralCalculationViewController.h"

@interface AppCenterViewController ()
@property (nonatomic, strong) UINavigationController *myNav;
@property (nonatomic, strong) LoginViewController *loginVC;
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
    self.title = @"应用中心";
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // IOS7 适配
    if ([self respondsToSelector:@selector(setEdgesForExtendedLayout:)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    self.navigationController.navigationBarHidden = NO;
    if (OSVersionIsAtLeastiOS7()) {
        [self.navigationController.navigationBar setBarTintColor:UIColorFromRGB(0xF7C783)];
    }
    
//    RootViewController *rootVC = [[RootViewController alloc] init];
//    [rootVC hideMenuViewController];
    
//    self.navigationController.navigationBarHidden = NO;
    
//    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
//    NSString *userId = [userDefaults objectForKey:@kUserId];
//    
//    NSLog(@"FROM APP CENTER -- USER ID:%@ || NAVIGATION:%@", userId, self.navigationController);
//    
//    if (_loginVC == nil) {
//        _loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"loginController"];
//    }
//    // 判断是不是游客身份
//    if (_loginVC.isVisitor) {
//        self.title = @"欢迎您";
//    } else {
//        // 假如用户没有登录过，并且不是以游客身份使用的话，则弹出登录页面
//        if (userId == NULL) {
//            _myNav = [[UINavigationController alloc] initWithRootViewController:_loginVC];
//            NSLog(@"FROM APP CENTER -- MY NAVIGATION:%@", _myNav);
//            [self presentViewController:_myNav animated:YES completion:^{}];
//        } else {
//            UIBarButtonItem *logoutButtonItem = [self createLogoutButton];
//            self.navigationItem.leftBarButtonItem = logoutButtonItem;
//            self.title = [userDefaults objectForKey:@kUserName];
//        }
//    }
    
}

//#pragma mark - Create custom tabView and barButtonItem
//-(void)createTabView{
//    // TODO: 创建TabBar
//    RKTabItem *tabItemPassword = [RKTabItem createUsualItemWithImageEnabled:[UIImage imageNamed:@"btn_key_press.png"] imageDisabled:[UIImage imageNamed:@"btn_key.png"]];
//    RKTabItem *tabItemInfo = [RKTabItem createUsualItemWithImageEnabled:[UIImage imageNamed:@"btn_info_press.png"] imageDisabled:[UIImage imageNamed:@"btn_info.png"]];
//    RKTabItem *tabItemClasses = [RKTabItem createUsualItemWithImageEnabled:[UIImage imageNamed:@"btn_class_press.png"] imageDisabled:[UIImage imageNamed:@"btn_class.png"]];
//    tabItemPassword.tabState = TabStateEnabled;
//    
//    NSArray *items = @[tabItemPassword, tabItemInfo, tabItemClasses];
//    CGRect frame = self.view.frame;
//    frame.size.height = 54;
//    frame.origin.y = self.view.frame.size.height - 44;
//    RKTabView *tabView = [[RKTabView alloc] initWithFrame:frame andTabItems:items];
//    tabView.delegate = self;
//    [tabView setBackgroundColor:UIColorFromRGB(0xF9E1A0)];
//    [tabView setBounds:CGRectMake(0, 10, self.view.frame.size.width, 44)];
//    [self.view addSubview:tabView];
//}

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
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)logout{
    // TODO: 用户登出
    // 用户注销后，删除用户基本信息，并返回到登录界面
    
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    
    if (_loginVC == nil) {
        _loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"loginController"];
    }
    if (_myNav == nil) {
        _myNav = [[UINavigationController alloc] initWithRootViewController:_loginVC];
    }
    [self presentViewController:_myNav animated:YES completion:^{}];
}

//#pragma mark - TabView delegate
//- (void)tabView:(RKTabView *)tabView tabBecameEnabledAtIndex:(int)index tab:(RKTabItem *)tabItem{
//    
//}
//
//- (void)tabView:(RKTabView *)tabView tabBecameDisabledAtIndex:(int)index tab:(RKTabItem *)tabItem{
//    
//}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}
@end

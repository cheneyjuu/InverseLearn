//
//  DEMOMenuViewController.m
//  REFrostedViewControllerStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DZMenuViewController.h"
#import "AppCenterViewController.h"
#import "UIViewController+REFrostedViewController.h"
#import "UIImageView+AFNetworking.h"
#import "LoginViewController.h"

@interface DZMenuViewController ()

@property (nonatomic, strong) UINavigationController *myNav;

@property (nonatomic, strong) UIBarButtonItem *paneRevealLeftBarButtonItem;

@end

@implementation DZMenuViewController

- (void)loadView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.separatorColor = [UIColor colorWithWhite:1.0 alpha:0.25];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    self.tableView.separatorColor      = [UIColor colorWithRed:150/255.0f green:161/255.0f blue:177/255.0f alpha:1.0f];
    self.tableView.tableHeaderView     = ({
    UIView *view                       = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
    UIImageView *imageView             = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 100, 100)];
    imageView.autoresizingMask         = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;


    NSUserDefaults *userDefault        = [NSUserDefaults standardUserDefaults];

    UILabel *label                     = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 0, 24)];
        if ([userDefault objectForKey:@kUserId] != NULL) {
    NSURL *url                         = [NSURL URLWithString:[userDefault objectForKey:@kUserHead]];
            [imageView setImageWithURL:url];
    label.text                         = [userDefault objectForKey:@kUserName];
        } else {
    imageView.image                    = [UIImage imageNamed:@""];
    label.text                         = @"请先登录";
    UITapGestureRecognizer *tapGestrue = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loginAction:)];
    tapGestrue.numberOfTapsRequired    = 1;
    tapGestrue.delegate                = self;
            [view addGestureRecognizer:tapGestrue];
        }

    imageView.layer.masksToBounds      = YES;
    imageView.layer.cornerRadius       = 50.0;
    imageView.layer.borderColor        = [UIColor orangeColor].CGColor;
    imageView.layer.borderWidth        = 3.0f;
    imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    imageView.layer.shouldRasterize    = YES;
    imageView.clipsToBounds            = YES;

    label.font                         = [UIFont fontWithName:@"HelveticaNeue" size:16];
    label.backgroundColor              = [UIColor clearColor];
    label.textColor                    = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
        [label sizeToFit];
    label.autoresizingMask             = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;

        [view addSubview:imageView];
        [view addSubview:label];
        view;
    });
}

#pragma mark -
#pragma mark UITableView Delegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
    cell.textLabel.font      = [UIFont fontWithName:@"HelveticaNeue" size:17];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return nil;

    UIView *view             = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 34)];
    view.backgroundColor     = [UIColor colorWithRed:167/255.0f green:167/255.0f blue:167/255.0f alpha:0.6f];

    UILabel *label           = [[UILabel alloc] initWithFrame:CGRectMake(10, 8, 0, 0)];
    label.text               = @"系统设置";
    label.font               = [UIFont systemFontOfSize:15];
    label.textColor          = [UIColor whiteColor];
    label.backgroundColor    = [UIColor clearColor];
    [label sizeToFit];
    [view addSubview:label];

    return view;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return 0;

    return 34;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    DZNavigationController *navigationController = [self.storyboard instantiateViewControllerWithIdentifier:@"contentController"];
    
//    if (indexPath.section == 0 && indexPath.row == 0) {
//        AppCenterViewController *homeViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"appCenterController"];
//        navigationController.viewControllers = @[homeViewController];
//    } else {
//        DEMOSecondViewController *secondViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"secondController"];
//        navigationController.viewControllers = @[secondViewController];
//    }
    
    if (indexPath.section == 1 && indexPath.row == 2) {
        [self logoutAction];
    }
}

#pragma mark -
#pragma mark UITableView Datasource

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 54;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)sectionIndex
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    if ([userDefault objectForKey:@kUserId] != NULL) {
        return 3;
    } else {
        return 2;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";

    UITableViewCell *cell           = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (cell == nil) {
    cell                            = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }

    if (indexPath.section == 0) {
    NSArray *titles                 = @[@"用户菜单1", @"用户菜单2", @"用户菜单3"];
    cell.textLabel.text             = titles[indexPath.row];
    } else {
        NSArray *titles;
    NSUserDefaults *userDefault     = [NSUserDefaults standardUserDefaults];
        if ([userDefault objectForKey:@kUserId] != NULL) {
    titles                          = @[@"系统菜单1", @"系统菜单2", @"退出登录"];

            if (indexPath.row == 2) {
    cell.textLabel.textColor        = [UIColor redColor];
            }
        } else {
    titles                          = @[@"系统菜单1", @"系统菜单2"];
        }
    cell.textLabel.text             = titles[indexPath.row];
    }

    return cell;
}

-(void)loginAction:(id) sender{
    LoginViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"loginController"];
    if (_myNav == nil) {
        _myNav = [[UINavigationController alloc] initWithRootViewController:loginVC];
    }
    [self presentViewController:_myNav animated:YES completion:^{}];
}

-(void)logoutAction{
    NSString *appDomain = [[NSBundle mainBundle] bundleIdentifier];
    [[NSUserDefaults standardUserDefaults] removePersistentDomainForName:appDomain];
    [self loginAction:nil];
}

- (void)dynamicsDrawerRevealLeftBarButtonItemTapped:(id)sender
{
    [self.dynamicsDrawerViewController setPaneState:MSDynamicsDrawerPaneStateOpen inDirection:MSDynamicsDrawerDirectionLeft animated:YES allowUserInterruption:YES completion:nil];
}

- (void)transitionToViewController{
    [self.dynamicsDrawerViewController setPaneState:MSDynamicsDrawerPaneStateClosed animated:YES allowUserInterruption:YES completion:nil];
    UIViewController *paneViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"appCenterController"];

    self.paneRevealLeftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_down_press"] style:UIBarButtonItemStyleDone target:self action:@selector(dynamicsDrawerRevealLeftBarButtonItemTapped:)];
    paneViewController.navigationItem.leftBarButtonItem = self.paneRevealLeftBarButtonItem;
    UINavigationController *paneNavigationViewController = [[UINavigationController alloc] initWithRootViewController:paneViewController];
    [self.dynamicsDrawerViewController setPaneViewController:paneNavigationViewController animated:NO completion:nil];
}
 
@end

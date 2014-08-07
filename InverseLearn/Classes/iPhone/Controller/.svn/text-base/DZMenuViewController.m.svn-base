//
//  DEMOMenuViewController.m
//  REFrostedViewControllerStoryboards
//
//  Created by Roman Efimov on 10/9/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DZMenuViewController.h"
#import "AppCenterViewController.h"
#import "UIImageView+AFNetworking.h"
#import "UIViewController+MMDrawerController.h"
#import "LoginViewController.h"
#import "MenuCell.h"
#import "AboutUsViewController.h"

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
    self.tableView.backgroundColor = UIColorFromRGB(0xFCF3E2);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
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
        imageView.layer.borderColor    = UIColorFromRGB(0xF6D4B8).CGColor;
    imageView.layer.borderWidth        = 3.0f;
    imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    imageView.layer.shouldRasterize    = YES;
    imageView.clipsToBounds            = YES;

    label.font                         = [UIFont fontWithName:@"HelveticaNeue" size:16];
    label.backgroundColor              = [UIColor clearColor];
        label.textColor                = UIColorFromRGB(0xD5832D);
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
    cell.backgroundColor = [UIColor clearColor];
    cell.textLabel.textColor = UIColorFromRGB(0xD5832D);
    cell.textLabel.font      = [UIFont fontWithName:@"HelveticaNeue" size:15];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            
        } else if (indexPath.row == 1){
            AboutUsViewController *aboutController = [self.storyboard instantiateViewControllerWithIdentifier:@"AboutUsStoryBoard"];
            UINavigationController *navigationController = (UINavigationController *)self.mm_drawerController.centerViewController;
            [navigationController pushViewController:aboutController animated:YES];
            [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
        } else {
            [self logoutAction];
        }
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
    if (sectionIndex == 0) {
        return 2;
    } else {
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        if ([userDefault objectForKey:@kUserId] != NULL) {
            return 3;
        } else {
            return 2;
        }
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"MenuCell";
    
    static BOOL nibsRegistered = NO;
    if (!nibsRegistered) {
        UINib *nib = [UINib nibWithNibName:@"MenuCell" bundle:nil];
        [tableView registerNib:nib forCellReuseIdentifier:cellIdentifier];
        nibsRegistered = YES;
    }
 
    MenuCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];

    if (indexPath.section == 0) {
        NSArray *titles             = @[@"基础信息", @"学校班级"];
        UIImage *icon;
        if (indexPath.row == 0) {
            icon = [UIImage imageNamed:@"btn_info"];
        } else {
            icon = [UIImage imageNamed:@"btn_class"];
        }
        cell.icon.image = icon;
        cell.label.text = titles[indexPath.row];
    } else {
        NSArray *titles;
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        if ([userDefault objectForKey:@kUserId] != NULL) {
            titles                      = @[@"密码修改", @"关于我们", @"退出登录"];
        } else {
            titles                      = @[@"密码修改", @"关于我们"];
        }
        UIImage *icon;
        if (indexPath.row == 0) {
            icon = [UIImage imageNamed:@"btn_key"];
        } else if (indexPath.row == 1) {
            icon = [UIImage imageNamed:@"btn_key"];
        } else {
            icon = [UIImage imageNamed:@"btn_key"];
        }
        cell.icon.image = icon;
        cell.label.text = titles[indexPath.row];
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
 
@end

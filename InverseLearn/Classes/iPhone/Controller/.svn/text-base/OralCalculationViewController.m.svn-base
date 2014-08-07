//
//  OralCalculationViewController.m
//  InverseLearn
//
//  Created by 大知 on 14-8-4.
//  Copyright (c) 2014年 DaZhi. All rights reserved.
//

#import "OralCalculationViewController.h"
#import "ConfigOralCalculationViewController.h"
#import "CreateOralCalculationViewController.h"

@interface OralCalculationViewController ()

@end

@implementation OralCalculationViewController

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
    if (OSVersionIsAtLeastiOS7()) {
        [self.navigationController.navigationBar setBarTintColor:UIColorFromRGB(0x2FA4CA)];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    if (iPhone5) {
        _backgroundView.image = [UIImage imageNamed:@"bg_menu_ca-568h@2x.png"];
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
- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
@end

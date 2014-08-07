//
//  ConfigOralCalculationViewController.m
//  InverseLearn
//
//  Created by 大知 on 14-8-4.
//  Copyright (c) 2014年 DaZhi. All rights reserved.
//

#import "ConfigOralCalculationViewController.h"

@interface ConfigOralCalculationViewController ()

@property (nonatomic, readonly, copy) NSString *symbol;
@property (nonatomic, readwrite, strong) NSMutableArray *symbolArray;
@property (nonatomic, strong) NSString *mixRule;//混合运算规则

@end

@implementation ConfigOralCalculationViewController

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
    
    _symbolArray = [NSMutableArray array];
    [_symbolArray addObject:@"+"];
    _mixRule = @"second";
    
    _rangeSlider.continuous = YES;
    [_rangeSlider addTarget:self action:@selector(rangChangedAction:) forControlEvents:UIControlEventValueChanged];
    _rangeTextField.text = @"10";
    
    UIImage *stetchLeftTrack = [UIImage imageNamed:@"btn_slider_Press_right"];
    UIImage *stetchRightTrack = [UIImage imageNamed:@"btn_slider_left"];
    UIImage *thumbImage = [UIImage imageNamed:@"btn_contacts"];
    [_rangeSlider setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal];
    [_rangeSlider setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
    [_rangeSlider setThumbImage:thumbImage forState:UIControlStateHighlighted];
    [_rangeSlider setThumbImage:thumbImage forState:UIControlStateNormal];
    
    _countSlider.continuous = YES;
    [_countSlider addTarget:self action:@selector(countChangedAction:) forControlEvents:UIControlEventValueChanged];
    _countTextField.text = @"10";
    [_countSlider setMaximumTrackImage:stetchRightTrack forState:UIControlStateNormal];
    [_countSlider setMinimumTrackImage:stetchLeftTrack forState:UIControlStateNormal];
    [_countSlider setThumbImage:thumbImage forState:UIControlStateHighlighted];
    [_countSlider setThumbImage:thumbImage forState:UIControlStateNormal];
    
    // TODO: add button event
    [_secondOperationButton addTarget:self action:@selector(secondAction:) forControlEvents:UIControlEventTouchUpInside];
    [_thirdOperationButton addTarget:self action:@selector(thirdAction:) forControlEvents:UIControlEventTouchUpInside];
    [_fourthOperationButton addTarget:self action:@selector(fourthAction:) forControlEvents:UIControlEventTouchUpInside];
    
    NSUserDefaults *userDefauls = [NSUserDefaults standardUserDefaults];
    if ([userDefauls objectForKey:kOralCalculation] == nil) {
        [self saveConfigAction:nil];// 设置默认值
    }
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (iPhone5) {
        _backgroundView.image = [UIImage imageNamed:@"bg_project_ca-568h@2x.png"];
    }
    self.navigationController.navigationBarHidden = NO;
    UIBarButtonItem *leftButtonItem = [self createBackButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
}

-(UIBarButtonItem*) createBackButton{
    // TODO: 返回到登录界面按钮
    UIImage* image= [UIImage imageNamed:@"btn_back"];
    CGRect backframe= CGRectMake(0, 0, image.size.width, image.size.height);
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = backframe;
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
    return someBarButtonItem;
}

-(void)rangChangedAction:(id)sender{
    UISlider *slider = (UISlider *)sender;
    _rangeTextField.text = [NSString stringWithFormat:@"%d", [NSNumber numberWithFloat:slider.value].intValue];
}

-(void)countChangedAction:(id)sender{
    UISlider *slider = (UISlider *)sender;
    _countTextField.text = [NSString stringWithFormat:@"%d", [NSNumber numberWithFloat:slider.value].intValue];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 * 点击运算符号时调用
 * @param sender类型为UIButton,button的tag在stroyboard中已设置。
 *          tag==0时代表点击的是“+”
 *          tag==1时代表点击的是“-”
 *          tag==2时代表点击的是“*”
 *          tag==3时代表点击的是“÷”
 */
- (IBAction)symbolsAction:(id)sender {
    
    UIButton *symbolButton = (UIButton *)sender;
    
    NSString *imageName;
    
    if (symbolButton.tag == 0) {
        _symbol = @"+";
        imageName = @"btn_plus";
    } else if (symbolButton.tag == 1){
        _symbol = @"-";
        imageName = @"btn_less";
    } else if (symbolButton.tag == 2){
        _symbol = @"*";
        imageName = @"btn_multiply";
    } else if (symbolButton.tag == 3){
        _symbol = @"/";
        imageName = @"btn_except";
    } else{
        _symbol = nil;
    }
    
    
    // 如果运算符为选中状态，则将其添加到“操作符数组”中，否则从“操作符数组”中删除
    if (symbolButton.selected == 1) {
        symbolButton.selected = 0;
        [symbolButton setBackgroundImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        [_symbolArray removeObject:_symbol];
    } else {
        symbolButton.selected = 1;
        [symbolButton setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@_press", imageName]] forState:UIControlStateSelected];
        [_symbolArray addObject:_symbol];
    }
    
}

- (IBAction)saveConfigAction:(id)sender {
    // TODO: 保存设置
    NSMutableDictionary *configDict = [NSMutableDictionary dictionary];
    [configDict setObject:_rangeTextField.text  forKey:kRange];
    [configDict setObject:_countTextField.text  forKey:kCount];
    [configDict setObject:_symbolArray          forKey:kSymbole];
    [configDict setObject:_mixRule              forKey:kMixRole];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:configDict forKey:kOralCalculation];
}

#pragma mark - button event

-(void)secondAction:(UIButton *)button{
    _mixRule = @"second";
    if (button.selected == 1) {
        button.selected = 0;
        [button setBackgroundImage:[UIImage imageNamed:@"btn_two"] forState:UIControlStateNormal];
    } else {
        button.selected = 1;
        [button setBackgroundImage:[UIImage imageNamed:@"btn_two_press"] forState:UIControlStateSelected];
        
        _thirdOperationButton.selected = 0;
        _fourthOperationButton.selected = 0;
        
        [_thirdOperationButton setBackgroundImage:[UIImage imageNamed:@"btn_three"] forState:UIControlStateNormal];
        [_fourthOperationButton setBackgroundImage:[UIImage imageNamed:@"btn_four"] forState:UIControlStateNormal];
    }
}

-(void)thirdAction:(UIButton *)button{
    _mixRule = @"third";
    if (button.selected == 1) {
        button.selected = 0;
        [button setBackgroundImage:[UIImage imageNamed:@"btn_three"] forState:UIControlStateNormal];
    } else {
        button.selected = 1;
        [button setBackgroundImage:[UIImage imageNamed:@"btn_three_press"] forState:UIControlStateSelected];
        
        _secondOperationButton.selected = 0;
        _fourthOperationButton.selected = 0;
        
        [_secondOperationButton setBackgroundImage:[UIImage imageNamed:@"btn_two"] forState:UIControlStateNormal];
        [_fourthOperationButton setBackgroundImage:[UIImage imageNamed:@"btn_four"] forState:UIControlStateNormal];
    }
    // 判断选择的运算符号，如果是是三则运算，必须包含至少一个一级运算符和一个二级运算符
}

-(void)fourthAction:(UIButton *)button{
    _mixRule = @"fourth";
    if (button.selected == 1) {
        button.selected = 0;
        [button setBackgroundImage:[UIImage imageNamed:@"btn_four"] forState:UIControlStateNormal];
    } else {
        button.selected = 1;
        [button setBackgroundImage:[UIImage imageNamed:@"btn_four_press"] forState:UIControlStateSelected];
        
        _secondOperationButton.selected = 0;
        _thirdOperationButton.selected = 0;
        
        [_secondOperationButton setBackgroundImage:[UIImage imageNamed:@"btn_two"] forState:UIControlStateNormal];
        [_thirdOperationButton setBackgroundImage:[UIImage imageNamed:@"btn_three"] forState:UIControlStateNormal];
    }
}

#pragma mark - navigation pop

-(void)backAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

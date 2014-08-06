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
    
    _rangeSlider.continuous = YES;
    [_rangeSlider setThumbImage:[UIImage imageNamed:@"btn_contacts"] forState:UIControlStateNormal];
    [_rangeSlider addTarget:self action:@selector(rangChangedAction:) forControlEvents:UIControlEventValueChanged];
    _rangeTextField.text = @"10";
    
    _countSlider.continuous = YES;
    [_countSlider addTarget:self action:@selector(countChangedAction:) forControlEvents:UIControlEventValueChanged];
    _countTextField.text = @"10";
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
    
    if (symbolButton.tag == 0) {
        _symbol = @"+";
    } else if (symbolButton.tag == 1){
        _symbol = @"-";
    } else if (symbolButton.tag == 2){
        _symbol = @"*";
    } else if (symbolButton.tag == 3){
        _symbol = @"/";
    } else{
        _symbol = nil;
    }
    
    // 如果运算符为选中状态，则将其添加到“操作符数组”中，否则从“操作符数组”中删除
    if (symbolButton.selected == 1) {
        symbolButton.selected = 0;
        [_symbolArray removeObject:_symbol];
    } else {
        symbolButton.selected = 1;
        [_symbolArray addObject:_symbol];
    }
}

-(void)backAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

@end

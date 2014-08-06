//
//  CreateOralCalculationViewController.m
//  InverseLearn
//
//  Created by 大知 on 14-8-4.
//  Copyright (c) 2014年 DaZhi. All rights reserved.
//

#import "CreateOralCalculationViewController.h"

@interface CreateOralCalculationViewController ()

@end

@implementation CreateOralCalculationViewController

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
    self.navigationController.navigationBarHidden = NO;
    UIBarButtonItem *leftButtonItem = [self createBackButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    // Do any additional setup after loading the view.
    NSArray *familyNames =[[NSArray alloc]initWithArray:[UIFont familyNames]];
    
    NSArray *fontNames;
    NSInteger indFamily, indFont;
    for(indFamily=0;indFamily<[familyNames count];++indFamily)
    {
        NSLog(@"Family name: %@", [familyNames objectAtIndex:indFamily]);
        fontNames =[[NSArray alloc]initWithArray:[UIFont fontNamesForFamilyName:[familyNames objectAtIndex:indFamily]]];
        for(indFont=0; indFont<[fontNames count]; ++indFont)
        {
            NSLog(@"    Font name: %@",[fontNames objectAtIndex:indFont]);
        }
    }

    [self thirdArithmetic:@[@"+", @"-", @"*", @"/"] quantity:10 topicRange:100];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (iPhone5) {
        
    }
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

-(void)thirdArithmetic:(NSArray *)symbols quantity:(int)quantity topicRange:(int)topicRange{
    // TODO: 三则运算
    
    NSString *topic;
    NSArray *symbolsArray;
    NSMutableArray *levelOneArray = [NSMutableArray array];//一级运算符数组
    NSMutableArray *levelTwoArray = [NSMutableArray array];//二级运算符数组
    
    for (int i=0; i<symbols.count; i++) {
        if ([symbols[i] isEqualToString:@"+"] || [symbols[i] isEqualToString:@"-"]) {
            [levelOneArray addObject:symbols[i]];
        } else if ([symbols[i] isEqualToString:@"*"] || [symbols[i] isEqualToString:@"/"]){
            [levelTwoArray addObject:symbols[i]];
        }
    }
    for (int i=0; i<quantity; i++) {
        for (int k=0; k<symbols.count; k++) {
            
            symbolsArray = [self generateSymbol:levelOneArray levelTwoSymbols:levelTwoArray];
            
            topic =[NSString stringWithFormat:@"%d%@%d%@%d", arc4random() % topicRange == 0?arc4random() % topicRange:arc4random() % topicRange, symbolsArray[0], arc4random() % topicRange == 0?arc4random() % topicRange:arc4random() % topicRange, symbolsArray[1], arc4random() % topicRange == 0?arc4random() % topicRange:arc4random() % topicRange];
            NSLog(@"%@", topic);
        }
    }
}

/**
 * @param levelOneSymbols 一级运算符数组、levelTwoSymbols 二级运算符数组
 */
-(NSArray *)generateSymbol:(NSArray *) levelOneSymbols levelTwoSymbols:(NSArray *) levelTwoSymbols{
    NSString *levelOne = levelOneSymbols[arc4random() % levelOneSymbols.count];
    NSString *levelTwo = levelTwoSymbols[arc4random() % levelTwoSymbols.count];
    return @[levelOne, levelTwo];
}

-(void)backAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ViewController.m
//  InverseLearn
//
//  Created by 大知 on 14-7-22.
//  Copyright (c) 2014年 DaZhi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

typedef NSString* (^IntToStringConvert)(id self, NSInteger integer);

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    NSInteger outsideVar = 10;
    void (^myBlock)(void) = ^(void){
        NSLog(@"%d", outsideVar);
    };
    myBlock();
    
    IntToStringConvert intToStringConvert = ^(id self, NSInteger integer){
        NSString *result = [NSString stringWithFormat:@"%d", integer];
        return result;
    };
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

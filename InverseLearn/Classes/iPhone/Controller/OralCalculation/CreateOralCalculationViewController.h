//
//  CreateOralCalculationViewController.h
//  InverseLearn
//
//  Created by 大知 on 14-8-4.
//  Copyright (c) 2014年 DaZhi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateOralCalculationViewController : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)numberButtonAction:(id)sender;
- (IBAction)deleteButtonAction:(id)sender;
- (IBAction)nextButtonAction:(id)sender;

- (IBAction)downButtonAction:(id)sender;
- (IBAction)upButtonAction:(id)sender;


@end

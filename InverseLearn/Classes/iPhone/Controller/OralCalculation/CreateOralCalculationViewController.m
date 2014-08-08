//
//  CreateOralCalculationViewController.m
//  InverseLearn
//
//  Created by 大知 on 14-8-4.
//  Copyright (c) 2014年 DaZhi. All rights reserved.
//

#define kUseButtonStyle

#import "CreateOralCalculationViewController.h"

@interface CreateOralCalculationViewController ()

@property (nonatomic, strong) NSMutableArray *topicArray;
@property (nonatomic, strong) UITextField *answerField;
@property (nonatomic, strong) UIButton *answerButton;
@property (nonatomic, strong) UIButton *selectedButton;
@property (nonatomic, strong) NSMutableArray *answerButtonArray;
@property (nonatomic, strong) NSMutableString *answer;

@end

@implementation CreateOralCalculationViewController{
    int downCount;
}

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
    
    self.topicArray = [NSMutableArray array];
    self.answerButtonArray = [NSMutableArray array];
    downCount = 1;
    self.answer = [[NSMutableString alloc] init];
    // Do any additional setup after loading the view.

    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSDictionary *configDict = [userDefaults objectForKey:kOralCalculation];
    NSArray *symbolsArray = [configDict objectForKey:kSymbole];
    NSString *range = [configDict objectForKey:kRange];
    NSString *quantity = [configDict objectForKey:kCount];
    NSString *mixRole = [configDict objectForKey:kMixRole];
    
    if ([mixRole isEqualToString:kSecondCalculation]) {
        [self secondArithmetic:symbolsArray quantity:quantity.intValue topicRang:range.intValue];
        [self addTopicToView];
    }
    
    if ([mixRole isEqualToString:kThirdCalculation]) {
        [self thirdArithmetic:symbolsArray quantity:quantity.intValue topicRange:range.intValue];
        [self addTopicToView];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (iPhone5) {
        
    }
}

#pragma mark 返回按钮定制

-(UIBarButtonItem*) createBackButton{
    UIImage* image= [UIImage imageNamed:@"btn_back"];
    CGRect backframe= CGRectMake(0, 0, image.size.width, image.size.height);
    UIButton* backButton= [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = backframe;
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
    return someBarButtonItem;
}

#pragma mark - 生成二级运算题目

/** 生成二级运算题目
 *
 *  @param symbols       运算符号数组，二级运算只能包含一种运算符号
 *  @param quantity      题目数量
 *  @param topicRange    题目范围
 *
 */
-(void)secondArithmetic:(NSArray *)symbols quantity:(int)quantity topicRang:(int)topicRange{
    NSString *topic, *sybmol;
    for (int i=0; i<quantity; i++) {
        int leftNumber = arc4random() % topicRange;
        int rightNumber = arc4random() % topicRange;
        sybmol = symbols[arc4random() % symbols.count];
        // 此处判断是为了保证不会出现负数
        if ([sybmol isEqualToString:@"-"]) {
            if (leftNumber > rightNumber) {
                topic = [NSString stringWithFormat:@"%d%@%d",leftNumber, sybmol, rightNumber];
                i--;
            } else {
                leftNumber = arc4random() % topicRange;
                rightNumber = arc4random() % topicRange;
            }
        } else {
            topic = [NSString stringWithFormat:@"%d%@%d",leftNumber, sybmol, rightNumber];
        }
        [self.topicArray addObject:topic];
    }
}

#pragma mark 生成三级运算题目

/** 生成三级运算题目
 *  
 *  @param symbols       运算符号数组，三级运算需要至少包含一个一级运算符和一个二级运算符
 *  @param quantity      题目数量
 *  @param topicRange    题目范围
 */
-(void)thirdArithmetic:(NSArray *)symbols quantity:(int)quantity topicRange:(int)topicRange{
    
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
            [self.topicArray addObject:topic];
        }
    }
}

#pragma mark 生成运算符
/**
 * @param levelOneSymbols 一级运算符数组、levelTwoSymbols 二级运算符数组
 */
-(NSArray *)generateSymbol:(NSArray *) levelOneSymbols levelTwoSymbols:(NSArray *) levelTwoSymbols{
    NSString *levelOne = levelOneSymbols[arc4random() % levelOneSymbols.count];
    NSString *levelTwo = levelTwoSymbols[arc4random() % levelTwoSymbols.count];
    return @[levelOne, levelTwo];
}

#pragma mark 将题目绘制到屏幕

-(void)addTopicToView{
    
    // 1. 循环获取题目，构建元素，添加到scrollView
    UIButton *sequenceButton;
    UILabel *topicLabel;
    CGRect buttonFrame = CGRectMake(0, 0, 44, 44);
    CGRect topicFrame = CGRectMake(50, 0, 140, 44);
    CGRect answerFrame = CGRectMake(200, 0, 60, 44);
    for (int i=0; i<_topicArray.count; i++) {
        sequenceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonFrame.origin.y = buttonFrame.size.height * i;
        [sequenceButton setFrame:buttonFrame];
        [sequenceButton setTitle:[NSString stringWithFormat:@"%d", i+1] forState:UIControlStateNormal];
        
        topicLabel = [[UILabel alloc] initWithFrame: topicFrame];
        topicFrame.origin.y = topicFrame.size.height * i;
        [topicLabel setFrame:topicFrame];
        topicLabel.text = _topicArray[i];
        
        answerFrame.origin.y = answerFrame.size.height * i;

#ifdef kUseButtonStyle
        
        self.answerButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.answerButton setFrame:answerFrame];
        self.answerButton.restorationIdentifier = _topicArray[i];
        self.answerButton.tag = i;
        [self.answerButton addTarget:self action:@selector(answerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.answerButtonArray addObject:self.answerButton];
#else
        self.answerField = [[UITextField alloc] initWithFrame:answerFrame];
        UIImage *image = [UIImage imageNamed:@"bg_text"];
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
        imageView.image = image;
        [self.answerField addSubview:imageView];
        [self.answerField setFrame:answerFrame];
        // 将对应的题目放到textField的restorationIdentifier属性中，供以后调用
        self.answerField.restorationIdentifier = _topicArray[i];
        self.answerField.delegate = self;
#endif
        
        if (i == 0) {
            self.answerButton.selected = YES;
            [self.answerButton setBackgroundImage:[UIImage imageNamed:@"bg_text_press"] forState:UIControlStateSelected];
            self.selectedButton = self.answerButton;
        } else {
            self.answerButton.selected = NO;
            [self.answerButton setBackgroundImage:[UIImage imageNamed:@"bg_text"] forState:UIControlStateNormal];
        }
        
        [self.scrollView addSubview:sequenceButton];
        [self.scrollView addSubview:topicLabel];
        
#ifdef kUseButtonStyle
        [self.scrollView addSubview:self.answerButton];
#else
        [self.scrollView addSubview:self.answerField];
#endif
        
    }
    [self.scrollView setContentSize:CGSizeMake(self.view.frame.size.width, _topicArray.count * 44)];
}

#pragma mark -  数字键盘被点击事件

- (IBAction)numberButtonAction:(id)sender {
    UIButton *button = (UIButton *) sender;
    int number = button.tag;// 按钮的tag value和数字是一一对应的
    [self.answer appendString:[NSString stringWithFormat:@"%d", number]];
//    NSLog(@"%@", self.selectedButton);
    [self.selectedButton setTitle:self.answer forState:UIControlStateNormal];
    [self.selectedButton setAttributedTitle:[[NSAttributedString alloc] initWithString:self.answer] forState:UIControlStateSelected];
//    self.answerField.text = self.answer;
}

#pragma mark 删除按钮被点击事件

- (IBAction)deleteButtonAction:(id)sender {
//    NSString *currentAnswer = self.selectedButton.titleLabel.text;
    // TODO: 待完善delete方法
    int currentAnswerLength = self.answer.length;
    [self.answer deleteCharactersInRange:NSMakeRange(currentAnswerLength - 1, currentAnswerLength -1)];//[self.answer substringWithRange:NSMakeRange(0, currentAnswerLength - 1)];
    [self.selectedButton setAttributedTitle:[[NSAttributedString alloc] initWithString:self.answer] forState:UIControlStateSelected];
    NSLog(@"%@", self.answer);
}

#pragma mark 选择下一个输入框按钮被点击事件

- (IBAction)nextButtonAction:(id)sender {
    
    // 下一个Button在数组中的下标
    int nextButtonIndex = self.selectedButton.tag + 1;
    
    /** 
     *  1. 循环buttonArray,数据是在生成button的时候加入数组中的
     *  2. 先将所有button的背景设置为normal,state设置为normal,selected设置为NO
     */
    
    for (int i=0; i<self.answerButtonArray.count; i++) {
        UIButton *button = self.answerButtonArray[i];
        [button setBackgroundImage:[UIImage imageNamed:@"bg_text"] forState:UIControlStateNormal];
        button.selected = NO;
    }

    /**
     *  1. 通过下一个button的下标，从数组中获取下一个button
     *  2. 将button背景设置为选中状态，state设置为selected，selected设置为YES
     */
    
    UIButton *currentButton = self.answerButtonArray[nextButtonIndex];
    [currentButton setBackgroundImage:[UIImage imageNamed:@"bg_text_press"] forState:UIControlStateSelected];
    currentButton.selected = YES;
    
    // 将获取到的button赋值给self.selectedButton
    self.selectedButton = currentButton;
}

#pragma mark - 向下滚动按钮事件

- (IBAction)downButtonAction:(id)sender {
    int downOffset = 44 * downCount;
    if (downOffset < _scrollView.contentSize.height - (_scrollView.frame.size.height - 44)) {
        [self.scrollView setContentOffset:CGPointMake(0, downOffset) animated:YES];
        downCount ++;
    }
}

#pragma mark 向上按钮事件

- (IBAction)upButtonAction:(id)sender {
    
}

#pragma mark - TextField Delegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    self.answer = [[NSMutableString alloc] init];
    
    NSArray *subViews = self.answerField.subviews;
    for (int i=0; i<subViews.count; i++) {
        if ([subViews[i] isKindOfClass:[UIImageView class]]) {
            [subViews[i] removeFromSuperview];
        }
    }
    UIImage *image = [UIImage imageNamed:@"bg_text"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    imageView.image = image;
    [self.answerField addSubview:imageView];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoBoardHidden:) name:UIKeyboardWillShowNotification object:nil];
    
    return YES;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    NSArray *subViews = self.answerField.subviews;
    for (int i=0; i<subViews.count; i++) {
        if ([subViews[i] isKindOfClass:[UIImageView class]]) {
            [subViews[i] removeFromSuperview];
        }
    }
    UIImage *image = [UIImage imageNamed:@"bg_text_press"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, image.size.width, image.size.height)];
    imageView.image = image;
    [self.answerField addSubview:imageView];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    self.answerField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    
    NSExpression *expression = [NSExpression expressionWithFormat:textField.restorationIdentifier];
    NSString *userAnswer = textField.text;
    NSString *resultAnswer = [NSString stringWithFormat:@"%@", [expression expressionValueWithObject:nil
                                                                                             context:nil]];
    CGRect frame = textField.frame;
    frame.origin.x = 280;
    frame.origin.y += 10;
    if ([userAnswer isEqualToString:resultAnswer]) {
        UIImage *image = [UIImage imageNamed:@"icon_yes"];
        frame.size.width = image.size.width;
        frame.size.height = image.size.height;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.image = image;
        [_scrollView addSubview:imageView];
    } else {
        UIImage *image = [UIImage imageNamed:@"icon_no"];
        frame.size.width = image.size.width;
        frame.size.height = image.size.height;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.image = image;
        [_scrollView addSubview:imageView];
    }
    
}

#pragma mark - 阻止键盘事件

- (void)keyBoBoardHidden:(NSNotification *)Notification{
    [self.answerField resignFirstResponder];
}

#pragma mark 答案输入框点击事件

/** 答案输入框点击事件
 *  使用按钮模拟输入框
 */
-(void)answerButtonAction:(UIButton *)button{
    self.answer = [[NSMutableString alloc] init];
    
    [self insertImage];
    
    self.selectedButton.selected = NO;  // 上一个Button
    [self.selectedButton setBackgroundImage:[UIImage imageNamed:@"bg_text"] forState:UIControlStateNormal];
    self.selectedButton = button;       // 当前Button
    self.selectedButton.selected = YES;
    [self.selectedButton setBackgroundImage:[UIImage imageNamed:@"bg_text_press"] forState:UIControlStateSelected];
}

-(void)insertImage{
    
    NSExpression *expression = [NSExpression expressionWithFormat:self.selectedButton.restorationIdentifier];
    NSString *userAnswer = self.selectedButton.titleLabel.text;
    NSString *resultAnswer = [NSString stringWithFormat:@"%@", [expression expressionValueWithObject:nil
                                                                                             context:nil]];
    CGRect frame = self.selectedButton.frame;
    frame.origin.x = 280;
    frame.origin.y += 10;
    if ([userAnswer isEqualToString:resultAnswer]) {
        UIImage *image = [UIImage imageNamed:@"icon_yes"];
        frame.size.width = image.size.width;
        frame.size.height = image.size.height;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.image = image;
        [_scrollView addSubview:imageView];
    } else {
        UIImage *image = [UIImage imageNamed:@"icon_no"];
        frame.size.width = image.size.width;
        frame.size.height = image.size.height;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:frame];
        imageView.image = image;
        [_scrollView addSubview:imageView];
    }
}

#pragma mark -

-(void)backAction:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

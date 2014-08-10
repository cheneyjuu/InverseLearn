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

@property (nonatomic, strong) NSString *totalTime;
@property (nonatomic) NSTimer *theTimer;
@property (nonatomic, strong) UILabel *timerLabel;

@end

@implementation CreateOralCalculationViewController{
    int downCount, upCount;
    float time;
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
    
    // TODO: 进入界面后，会有一个倒计时动画，以便让答题者做好答题准备
    
    self.navigationController.navigationBarHidden = NO;
    UIBarButtonItem *leftButtonItem = [self createBackButton];
    self.navigationItem.leftBarButtonItem = leftButtonItem;
    
    self.topicArray = [NSMutableArray array];
    self.answerButtonArray = [NSMutableArray array];
    downCount = upCount = 1;
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
    
    // 计时器

    self.timerLabel = [[UILabel alloc] initWithFrame:CGRectMake(220, 55, 150, 44)];
    self.timerLabel.text = @"00:00";
    self.timerLabel.textColor = [UIColor whiteColor];
    UIFont *font = [UIFont fontWithName:@"Noteworthy" size:22];
    self.timerLabel.font = font;
    [self.view addSubview:self.timerLabel];
//    [self initializeTimer];
}

-(void)initializeTimer {
    
    _theTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                target:self
                                              selector:@selector(updateTime:)
                                              userInfo:nil
                                               repeats:YES];
}

-(float)updateTime:(id)sender{
    time += 1;
    _totalTime = [NSString stringWithFormat:@"%02d:%02d",(int)(time / 60) ,(int)time - ( 60 * (int)( time / 60 ) )];
    self.timerLabel.text = _totalTime;
    return time;
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
                topic = [NSString stringWithFormat:@"%d %@ %d",leftNumber, sybmol, rightNumber];
            } else {
                leftNumber = arc4random() % topicRange;
                rightNumber = arc4random() % topicRange;
            }
        } else {
            topic = [NSString stringWithFormat:@"%d %@ %d",leftNumber, sybmol, rightNumber];
        }
        if (topic != nil) {
            [self.topicArray addObject:topic];
        } else {
            i--;
        }
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
    CGRect topicFrame = CGRectMake(70, 0, 140, 44);
    CGRect answerFrame = CGRectMake(200, 0, 60, 44);
    UIFont *font = [UIFont fontWithName:@"Noteworthy" size:24];
    for (int i=0; i<_topicArray.count; i++) {
        sequenceButton = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonFrame.origin.y = buttonFrame.size.height * i;
        [sequenceButton setFrame:buttonFrame];
        sequenceButton.titleLabel.font = font;
        [sequenceButton setTitle:[NSString stringWithFormat:@"%d", i+1] forState:UIControlStateNormal];
        
        topicLabel = [[UILabel alloc] initWithFrame: topicFrame];
        topicFrame.origin.y = topicFrame.size.height * i;
        [topicLabel setFrame:topicFrame];
        topicLabel.font = font;
        topicLabel.textColor = [UIColor whiteColor];
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
    NSString *text = self.selectedButton.titleLabel.text == nil ? @"" : self.selectedButton.titleLabel.text;
    NSString *resultAnswer = [NSString stringWithFormat:@"%@%d", text, number];
//    [self.selectedButton setAttributedTitle:[[NSAttributedString alloc] initWithString:resultAnswer] forState:UIControlStateSelected];
    [self.selectedButton.titleLabel setFrame:self.selectedButton.frame];
    [self.selectedButton setTitle:resultAnswer forState:UIControlStateNormal];
    NSLog(@"button: %@", self.selectedButton.titleLabel);
}

#pragma mark 删除按钮被点击事件

- (IBAction)deleteButtonAction:(id)sender {
    
    NSString *currentAnswer = self.selectedButton.titleLabel.text;
    int currentAnswerLength = currentAnswer.length;

    if (currentAnswerLength > 0) {
        currentAnswer = [currentAnswer substringWithRange:NSMakeRange(0, currentAnswerLength - 1)];
        self.selectedButton.titleLabel.text = currentAnswer;
        [self.selectedButton setTitle:currentAnswer forState:UIControlStateSelected];
    }
}

#pragma mark 向下按钮被点击事件

- (IBAction)nextButtonAction:(id)sender {
    
    self.answer = [NSMutableString new];
    
    UIButton *currentButton = self.answerButtonArray[self.selectedButton.tag];
    if (currentButton.titleLabel.text != nil) {
        
        // 下一个Button在数组中的下标
        int nextButtonIndex;
        if (self.selectedButton.tag < self.answerButtonArray.count - 1) {
            nextButtonIndex = self.selectedButton.tag + 1;
        } else {
            nextButtonIndex = self.selectedButton.tag;
        }
        
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
        
        UIButton *nextButton = self.answerButtonArray[nextButtonIndex];
        [nextButton setBackgroundImage:[UIImage imageNamed:@"bg_text_press"] forState:UIControlStateSelected];
        nextButton.selected = YES;
        
        // 将获取到的button赋值给self.selectedButton
        self.selectedButton = nextButton;
        
        [self downButtonAction:nil];
        
        // 将scrollView滚动到可视区域, 并设置向下滚动标记为nextButton.tag + 1
        [_scrollView setContentOffset:CGPointMake(0, currentButton.frame.origin.y)];
        downCount = nextButton.tag + 1;
    } else {
        [TSMessage showNotificationInViewController:self title:@"提示信息" subtitle:@"答案不能为空" type:TSMessageNotificationTypeWarning];
    }
    
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
    int upOffset = _scrollView.contentOffset.y - 44;
    if (_scrollView.contentOffset.y) {
        [self.scrollView setContentOffset:CGPointMake(0, upOffset) animated:YES];
        downCount --;
    }
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
    
    if (self.selectedButton.titleLabel.text == nil) {
        [TSMessage showNotificationInViewController:self title:@"提示信息" subtitle:@"答案不能为空" type:TSMessageNotificationTypeWarning];
    } else {
        [self insertImage];
        
        self.selectedButton.selected = NO;  // 上一个Button
        [self.selectedButton setBackgroundImage:[UIImage imageNamed:@"bg_text"] forState:UIControlStateNormal];
        self.selectedButton = button;       // 当前Button
        self.selectedButton.selected = YES;
        [self.selectedButton setBackgroundImage:[UIImage imageNamed:@"bg_text_press"] forState:UIControlStateSelected];
    }
}

-(void)insertImage{

    NSString *userAnswer = self.selectedButton.titleLabel.text;
    BOOL theAnswerIsRight = [self isRightAnswer:self.selectedButton.restorationIdentifier answer:userAnswer];
    
    if (userAnswer != nil) {
        CGRect frame = self.selectedButton.frame;
        frame.origin.x = 280;
        frame.origin.y += 10;
        
        UIImage *image;
        UIImageView *imageView;
        
        if (theAnswerIsRight) {
            image = [UIImage imageNamed:@"icon_yes"];
            frame.size.width = image.size.width;
            frame.size.height = image.size.height;
            imageView = [[UIImageView alloc] initWithFrame:frame];
            imageView.image = image;
            imageView.restorationIdentifier = @"yesImageView";
            [_scrollView addSubview:imageView];
        } else {
            image = [UIImage imageNamed:@"icon_no"];
            frame.size.width = image.size.width;
            frame.size.height = image.size.height;
            imageView = [[UIImageView alloc] initWithFrame:frame];
            imageView.image = image;
            imageView.restorationIdentifier = @"yesImageView";
            [_scrollView addSubview:imageView];
        }
    }
    
}

-(BOOL)isRightAnswer:(NSString *)question answer:(NSString *)userAnswer{
    NSExpression *expression = [NSExpression expressionWithFormat:question];
    NSString *resultAnswer = [NSString stringWithFormat:@"%@", [expression expressionValueWithObject:nil
                                                                                             context:nil]];
    if ([userAnswer isEqualToString:resultAnswer]) {
        return YES;
    } else{
        return NO;
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

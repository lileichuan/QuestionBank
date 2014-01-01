//
//  ExamViewController.m
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-1.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "ExamViewController.h"
#import "QuestionBrowser.h"
#import "QuestionResultView.h"
#import "TopView.h"
#import "QuestionInterface.h"
#import "DXAlertView.h"
#import "UIGridView.h"
#import "UIGridViewDelegate.h"

@interface ExamViewController ()<QuestionBrowserDelegate,QuestionProtocol,UIGridViewDelegate>{
    UIView *guideView;
    TopView *topView;
    QuestionBrowser     *questionBrowser;
    QuestionResultView *questionResultView;
    
    
    NSArray     *questionArr;
    
    NSInteger       viewTag; //0表示向导页面；1表示考试界面；2表示答题结果页面；3表示查看答案；
    UIGridView *answerList ;
}
@property(nonatomic, retain)  NSArray             *questionArr;
@property(nonatomic, assign)  NSInteger       viewTag;
@end

@implementation ExamViewController
@synthesize questionArr,viewTag;

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
    [self addTopBarView];
    [self addGuideView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)close{
    if (viewTag == 1) {
        NSString *messsage = [NSString stringWithFormat:@"试卷还没有提交，是否退出考试!"];
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"是否退出考试" contentText:messsage leftButtonTitle:@"取消" rightButtonTitle:@"退出考试"];
        [alert show];
        alert.leftBlock = ^() {
        };
        alert.rightBlock = ^() {
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
                          };
        alert.dismissBlock = ^() {
        };
        [alert release];
    }
    else{
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
    
}

-(void)setViewTag:(NSInteger)_viewTag{
    viewTag = _viewTag;
    NSString *title;
    switch (viewTag) {
        case 0:
            title = @"考试简介";
            break;
        case 1:
            title = @"模拟考试";
            break;
        case 2:{
            title = @"答题结果";
            [topView setReturnTitle:@"主菜单"];
        }
            break;
        case 3:
            title = @"查看答案";
            [topView setReturnTitle:@"主菜单"];
            break;
        case 4:
            title = @"回顾答题";
            [topView setReturnTitle:@"主菜单"];
            break;
            
        default:
            break;
    }
    topView.title.text = title;
}

-(void)initQuestionData{
    if (questionArr) {
        [questionArr release];
        questionArr = nil;
    }
    TestPaper *testPaper = [[QuestionInterface sharedQuestionInterface]generateTestPaper];
    self.questionArr = testPaper.questionArr;
}

-(void)addTopBarView{
    if (!topView) {
        CGRect topRect =   CGRectMake(0, 0,CGRectGetWidth(self.view.bounds), TOP_BAR_HEIGHT);
        topView = [[TopView alloc]initWithFrame:topRect];
        [topView addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:topView];
        [topView  release];
    }
    
    
}

-(void)removeTopBarView{
    if (topView) {
        [topView removeFromSuperview];
        topView = nil;
    }
}

-(void)addGuideView{
    CGRect contentRect =   CGRectMake(0, TOP_BAR_HEIGHT,CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - TOP_BAR_HEIGHT );
    if (!guideView) {
        guideView = [[UIView alloc]initWithFrame:contentRect];
        guideView.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:guideView];
        [guideView release];
        
        float startX = 50;
        float labelWidth = 300;
        float labelHeigth = 40;
        
        UIFont *font = [UIFont fontWithName:@"ArialRoundedMTBold" size:18];
        CGRect timeRect = CGRectMake(startX, 150,labelWidth , labelHeigth);
        UILabel *timeLabel = [[UILabel alloc]initWithFrame:timeRect];
        //设置字体
        timeLabel.font = font;
        timeLabel.backgroundColor = [UIColor clearColor];
        timeLabel.text = @"试题数量:100题";
        [guideView addSubview:timeLabel];
        [timeLabel release];
        
        CGRect amountRect = CGRectMake(startX,CGRectGetMaxY(timeRect) ,labelWidth , labelHeigth);
        UILabel *amountLabel = [[UILabel alloc]initWithFrame:amountRect];
        //设置字体
        amountLabel.font = font;
        amountLabel.backgroundColor = [UIColor clearColor];
        amountLabel.text = @"考试时间:60分钟";
        [guideView addSubview:amountLabel];
        [amountLabel release];
        
        CGRect standardRect = CGRectMake(startX,CGRectGetMaxY(amountRect) ,labelWidth , labelHeigth);
        UILabel *standardLabel = [[UILabel alloc]initWithFrame:standardRect];
        //设置字体
        standardLabel.font = font;
        standardLabel.backgroundColor = [UIColor clearColor];
        standardLabel.text = @"合格标准:满分100分，60分及格";
        [guideView addSubview:standardLabel];
        [standardLabel release];
        
        
        UIButton *enterExamBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        //[submitBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:227.0/255.0 green:100.0/255.0 blue:83.0/255.0 alpha:1]] forState:UIControlStateNormal];
        enterExamBtn.layer.masksToBounds  = YES;
        enterExamBtn.layer.cornerRadius  = 3.0;
        enterExamBtn.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:100.0/255.0 blue:83.0/255.0 alpha:1];
        [enterExamBtn setTitle:@"进入考试" forState:UIControlStateNormal];
        [enterExamBtn addTarget:self action:@selector(addQuestionBrowserView) forControlEvents:UIControlEventTouchUpInside];
        float btnWidth = 90;
        float btnHeight = 35;
        enterExamBtn.frame = CGRectMake(CGRectGetMidX(guideView.frame) - btnWidth/2,CGRectGetMidY(guideView.frame) - btnHeight/2, btnWidth, btnHeight);
        [guideView addSubview:enterExamBtn];
        
    }
    self.viewTag = 0;
}

-(void)removeGuidView{
    if (guideView) {
        [guideView removeFromSuperview];
        guideView  = nil;
    }
}

-(void)addQuestionBrowserView{
    [self initQuestionData];
    CGRect startRect =   CGRectMake(CGRectGetWidth(self.view.bounds), TOP_BAR_HEIGHT,CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - TOP_BAR_HEIGHT );
    CGRect contentRect =   CGRectMake(0,TOP_BAR_HEIGHT,CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - TOP_BAR_HEIGHT );
    if (!questionBrowser) {
        questionBrowser = [[QuestionBrowser alloc]initWithFrame:startRect withDelegate:self withAnswerType:MOCK_EXAM];
        questionBrowser._questionData = questionArr;
        [self.view addSubview:questionBrowser];
        [questionBrowser release];
    }
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect guidRect = guideView.frame;
        guidRect.origin.x = - guidRect.size.width;
        guideView.frame = guidRect;
        questionBrowser.frame = contentRect;
    } completion:^(BOOL finished) {
        [guideView removeFromSuperview];
        guideView = nil;
    }];
    self.viewTag = 1;
}

-(void)removeQuestionBrowserView{
    if (questionBrowser) {
        [questionBrowser removeFromSuperview];
        questionBrowser = nil;
    }
}

-(void)restartQuestionBroswerView{
    [self initQuestionData];
    if (questionBrowser) {
        [questionBrowser reloadData];
        [questionBrowser jumpToQuestionIndex:0];
    }
    [self removeQuestionResultView];
    viewTag = 4;
    
}

-(void)addQuestionResultView{
    TestPaper *testPaper =   [[QuestionInterface sharedQuestionInterface]getCurTestPaper];
    CGRect contentRect =   CGRectMake(0,TOP_BAR_HEIGHT,CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - TOP_BAR_HEIGHT );
    if (!questionResultView) {
        questionResultView = [[QuestionResultView alloc] initWithFrame:contentRect];
        questionResultView.testPaper = testPaper;
        questionResultView.answerListBlock =^(){
            [self addAnswerListView];
        };
        questionResultView.restartBlock =^(){
            [self restartQuestionBroswerView];
        };
        [self.view addSubview:questionResultView];
        [questionResultView release];
    }
    self.viewTag = 2;
}

-(void)removeQuestionResultView{
    if (questionResultView) {
        [questionResultView removeFromSuperview];
        questionResultView = nil;
    }
}
//查看答题结果
-(void)addAnswerListView{
    if (!answerList) {
        CGRect contentRect =   CGRectMake(0,TOP_BAR_HEIGHT,CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - TOP_BAR_HEIGHT );
        answerList = [[UIGridView alloc] initWithFrame:contentRect];
        answerList.uiGridViewDelegate = self;
        [self.view addSubview:answerList];
        [answerList release];
    }
    [self removeQuestionResultView];
    self.viewTag = 3;
}

-(void)removeAnswerListView{
    if (answerList) {
        [answerList removeFromSuperview];
        answerList = nil;
    }
}

#pragma mark
#pragma mark QuestionBrowserDelegate
- (NSUInteger)numberOfQuestionInQuestionBrowser:(QuestionBrowser *)questionBrowser{
    if (questionArr && questionArr.count > 0) {
        return questionArr.count;
    }
    return 0;
}

- (Question *)questionBrowser:(QuestionBrowser *)questionBrowser questionAtIndex:(NSUInteger)index{
    if (index < questionArr.count) {
        Question * question = [questionArr objectAtIndex:index];
        return question;
    }
    return nil;
}

-(void)reloadData{
    [self initQuestionData];
}

//
-(void)finishExam{
    [self addQuestionResultView];
}
#pragma mark
#pragma mark QuestionProtocol
-(void)enterQuestionWithIndex:(NSInteger)index{
    [UIView animateWithDuration:1.0
                     animations:^{
                         if (questionBrowser) {
                             [questionBrowser jumpToQuestionIndex:index];
                             [questionBrowser swithcExamType:FREEDOM_EXAM];
                         }
                         CGRect rect = questionResultView.frame;
                         rect.origin.x = CGRectGetMaxX(self.view.frame);
                         questionResultView.frame = rect;
                     }
                     completion:^(BOOL finished){
                         [questionResultView removeFromSuperview];
                         [questionResultView release];
                         questionResultView = nil;
                         
                     }];
    self.viewTag = 1;
    
}

-(void)exitQuestion:(NSInteger)viewType{
    if (questionResultView) {
        [questionResultView removeFromSuperview];
        [questionResultView release];
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */


#pragma mark gridView delegate methods

#pragma mark gridView datasource methods

- (CGFloat) gridView:(UIGridView *)grid widthForColumnAt:(int)columnIndex
{
	return CGRectGetWidth(self.view.bounds) / 6;
}

- (CGFloat) gridView:(UIGridView *)grid heightForRowAt:(int)rowIndex
{
	return CGRectGetWidth(self.view.bounds) / 6;
}

- (NSInteger) numberOfColumnsOfGridView:(UIGridView *) grid
{
	return 6;
}

- (NSInteger) numberOfCellsOfGridView:(UIGridView *) grid
{
	return questionArr.count;
}

- (QuestionCell *) gridView:(UIGridView *)grid cellForRowAt:(int)rowIndex AndColumnAt:(int)columnIndex
{
	QuestionCell *cell = (QuestionCell *)[grid dequeueReusableCell];
	
	if (cell == nil) {
        float width = CGRectGetWidth(self.view.bounds) / 6;
        float heigth = CGRectGetWidth(self.view.bounds) / 6;
		cell = [[QuestionCell alloc] initWithFrame:CGRectMake(0, 0, width, heigth)];
	}
	NSInteger num = rowIndex * 6 + columnIndex;
    cell.num = num + 1;
    
    Question *question = [questionArr objectAtIndex:num];
    HistoryRecord *record = question.historyRecord;
    //0表示未做；1表示正确;2表示错误
    if (record) {
        if (record.score == 1.0) {
            cell.state = 1;
        }
        else{
            cell.state = 2;
        }
    }
    else {
        cell.state = 0;
    }
    
	return cell;
}

- (void) gridView:(UIGridView *)grid didSelectRowAt:(int)rowIndex AndColumnAt:(int)colIndex
{
    NSInteger num = rowIndex * 6 + colIndex;
    if (questionBrowser) {
        [questionBrowser swithcExamType:FREEDOM_EXAM];
        [questionBrowser jumpToQuestionIndex:num];
    }
    [self removeAnswerListView];
    viewTag = 1;
}

@end

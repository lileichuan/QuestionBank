//
//  ViewController.m
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-8.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import "ViewController.h"

#import "QuestionView.h"
#import "Question.h"
#import "QuestionDAO.h"
#import "QuestionInterface.h"
#import "TestPaper.h"
#import "ChapterDao.h"
#import "Chapter.h"
#import "MainView.h"

#import "ChapterViewController.h"
#import "ExamViewController.h"
#import "HotspotViewController.h"
#import "AnswerRecordViewController.h"
#import "RankingViewController.h"

#import "InterfaceService.h"
#import "UserInfo.h"
#import "UserInfoDao.h"
#import "CompanyViewController.h"
#import "REFrostedViewController.h"


#define MAIN_RECT CGRectMake(0,20,CGRectGetWidth(self.view.bounds),CGRectGetHeight(self.view.bounds) -20)
@interface ViewController (){
    MainView           *mainView;

    
    EXAM_TYPE  examType;
    
    
}

@end

@implementation ViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor colorWithRed:156/255.0 green:28/255.5 blue:27/255.0 alpha:1.0];//    float startX = 20;
    //[self addMainView];
//    for (NSInteger i = 1; i < 7; i++) {
//        [self setDataWithChapterNum:i];
//    }
}
-(void)dealloc{
    
    [super dealloc];
}
-(void)viewDidAppear:(BOOL)animated{
    //    CGRect frame = self.view.frame;
    //    float systemVersion = 7.0;
    //    if ([[UIDevice currentDevice].systemVersion floatValue] >= systemVersion) {
    //        frame.origin.y = 20;
    //        frame.size.height = self.view.frame.size.height - 20;
    //        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    //    } else {
    //        frame.origin.x = 0;
    //    }
    //    self.view.frame = frame;
    
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setDataWithChapterNum:(NSInteger)num{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    QuestionDAO *qDao = [[QuestionDAO alloc]init];
    NSInteger chapterID = 10000 * num;
    NSInteger startID = 10000 * num;
    NSInteger answerID =100000 * num;
    NSString *filePath = nil;
    NSString *fileName = [NSString stringWithFormat:@"Question%d",num];
    filePath = [[NSBundle mainBundle]pathForResource:fileName ofType:@"txt"];
    NSString *chapterName = nil;
    switch (num) {
        case 1:
            chapterName = @"第一章《中国特色社会主义》练习题";
            break;
        case 2:
            chapterName = @"第二章《马克思主义新闻观》练习题";
            break;
        case 3:
            chapterName = @"第三章《新闻伦理》练习题";
            break;
        case 4:
            chapterName = @"第四章《新闻法规》练习题";
            break;
        case 5:
            chapterName = @"第五章《新闻采编规范》练习题";
            break;
        case 6:
            chapterName = @"第六章《防止虚假新闻》练习题";
            break;
            
        default:
            break;
    }
    ChapterDao *chapterDao  =[[ChapterDao alloc]init];
    Chapter *chapter = [[Chapter alloc]init];
    chapter.ID = chapterID;
    chapter.name = chapterName;
    [chapterDao insertChapter:chapter];
    [chapter release];
    [chapterDao release];
    NSString *questionContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSArray *optionTypeArr =[questionContent componentsSeparatedByString:@"#"];//选择题类型
    for (NSInteger i = 0; i < optionTypeArr.count; i ++) {
        NSString *questions = [optionTypeArr objectAtIndex:i];
        NSMutableArray *dataArr =[NSMutableArray arrayWithArray: [questions componentsSeparatedByString:@"@"]];
        for (NSInteger j = 0; j < dataArr.count; j++) {
            NSString *content = [dataArr objectAtIndex:j];
            NSMutableArray *arr =[NSMutableArray arrayWithArray: [content componentsSeparatedByString:@"\n"]];
            if ([[arr objectAtIndex:0] isEqualToString:@"\r"] || [[arr objectAtIndex:0] isEqualToString:@","]) {
                [arr removeObjectAtIndex:0];
            }

            Question *question = [[Question alloc]init];
            question.questionID = startID;
            question.optionType = i;
            NSString *title = [arr objectAtIndex:0];
            NSRange range0 = [title rangeOfString:@"."];
            title = [title substringFromIndex:range0.location + 1];
            NSRange range = [title rangeOfString:@"("];
            question.question =[title substringToIndex:range.location];
            
            
            NSString *answer =[title substringFromIndex:range.location + 1];
            NSRange range1 = [answer rangeOfString:@")"];
            answer = [[answer substringToIndex:range1.location]  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            NSMutableArray *answerArr = [[NSMutableArray alloc]init];
            
            if (question.optionType == SINGLE_CHOOSE) {
                for (NSInteger k = 1; k < arr.count; k ++) {
                    NSString *option = [arr objectAtIndex:k];
                    Answer *optionAnswer = [[Answer alloc]init];
                    optionAnswer.ID = answerID;
                    NSRange rangeOption = NSMakeRange(0,1);
                    NSString *option1 = [option substringWithRange:rangeOption];
                    if ([option1 isEqualToString:answer]) {
                        optionAnswer.score = 1.0;
                    }
                    else{
                        optionAnswer.score = 0.0;
                    }
                    
                    optionAnswer.questionID = startID;
                    optionAnswer.content = [option substringFromIndex:2];
                    [answerArr addObject:optionAnswer];
                    [optionAnswer release];
                    answerID +=1;
           
                }
            }
            else if(question.optionType == MUTABLE_CHOOSE ){
                if (answer.length !=3) {
                   float  avScore= 1.0 / answer.length;
                    for (NSInteger k = 1; k < arr.count; k ++) {
                        NSString *option = [arr objectAtIndex:k];
                        Answer *optionAnswer = [[Answer alloc]init];
                        optionAnswer.ID = answerID;
                        NSRange rangeOption = NSMakeRange(0,1);
                        
                        NSString *option1 = [option substringWithRange:rangeOption];
                        NSRange range = [answer rangeOfString:option1];
                        if (range.location != NSNotFound) {
                            optionAnswer.score = avScore;
                        }
                        else{
                            optionAnswer.score = 0.0;
                        }
                        optionAnswer.questionID = startID;
                        optionAnswer.content = [option substringFromIndex:2];
                        [answerArr addObject:optionAnswer];
                        [optionAnswer release];
                        answerID +=1;
                    }
                }
                else{
                    NSInteger correctFlag = 0;
                    for (NSInteger k = 1; k < arr.count; k ++) {
                        NSString *option = [arr objectAtIndex:k];
                        Answer *optionAnswer = [[Answer alloc]init];
                        optionAnswer.ID = answerID;
                        NSRange rangeOption = NSMakeRange(0,1);
                        
                        NSString *option1 = [option substringWithRange:rangeOption];
                        NSLog(@"*********************************************");
                      
                        NSRange range = [answer rangeOfString:option1];
                        if (range.location != NSNotFound) {
                            if (correctFlag == 0) {
                                optionAnswer.score = 0.20;
                            }
                            else if(correctFlag == 1){
                                 optionAnswer.score = 0.30;
                            }
                            else if(correctFlag == 2){
                                optionAnswer.score = 0.50;
                            }
                            correctFlag ++;
                        }
                        else{
                            optionAnswer.score = 0.0;
                        }
                          NSLog(@"option1 is:%@ and answer is:%@ and cur option answer is:%f",option1,answer,optionAnswer.score);
                        optionAnswer.questionID = startID;
                        optionAnswer.content = [option substringFromIndex:2];
                        [answerArr addObject:optionAnswer];
                        [optionAnswer release];
                        answerID +=1;
                    }
                }
                

            }
            else if(question.optionType == TRUE_FALSE){
                for (NSInteger k = 0; k < 2; k ++) {
                    Answer *optionAnswer = [[Answer alloc]init];
                    optionAnswer.ID = answerID;
                    optionAnswer.questionID = startID;
                    NSString *content;
                    if (k == 0) {
                        content = @"错误";
                    }
                    else{
                         content = @"正确";
                    }
                    if ([answer isEqualToString:@"√"]) {
                        if (k == 0) {
                             optionAnswer.score = 0.0;
                        }
                        else if (k == 1){
                             optionAnswer.score = 1.0;
                        }
                       
                    }
                    else if([answer isEqualToString:@"×"]){
                        if (k == 0) {
                            optionAnswer.score = 1.0;
                        }
                        else if (k == 1){
                            optionAnswer.score = 0.0;
                        }
                    }
                    optionAnswer.content = content;
                    [answerArr addObject:optionAnswer];
                    [optionAnswer release];
                    answerID +=1;
    
                }
            }
            startID +=1;
            question.answerArr = answerArr;
            [answerArr release];
            question.mediaType = 0;
            question.explain = @"无";
            question.chapterID = chapterID;
            [qDao insertQuestion:question];
            [question release];
        }
        
    }
    [qDao release];
    qDao = nil;
    [pool release];
}

-(IBAction)loadFunctionView:(id)sender{
    UIButton *btn = sender;
    id transition = nil;
    id viewController = nil;
    examType = (EXAM_TYPE)btn.tag;
    switch (examType) {
        case MOCK_EXAM:{
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *userID = [userDefaults objectForKey:@"userID"];
            if (!userID) {
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"您还没有设置个人信息" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"前去设置", nil];
                [alert show];
                [alert release];
                //[self loadRegister];
                return;
            }
           
            viewController =  [self.storyboard instantiateViewControllerWithIdentifier:@"Exam"];
        }
        break;
        case HOT_SPORT:{
             viewController =  [self.storyboard instantiateViewControllerWithIdentifier:@"Hotspot"];
        }
            break;
        case FREEDOM_EXAM:
        case ERROR_BOOK:
        case START_BOOK:{
    
            viewController =  [self.storyboard instantiateViewControllerWithIdentifier:@"Chapter"];
            [viewController initChapterWithType:examType];
        }
            break;
        case ANSWER_RECORD:
        {
           viewController =  [self.storyboard instantiateViewControllerWithIdentifier:@"AnswerRecord"];
            
        }
            break;
        case RANGKING:{
             viewController =  [self.storyboard instantiateViewControllerWithIdentifier:@"Ranking"];
        }
            break;
        default:
            break;
    }
//     transition = [[DMScaleTransition alloc]init];
//    [viewController setTransitioningDelegate:transition];
//    [transition autorelease];
    [self presentViewController:viewController animated:YES completion:^{
        
    }];
    //[viewController release];
    
}

-(void)addMainView{
    if (!mainView) {
        mainView  = [[MainView alloc]initWithFrame:MAIN_RECT];
        //[mainView addTarget:self action:@selector(loadFunctionView:) forControlEvents:UIControlEventTouchUpInside];
        //self.view = mainView;
        [self.view addSubview:mainView];
        [mainView release];
    }
}

-(IBAction)openJizheHome:(id)sender{
     [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.jizhehome.com/"]];
}

-(IBAction)loadUserCenter:(id)sender;{
     [self.frostedViewController presentMenuViewController];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(enterExamViewController) name:@"FinishRegist" object:nil];
        CompanyViewController *companyViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"register"];
        [self presentViewController:companyViewController animated:YES completion:NULL];
    }
}

-(void)enterExamViewController{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"FinishRegist" object:nil];
    ExamViewController  *viewController =  [self.storyboard instantiateViewControllerWithIdentifier:@"Exam"];
    [self presentViewController:viewController animated:YES completion:^{
        
    }];
}

//- (IBAction)goAction:(id)sender
//{
//    primaryView.userInteractionEnabled=NO;
//    
//    [UIView animateWithDuration:0.3 animations:^{
//        secondaryView.frame = CGRectMake(0, primaryView.frame.size.height - secondaryView.frame.size.height, secondaryView.frame.size.width, secondaryView.frame.size.height);
//        
//        CALayer *layer = primaryView.layer;
//        layer.zPosition = -4000;
//        CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
//        rotationAndPerspectiveTransform.m34 = 1.0 / -300;
//        layer.transform = CATransform3DRotate(rotationAndPerspectiveTransform, 10.0f * M_PI / 180.0f, 1.0f, 0.0f, 0.0f);
//        
//        primaryShadeView.alpha = 0.35;
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.3 animations:^{
//            primaryView.transform = CGAffineTransformMakeScale(0.9, 0.9);
//            
//            primaryShadeView.alpha = 0.5;
//        }];
//    }];
//}
//
//- (IBAction)undoAction:(id)sender
//{
//    primaryView.userInteractionEnabled=YES;
//    
//    [UIView animateWithDuration:0.3 animations:^{
//        CALayer *layer = primaryView.layer;
//        layer.zPosition = -4000;
//        CATransform3D rotationAndPerspectiveTransform = CATransform3DIdentity;
//        rotationAndPerspectiveTransform.m34 = 1.0 / 300;
//        layer.transform = CATransform3DRotate(rotationAndPerspectiveTransform, -10.0f * M_PI / 180.0f, 1.0f, 0.0f, 0.0f);
//        
//        primaryShadeView.alpha = 0.35;
//    } completion:^(BOOL finished) {
//        [UIView animateWithDuration:0.3 animations:^{
//            primaryView.transform = CGAffineTransformMakeScale(1.0, 1.0);
//            
//            primaryShadeView.alpha = 0.0;
//            
//            secondaryView.frame = CGRectMake(0, primaryView.frame.size.height, secondaryView.frame.size.width, secondaryView.frame.size.height);
//        }];
//    }];
//}
//


@end

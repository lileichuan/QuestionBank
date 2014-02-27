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



-(IBAction)loadFunctionView:(id)sender{
    UIButton *btn = sender;
    id viewController = nil;
    examType = (EXAM_TYPE)btn.tag;
    switch (examType) {
        case MOCK_EXAM:{
            
            NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
            NSString *userID = [userDefaults objectForKey:@"user_ID"];
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

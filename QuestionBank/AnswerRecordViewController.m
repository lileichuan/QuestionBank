//
//  AnswerRecordViewController.m
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-3.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "AnswerRecordViewController.h"
#import "TopView.h"
#import "QuestionInterface.h"
#import "NTChartView.h"
#import "TestPaper.h"


@interface AnswerRecordViewController (){
    TopView    *topView;
    NSArray    *timeArr;
    NSArray    *correctArr;
    NSArray    *errorArr;
}

@end

@implementation AnswerRecordViewController

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
    [self initData];
    [self addTopBarView];
    if (timeArr.count > 0) {
        [self addCloumChart];
    }
}
- (BOOL)shouldAutorotate{
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    [super dealloc];
}

-(void)initData{
    NSArray *recordArr =[[QuestionInterface sharedQuestionInterface]getAllTestPape];
    NSMutableArray *tmpTime = [NSMutableArray arrayWithCapacity:5];
     NSMutableArray *tmpCorrect = [NSMutableArray arrayWithCapacity:5];
     NSMutableArray *tmpError = [NSMutableArray arrayWithCapacity:5];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateStyle = kCFDateFormatterShortStyle;
    dateFormatter.timeStyle = kCFDateFormatterShortStyle;
    //zzz表示时区，zzz可以删除，这样返回的日期字符将不包含时区信息。
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    //[dateFormatter setDateFormat:@"MM-dd HH:mm"];
    for (TestPaper *testPaper in recordArr) {
        NSString *destDateString = [dateFormatter stringFromDate:testPaper.createdTime];
        [tmpTime addObject:destDateString];
        [tmpError addObject:[NSNumber numberWithInteger:testPaper.errorNum]];
        [tmpCorrect addObject:[NSNumber numberWithInteger:testPaper.correctNum]];
    }
    timeArr = [tmpTime retain];
    correctArr = [tmpCorrect retain];
    errorArr = [tmpError retain];
    [dateFormatter release];

  }

-(void)close{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)addTopBarView{
    if (!topView) {
        CGRect topRect =   CGRectMake(0,20,CGRectGetWidth(self.view.bounds), TOP_BAR_HEIGHT);
        topView = [[TopView alloc]initWithFrame:topRect];
        [topView addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:topView];
        [topView  release];
    }
    topView.title.text = @"答题记录";
}

-(void)addCloumChart{
    CGRect contentRect =   CGRectMake(0,CGRectGetMaxY(topView.frame),CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(topView.frame) );
    
    NTChartView *v = [[NTChartView alloc] initWithFrame:contentRect];
//	
    NSArray *g = [NSArray arrayWithObjects:errorArr, correctArr, nil];
    NSArray *gt = [NSArray arrayWithObjects:@"错题数",@"正确数", nil];
    NSArray *ct = [NSArray arrayWithObjects:@"历次答题结果统计",@"", nil];
    
//    NSArray *g1 = [NSArray arrayWithObjects:
//                   [NSNumber numberWithFloat:78],
//                   [NSNumber numberWithFloat:82],
//                   
//                   [NSNumber numberWithFloat:90.2],
//                   [NSNumber numberWithFloat:94.1],
//                   [NSNumber numberWithFloat:92.5],
//                   [NSNumber numberWithFloat:93.9],
//                   [NSNumber numberWithFloat:95.2],
//                   [NSNumber numberWithFloat:93.5],nil];
//    
//    NSArray *g2 = [NSArray arrayWithObjects:
//                   [NSNumber numberWithFloat:38],
//                   [NSNumber numberWithFloat:42],
//                   [NSNumber numberWithFloat:50.2],
//                   [NSNumber numberWithFloat:54.1],
//                   [NSNumber numberWithFloat:52.5],
//                   [NSNumber numberWithFloat:53.9],
//                   [NSNumber numberWithFloat:55.2],
//                   [NSNumber numberWithFloat:53.5],nil];
//    
//    NSArray *g = [NSArray arrayWithObjects:g1, g2, nil];
//    
//    NSArray *gt = [NSArray arrayWithObjects:@"xxx",@"yyy", nil];
//    NSArray *xL = [NSArray arrayWithObjects:@"2002",@"2003",@"2004",@"2005",@"2006",@"2007",@"2008",@"2009", nil];
//    NSArray *ct = [NSArray arrayWithObjects:@"某某历年销量水平柱状图",@"", nil];
    
	v.groupData = g;
    v.groupTitle = gt;
    v.xAxisLabel = timeArr;
    v.chartTitle = ct;
	
    v.backgroundColor = [UIColor clearColor];
    v.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    
    [self.view addSubview:v];
	
	[v release];


}



@end

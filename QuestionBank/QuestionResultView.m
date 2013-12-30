//
//  QuestionResultView.m
//  QuestionBank
//
//  Created by hanbo on 13-12-19.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import "QuestionResultView.h"
#import "Question.h"

@implementation QuestionResultView
@synthesize delegate,questionArr,testPaper;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:254/255.0 green:244/255.0 blue:186/255.0 alpha:1.0];
    }
    return self;
}
-(void)dealloc{
    if (questionArr) {
        [questionArr release];
        questionArr = nil;
    }
    if (testPaper) {
        [testPaper release];
        testPaper = nil;
    }

    [super dealloc];
}

-(void)setTestPaper:(TestPaper *)_testPaper{
    testPaper = [_testPaper retain];
    [self addTranscriptView];
    [self addRestartBtn];
    [self addBottomView];
    self.questionArr = testPaper.questionArr;
}


-(void)addTranscriptView{
    if (!transcripView) {
        CGRect rect =   CGRectMake(0,TOP_BAR_HEIGHT,CGRectGetWidth(self.bounds),292);
        transcripView = [[TranscriptView alloc]initWithFrame:rect];
        [self addSubview:transcripView];
        NSDictionary *dic = @{@"score":[NSNumber numberWithFloat:testPaper.score],@"duration":[NSNumber numberWithInteger:testPaper.duration]};
        [transcripView configureTranscriptInfo:dic];

    }
}

-(void)removeTranscriptView{
    if (transcripView) {
        [transcripView removeFromSuperview];
        [transcripView release];
        transcripView = nil;
    }
    
}

-(void)addRestartBtn{
    float btnWidth = 77;
    float btnHight = 30;
    if (!restartBtn) {
        CGRect rect = CGRectMake(CGRectGetWidth(self.bounds)/2 - btnWidth/2,CGRectGetMaxY(transcripView.frame) + 5,btnWidth,btnHight);
        restartBtn = [UIButton  buttonWithType:UIButtonTypeCustom];
        restartBtn.frame = rect;
        [restartBtn addTarget:self action:@selector(restartExam:) forControlEvents:UIControlEventTouchUpInside];
        [restartBtn setImage:[UIImage imageNamed:@"restart.png"] forState:UIControlStateNormal];
        [self addSubview:restartBtn];
    }
}
                     


-(void)addBottomView{
    CGRect bottomRect = CGRectMake(0,CGRectGetHeight(self.bounds) - BOTTOM_BAR_HEIGHT,CGRectGetWidth(self.bounds),BOTTOM_BAR_HEIGHT);
    bottomView = [[BottomView alloc]initWithFrame:bottomRect];
    [bottomView addTarget:self action:@selector(loadQuestionResult:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:bottomView];
    [bottomView setLeftImage:[UIImage imageNamed:@"show_answer.png"] withTitle:@"查看答案"];
    [bottomView setRightImage:[UIImage imageNamed:@"rank.png"] withTitle:@"排行榜"];
}

-(void)loadQuestionResult:(id)sender{
    if (self.answerListBlock) {
        self.answerListBlock();
    }
    
}

-(void)restartExam:(id)sender{
    if (self.restartBlock) {
        self.restartBlock();
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

@end

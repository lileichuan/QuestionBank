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
//        self.backgroundColor = [UIColor colorWithRed:254/255.0 green:244/255.0 blue:186/255.0 alpha:1.0];
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
    self.backgroundColor = [UIColor blackColor];
    UIImageView *topImageView = [[UIImageView alloc]initWithFrame:self.bounds];
    //topImageView.contentMode = UIViewContentModeScaleAspectFill;
     topImageView.image = [UIImage imageNamed:@"answer_result.png"];
    [self addSubview:topImageView];
    [topImageView release];
    
    UIImageView *resultImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMidX(self.frame) - 60,65 ,120 , 22)];
    [self addSubview:resultImageView];
    [resultImageView release];
    
    UIImage *resultImage = nil;
    float score = testPaper.score;
    NSInteger duration =testPaper.duration;
  
    if (score < 60) {
        resultImage = [UIImage imageNamed:@"less60.png"];
    }
    else if(score >= 60 && score < 70){
       resultImage = [UIImage imageNamed:@"less70.png"];
    }
    else if(score >= 70 && score < 80){
        resultImage = [UIImage imageNamed:@"less80.png"];
    }
    else if(score >= 80 && score < 90){
        resultImage = [UIImage imageNamed:@"less90.png"];
    }
    else if(score >= 90 && score < 100){
       resultImage = [UIImage imageNamed:@"less90.png"];
    }
    else if(score == 100){
      resultImage = [UIImage imageNamed:@"100.png"];
        
    }
    resultImageView.image = resultImage;
    CGRect scoreRect = CGRectMake(165,188,90,20 );
     UILabel * scoreLabel = [[UILabel alloc]initWithFrame:scoreRect];
    scoreLabel.font =[UIFont systemFontOfSize:18];
    scoreLabel.textAlignment = NSTextAlignmentCenter;
    scoreLabel.backgroundColor = [UIColor clearColor];
    scoreLabel.textColor = [UIColor redColor];
    [self addSubview:scoreLabel];
    scoreLabel.text = [NSString stringWithFormat:@"%1f",score];
    [scoreLabel release];
    
    CGRect durationRect = CGRectMake(165,228,90,20);
    UILabel *durationLabel = [[UILabel alloc]initWithFrame:durationRect];
    durationLabel.font =[UIFont systemFontOfSize:18];
    durationLabel.textAlignment = NSTextAlignmentCenter;
    durationLabel.backgroundColor = [UIColor clearColor];
    durationLabel.textColor = [UIColor redColor];
    [self addSubview:durationLabel];
    [durationLabel release];
    NSString *useTime = [NSString stringWithFormat:@"%ld分%ld秒",duration/60,duration%60];
//     NSString *useTime = [NSString stringWithFormat:@"%ld:ld",duration/60,duration%60];
//    NSInteger mini = duration/60;
//    if (mini == 0) {
//         NSString *useTime = [NSString stringWithFormat:@"%ld:ld",duration/60,duration%60];
//    }else{

//    }
   
    durationLabel.text = [NSString stringWithFormat:@"%@",useTime];
}


-(void)addRestartBtn{
    float btnWidth = 77;
    float btnHight = 30;
    if (!restartBtn) {
        CGRect rect = CGRectMake(CGRectGetWidth(self.bounds)/2 - btnWidth/2,258,btnWidth,btnHight);
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
    UIButton *btn = sender;
    if (btn.tag == RANGKING) {
        if (self.rankBlock) {
            self.rankBlock();
        }
    }
    else if(btn.tag == ANSWER_LIST){
        if (self.answerListBlock) {
            self.answerListBlock();
        }
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

//
//  QuestionBottomView.m
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-11.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import "QuestionBottomView.h"

@implementation QuestionBottomView
@synthesize examType;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor colorWithRed:156/255.0 green:28/255.5 blue:27/255.0 alpha:1.0];
        [self addSubViews];
    }
    return self;
}
-(void)setExamType:(EXAM_TYPE)_examType{
    examType = _examType;
    switch (examType) {
        case MOCK_EXAM:
        {
            [showAnswerBtn setBtnImage:[UIImage imageNamed:@"finish_exam.png"]];
            [showAnswerBtn setBtnTitle:@"交卷"];
            numLabel.text = @"90:00";
            showAnswerBtn.tag = 5;
        }
            break;
        case FREEDOM_EXAM:
            break;
        case ERROR_BOOK:{
            starBtn.tag = 4;
            [starBtn setBtnImage:[UIImage imageNamed:@"remove_error_book.png"]];
            [starBtn setBtnTitle:@"移除错题"];
        }
            break;
        case START_BOOK:{
            [starBtn setBtnImage:[UIImage imageNamed:@"star_question_y.png"]];
            [starBtn setBtnTitle:@"移除收藏"];
        }
            break;
        default:
            break;
    }
}
-(void)addSubViews{
    float height =42;
    float width = 42;
    float startY = CGRectGetHeight(self.bounds) - height - 6;
    if (!preBtn) {
        CGRect preBtnRect = CGRectMake(10,startY,width, height);
        preBtn = [TIButton buttonWithType:UIButtonTypeCustom];
        preBtn.frame = preBtnRect;
        [preBtn setBtnImage:[UIImage imageNamed:@"pre_question.png"]];
        [preBtn setBtnTitle:@"上一题"];
        preBtn.tag = 0;
        [self addSubview:preBtn];
    }
    if (!showAnswerBtn) {
        CGRect preBtnRect = CGRectMake(CGRectGetMaxX(preBtn.frame) +10,startY,width, height);
        showAnswerBtn =  [TIButton buttonWithType:UIButtonTypeCustom];
        showAnswerBtn.frame = preBtnRect;
        [showAnswerBtn setBtnImage:[UIImage imageNamed:@"show_answer.png"]];
        [showAnswerBtn setBtnTitle:@"查看答案"];
        showAnswerBtn.tag = 1;
        [self addSubview:showAnswerBtn];
    }
    if (!nextBtn) {
        CGRect nextBtnRect = CGRectMake(CGRectGetWidth(self.bounds) - width - 10,startY,width, height);
        nextBtn = [TIButton buttonWithType:UIButtonTypeCustom];
        nextBtn.frame = nextBtnRect;
        [nextBtn setBtnImage:[UIImage imageNamed:@"next_question.png"]];
        [nextBtn setBtnTitle:@"下一题"];
        nextBtn.tag = 3;
        [self addSubview:nextBtn];
    }
    if (!starBtn) {
        CGRect nextBtnRect = CGRectMake(CGRectGetMinX(nextBtn.frame) - width - 10,startY,width, height);
        starBtn = [TIButton buttonWithType:UIButtonTypeCustom];
        starBtn.frame = nextBtnRect;
        [starBtn setBtnImage:[UIImage imageNamed:@"star_question_n.png"]];
        [starBtn setBtnTitle:@"收藏"];
        starBtn.tag = 2;
        [self addSubview:starBtn];
    }
    if (!numLabel) {
        numLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(showAnswerBtn.frame),0,CGRectGetWidth(self.frame) - 4 * CGRectGetWidth(preBtn.frame) - 20,CGRectGetHeight(self.frame))];
        numLabel.font =[UIFont systemFontOfSize:14];
        numLabel.backgroundColor = [UIColor clearColor];
        numLabel.textColor = [UIColor whiteColor];
        numLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:numLabel];
        [numLabel release];
    }
}

-(void)dealloc{
    if (nextBtn) {
        [nextBtn removeFromSuperview];
        nextBtn = nil;
    }
    if (preBtn) {
        [preBtn removeFromSuperview];
        preBtn =nil;
    }
    if (numLabel) {
        [numLabel removeFromSuperview];
        numLabel = nil;
    }
    [super dealloc];
}

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    [preBtn addTarget:target action:action forControlEvents:controlEvents];
    [showAnswerBtn addTarget:target action:action forControlEvents:controlEvents];
    [starBtn addTarget:target action:action forControlEvents:controlEvents];
    [nextBtn addTarget:target action:action forControlEvents:controlEvents];
}

-(void)configureQuestionInfo:(NSDictionary *)info{
    BOOL isShowPreBtn = [[info objectForKey:@"isShowPreBtn"]boolValue];
    BOOL isShowNextBtn = [[info objectForKey:@"isShowNextBtn"]boolValue];
    preBtn.enabled = isShowPreBtn;
    nextBtn.enabled = isShowNextBtn;
    BOOL isStar = [[info objectForKey:@"isStar"]boolValue];
    switch (examType) {
            
        case MOCK_EXAM:
        case START_BOOK:
        case FREEDOM_EXAM:{
            if (isStar) {
                [starBtn setBtnImage:[UIImage imageNamed:@"star_question_y.png"]];
                [starBtn setBtnTitle:@"取消收藏"];
            }
            else{
                [starBtn setBtnImage:[UIImage imageNamed:@"star_question_n.png"]];
                [starBtn setBtnTitle:@"收藏"];
            }
        }
            break;
        case ERROR_BOOK:
            break;

        default:
            break;
    }
    if (examType != MOCK_EXAM ) {
        NSString *numTitle = [info objectForKey:@"title"];
        numLabel.text = numTitle;
    }
}

-(void)updateExamTime:(NSString *)examTime{
    numLabel.text = examTime;
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

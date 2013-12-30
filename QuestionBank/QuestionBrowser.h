//
//  QuestionBrowser.h
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-9.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionProtocol.h"
@class QuestionBrowser;
@class Question;
@protocol QuestionBrowserDelegate <NSObject>
- (NSUInteger)numberOfQuestionInQuestionBrowser:(QuestionBrowser *)questionBrowser;
- (Question *)questionBrowser:(QuestionBrowser *)questionBrowser questionAtIndex:(NSUInteger)index;
@optional
-(void)updateQuestionData;
-(void)finishExam;
@end

@interface QuestionBrowser : UIView<UIScrollViewDelegate,QuestionProtocol,UIAlertViewDelegate>{
    id <QuestionBrowserDelegate> _delegate;
    
    EXAM_TYPE  answerType;
    NSArray *_questionData; // Depreciated

}
@property (nonatomic, assign) id <QuestionBrowserDelegate> _delegate;
@property (nonatomic, assign)  EXAM_TYPE  answerType;
@property (nonatomic, retain)  NSArray *_questionData; // Depreciated
- (id)initWithQuestions:(NSArray *)questions  __attribute__((deprecated)); // Depreciated
- (id)initWithFrame:(CGRect)frame
       withDelegate:(id <QuestionBrowserDelegate>)delegate
     withAnswerType:(EXAM_TYPE)type;

- (void)jumpToQuestionIndex:(NSInteger)index;

- (void)reloadData;

-(void)swithcExamType:(EXAM_TYPE)type;
@end

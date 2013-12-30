//
//  QuestionDAO.h
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-9.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDao.h"
#import "Question.h"
#import "HistoryRecordDao.h"
#import "HistoryRecord.h"
#import "AnswerDao.h"
@interface QuestionDAO : BaseDao{
    HistoryRecordDao *hrDao;
    AnswerDao *answerDao;
}

-(BOOL)insertQuestion:(Question *)_question;

-(BOOL)updateQuestonWithStar:(BOOL)star withQuestionID:(NSInteger)questionID;

-(BOOL)updateQuestonWithEror:(BOOL)error withQuestionID:(NSInteger)questionID;

-(Question *)getQuestionWithID:(NSString *)questionID;

-(NSArray*)getQuestionWithChapterID:(NSInteger)chapterID withExamType:(EXAM_TYPE)type;

-(NSInteger)getQuestionAmountWithChapterID:(NSInteger)chapterID withExamType:(EXAM_TYPE)type;

-(NSArray *)generateMockExamWithMode:(NSInteger)mode;

-(NSArray *)getWrongQuestions;

-(NSArray *)getStarQuestions;
@end

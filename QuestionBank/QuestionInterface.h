//
//  QuestionRecordManager.h
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-14.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "QuestionDAO.h"
#import "HistoryRecord.h"
#import "TestPaper.h"
#import "TestPaperDao.h"
#import "ChapterDao.h"

@interface QuestionInterface : NSObject{
    
    TestPaper  *testPaper;

}

+(QuestionInterface *)sharedQuestionInterface;


-(void)closeQuestionInterface;


-(BOOL)updateQuestonWithStar:(BOOL)star withQuestionID:(NSInteger)questionID;

-(BOOL)updateQuestonWithError:(BOOL)error withQuestionID:(NSInteger)questionID;

-(NSArray *)getQuestionsWithChapter:(NSInteger)chapter;

-(BOOL)addHistoryRecord:(HistoryRecord*)_historyRecord;

-(NSArray*)getQuestionWithChapterID:(NSInteger)chapterID withExamType:(EXAM_TYPE)type;

-(NSArray *)gtChaptersWithAnswerType:(EXAM_TYPE)type;

-(TestPaper *)generateTestPaper;

-(TestPaper *)getCurTestPaper;

-(void)updateTestPaperInfo:(NSDictionary *)info;

-(BOOL)insertTestPaper;
@end

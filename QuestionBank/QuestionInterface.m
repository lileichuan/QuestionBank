//
//  QuestionRecordManager.m
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-14.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import "QuestionInterface.h"
#import "HistoryRecordDao.h"
#import "HistoryRecord.h"
#import "Chapter.h"
@implementation QuestionInterface
QuestionInterface *questionInterface;
+(QuestionInterface *) sharedQuestionInterface{
    if (!questionInterface) {
		questionInterface = [[QuestionInterface alloc] init];
	}
	return questionInterface;
}
-(void)closeQuestionInterface{
    if (questionInterface) {
        [questionInterface release];
        questionInterface = nil;
    }
}

-(BOOL)updateQuestonWithStar:(BOOL)star withQuestionID:(NSInteger)questionID{
    QuestionDAO *qDao =[[QuestionDAO alloc]init];
    BOOL success = [qDao updateQuestonWithStar:star withQuestionID:questionID];
    [qDao release];
    qDao = nil;
    return success;
}

-(BOOL)updateQuestonWithError:(BOOL)error withQuestionID:(NSInteger)questionID{
    QuestionDAO *qDao =[[QuestionDAO alloc]init];
    BOOL success = [qDao updateQuestonWithEror:error withQuestionID:questionID];
    [qDao release];
    qDao = nil;
    return success;
}

-(NSArray*)getQuestionWithChapterID:(NSInteger)chapterID withExamType:(EXAM_TYPE)type{
    QuestionDAO *qDao =[[QuestionDAO alloc]init];
    NSArray *arr = [qDao getQuestionWithChapterID:chapterID withExamType:type];
    [qDao release];
    qDao = nil;
    return arr;
}

-(NSArray *)gtChaptersWithAnswerType:(EXAM_TYPE)type{
    ChapterDao *chapterDao =[[ChapterDao alloc]init];
   NSArray *arr = [chapterDao getAllChapterWithExamType:type];
    [chapterDao release];
    chapterDao = nil;
    return arr;
    
}

-(NSArray *)generateMockExamWithMode:(NSInteger)mode{
    QuestionDAO *qDao =[[QuestionDAO alloc]init];
    NSArray *arr = [qDao generateMockExamWithMode:mode];
    [qDao release];
    qDao = nil;
    return arr;
}

-(BOOL)addHistoryRecord:(HistoryRecord*)_historyRecord{
    BOOL success  = NO;
    HistoryRecordDao *hisDao = [[HistoryRecordDao alloc]init];
    BOOL isHas = [hisDao inHasCurRecored:_historyRecord.questionID withPaperID:testPaper.paperID];
    _historyRecord.testPaperID = testPaper.paperID;
    if (isHas) {
        [ hisDao updateHisrtoryRecord:_historyRecord];
    }
    else{
        [hisDao insertHistoryRecord:_historyRecord];
    }
    return success;
}

-(NSArray *)getAllTestPape{
    TestPaperDao *testPaperDao = [[TestPaperDao alloc]init];
    NSArray *arr = [testPaperDao getAllTestPaper];
    [testPaperDao release];
    return arr;
}

-(TestPaper *)generateTestPaper{
    if (testPaper) {
        [testPaper release];
        testPaper = nil;
    }
    testPaper = [[TestPaper alloc]init];
    testPaper.questionArr = [self generateMockExamWithMode:MOCK_EXAM];
    testPaper.unWriteNum = testPaper.questionArr.count;
    testPaper.createdTime = [NSDate date];
    TestPaperDao *testPaperDao = [[TestPaperDao alloc]init];
    testPaper.paperID =  [testPaperDao getTestPaperCount] + 1;
    [testPaperDao release];
    return testPaper;
}

-(TestPaper *)getCurTestPaper{
    return testPaper;
}

-(BOOL)saveTestPaper{
    BOOL success = NO;
    if (testPaper) {
        TestPaperDao *testPaperDao = [[TestPaperDao alloc]init];
        success = [testPaperDao insertTestPaper:testPaper];
        [testPaperDao release];
    }
    return success;
}


@end

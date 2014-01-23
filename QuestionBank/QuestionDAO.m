//
//  QuestionDAO.m
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-9.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import "QuestionDAO.h"
#define TABLE_NAME @"question"
@implementation QuestionDAO

-(id)init{
    self = [super init];
    if (self) {
        hrDao = [[HistoryRecordDao alloc]init];
        answerDao = [[AnswerDao alloc]init];
    }
    return self;
}

-(void)dealloc{
    if (hrDao) {
        [hrDao release];
        hrDao = nil;
    }
    if (answerDao) {
        [answerDao release];
        answerDao = nil;
    }
    [super dealloc];
}

-(BOOL)insertQuestion:(Question *)_question{
    BOOL success = YES;
	[db executeUpdate:[self SQL:@"INSERT INTO %@ (id,option_type,media_type,chapter_id,section_id,question,explain,star,error) VALUES(?,?,?,?,?,?,?,?,?)" inTable:TABLE_NAME],
     [NSNumber numberWithInteger:_question.questionID],
     [NSNumber numberWithInteger:_question.optionType],
     [NSNumber numberWithInteger:_question.mediaType],
     [NSNumber numberWithInteger:_question.chapterID],
     [NSNumber numberWithInteger:_question.sectionID],
     _question.question,
     _question.explain,
     [NSNumber numberWithBool:_question.star],
     [NSNumber numberWithBool:_question.error]
     ];
    for (Answer *answer in _question.answerArr) {
        BOOL result = [answerDao insertAnswer:answer];
        if (result == NO) {
            success = result;
            break;
        }
    }
    if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
		success = NO;
    }
	return success;
}

-(BOOL)updateQuestonWithStar:(BOOL)star withQuestionID:(NSInteger)questionID{
    BOOL success = YES;
    [db executeUpdate:[self SQL:@"UPDATE %@ SET star =? WHERE id = ?" inTable:TABLE_NAME],
     [NSNumber numberWithBool:star],
     [NSNumber numberWithInteger:questionID]];
    if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
		success = NO;
    }
	return success;

}

-(BOOL)updateQuestonWithEror:(BOOL)error withQuestionID:(NSInteger)questionID{
    BOOL success = YES;
    [db executeUpdate:[self SQL:@"UPDATE %@ SET error =? WHERE id = ?" inTable:TABLE_NAME],
     [NSNumber numberWithBool:error],
     [NSNumber numberWithInteger:questionID]];
    if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
		success = NO;
    }
	return success;
}

-(Question *)getQuestionWithID:(NSString *)questionID{
    FMResultSet *rs =[db executeQuery:[self SQL:@"SELECT * FROM %@" inTable:TABLE_NAME]];
    Question *question = nil;
	while ([rs next]) {
       question = [self analysisQuesionWithRS:rs needHistoryRecord:YES];
    }
    if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
	}
    return question;
}

-(NSArray*)getQuestionWithChapterID:(NSInteger)chapterID withExamType:(EXAM_TYPE)type{
    NSMutableArray *questionArr = nil;
    FMResultSet *rs = nil;
    if (type == START_BOOK) {
        rs =[db executeQuery:[self SQL:@"SELECT * FROM %@ where chapter_id =? and star = 1" inTable:TABLE_NAME],
             [NSNumber numberWithInteger:chapterID]];
    }
    else if(type == ERROR_BOOK){
        rs =[db executeQuery:[self SQL:@"SELECT * FROM %@ where chapter_id =? and error = 1" inTable:TABLE_NAME],
             [NSNumber numberWithInteger:chapterID]];
    }
    else if(type == FREEDOM_EXAM){
        rs =[db executeQuery:[self SQL:@"SELECT * FROM %@ where chapter_id = ?" inTable:TABLE_NAME],[NSNumber numberWithInteger:chapterID]];
    }
	while ([rs next]) {
        if (!questionArr) {
            questionArr = [[[NSMutableArray alloc]initWithCapacity:10]autorelease];
        }
        Question *question = [self analysisQuesionWithRS:rs needHistoryRecord:NO];
        [questionArr addObject:question];
    }
    if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
	}
    return questionArr;
}

-(NSInteger)getQuestionAmountWithChapterID:(NSInteger)chapterID withExamType:(EXAM_TYPE)type{
    NSInteger amount = 0;
    FMResultSet *rs = nil;
    if (type == START_BOOK) {
        rs =[db executeQuery:[self SQL:@"SELECT * FROM %@ where chapter_id =? and star = 1" inTable:TABLE_NAME],
             [NSNumber numberWithInteger:chapterID]];
    }
    else if(type == ERROR_BOOK){
        rs =[db executeQuery:[self SQL:@"SELECT * FROM %@ where chapter_id =? and error = 1" inTable:TABLE_NAME],
             [NSNumber numberWithInteger:chapterID]];
    }
    else if(type == FREEDOM_EXAM){
        rs =[db executeQuery:[self SQL:@"SELECT * FROM %@ where chapter_id = ?" inTable:TABLE_NAME],[NSNumber numberWithInteger:chapterID]];
    }
	while ([rs next]) {
        amount ++;
    }
    if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
	}
    return amount;;
}

-(NSArray *)generateMockExamWithMode:(NSInteger)mode{
    NSMutableArray *questionArr = nil;
// 	FMResultSet *rs =[db executeQuery:[self SQL:@"SELECT * FROM %@ order by RANDOM()  limit 100 " inTable:TABLE_NAME]];
    for (NSInteger i = 0; i < 3; i++) {
        NSInteger amount = 30;
        if (i == 0) {
            amount = 40;
        }
        FMResultSet *rs =[db executeQuery:[self SQL:@"SELECT * FROM %@ where option_type = ? order  by RANDOM()  limit ? " inTable:TABLE_NAME],[NSNumber numberWithInteger:i],[NSNumber numberWithInteger:amount]];
        while ([rs next]) {
            if (!questionArr) {
                questionArr = [[[NSMutableArray alloc]initWithCapacity:10]autorelease];
            }
            Question *question = [self analysisQuesionWithRS:rs needHistoryRecord:NO];
            [questionArr addObject:question];
        }
    }

    if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
	}
    return questionArr;
}

-(NSArray *)getWrongQuestions{
    NSMutableArray *questionArr = nil;
 	FMResultSet *rs =[db executeQuery:[self SQL:@"SELECT * FROM %@ where error = 1" inTable:TABLE_NAME]];
	while ([rs next]) {
        if (!questionArr) {
            questionArr = [[[NSMutableArray alloc]initWithCapacity:10]autorelease];
        }
        Question *question = [self analysisQuesionWithRS:rs needHistoryRecord:NO];
        [questionArr addObject:question];
    }
    if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
	}
    return questionArr;
}



-(NSArray *)getStarQuestions{
    NSMutableArray *questionArr = nil;
 	FMResultSet *rs =[db executeQuery:[self SQL:@"SELECT * FROM %@ where star = 1" inTable:TABLE_NAME]];
	while ([rs next]) {
        if (!questionArr) {
            questionArr = [[[NSMutableArray alloc]initWithCapacity:10]autorelease];
        }
        Question *question = [self analysisQuesionWithRS:rs needHistoryRecord:NO];
        [questionArr addObject:question];
    }
    if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
	}
    return questionArr;
}

-(Question *)analysisQuesionWithRS:(FMResultSet*)rs needHistoryRecord:(BOOL)isNeed{
    Question *question =[[[Question alloc]init] autorelease];;
    question.questionID = [rs intForColumn:@"id"];
    question.optionType =[rs intForColumn:@"option_type"];
    question.mediaType = [rs intForColumn:@"media_type"];
    question.answerArr = [answerDao getQuestionAnswersWithID:question.questionID];
    question.chapterID = [rs intForColumn:@"chapter_id"];
    question.sectionID = [rs intForColumn:@"section_id"];
    question.star = [rs boolForColumn:@"star"];
    question.question = [rs stringForColumn:@"question"];
    question.explain = [rs stringForColumn:@"explain"];
    question.error = [rs boolForColumn:@"error"];
    if (isNeed) {
        question.historyRecord = [hrDao getHistoryRecordWithID:question.questionID];
    }
    return question;
}

@end

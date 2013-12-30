//
//  HistoryRecordDao.m
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-14.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import "HistoryRecordDao.h"
#import "HistoryRecord.h"
#define TABLE_NAME @"history_record"
@implementation HistoryRecordDao
-(BOOL)insertHistoryRecord:(HistoryRecord *)_historyRecord{
    BOOL success = YES;
	[db executeUpdate:[self SQL:@"INSERT INTO %@ (question_id,score,answer_ids,test_paper_id) VALUES(?,?,?,?)" inTable:TABLE_NAME],
     [NSNumber numberWithInteger:_historyRecord.questionID],
     [NSNumber numberWithFloat: _historyRecord.score],
     _historyRecord.answerIDs,
     [NSNumber numberWithInteger:_historyRecord.testPaperID]
     ];
    if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
		success = NO;
    }
	return success;
}

-(BOOL)inHasCurRecored:(NSInteger )recordID withPaperID:(NSInteger)paperID{
    FMResultSet *rs =[db executeQuery:[self SQL:@"SELECT * FROM %@ where question_id = ? and test_paper_id" inTable:TABLE_NAME],
                      [NSNumber numberWithInteger:recordID],
                      [NSNumber numberWithInteger:paperID]];
    BOOL isHas = NO;
	while ([rs next]) {
        isHas = YES;
        break;
    }
    if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
	}
    return isHas;
}

-(BOOL)updateHisrtoryRecord:(HistoryRecord*)_historyRecord{
    BOOL success = YES;
    [db executeUpdate:[self SQL:@"UPDATE %@ SET score =?,answer_ids=?,test_paper_id = ? WHERE question_id = ?" inTable:TABLE_NAME],
      [NSNumber numberWithFloat:_historyRecord.score],
     _historyRecord.answerIDs,
     [NSNumber numberWithInteger:_historyRecord.testPaperID],
     [NSNumber numberWithInteger:_historyRecord.questionID]];
    if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
		success = NO;
    }
	return success;
}

-(HistoryRecord *)getHistoryRecordWithID:(NSInteger)questionID{
    HistoryRecord *historyRecord = nil;
    FMResultSet *rs =[db executeQuery:[self SQL:@"SELECT * FROM %@ where question_id =?" inTable:TABLE_NAME],
                      [NSNumber numberWithInteger:questionID]];
	while ([rs next]) {
       historyRecord = [self analysisRecordWithRS:rs];
        break;
    }

    return historyRecord;
}

-(HistoryRecord *)analysisRecordWithRS:(FMResultSet*)rs{
    HistoryRecord *historyRecord = [[[HistoryRecord alloc]init]autorelease];
    historyRecord.questionID = [rs intForColumn:@"question_id"];
    historyRecord.score = [rs doubleForColumn:@"score"];
    historyRecord.answerIDs = [rs stringForColumn:@"answer_ids"];
    historyRecord.testPaperID = [rs intForColumn:@"test_paper_id"];
    return historyRecord;
}
@end

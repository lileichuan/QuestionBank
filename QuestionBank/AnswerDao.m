//
//  AnswerDao.m
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-17.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import "AnswerDao.h"
#define TABLE_NAME @"answer"
@implementation AnswerDao
-(BOOL)insertAnswer:(Answer *)_answer{
    BOOL success = YES;
	[db executeUpdate:[self SQL:@"INSERT INTO %@ (id,question_id,content,score) VALUES(?,?,?,?)" inTable:TABLE_NAME],
     [NSNumber numberWithInteger:_answer.ID],
     [NSNumber numberWithInteger:_answer.questionID],
     _answer.content,
     [NSNumber numberWithFloat:_answer.score]
     ];
    if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
		success = NO;
    }
	return success;
}

-(NSArray *)getQuestionAnswersWithID:(NSInteger)questionID{
    NSMutableArray *answerArr = nil;
 	FMResultSet *rs =[db executeQuery:[self SQL:@"SELECT * FROM %@ where question_id = ?" inTable:TABLE_NAME],
                      [NSNumber numberWithInteger:questionID]];
	while ([rs next]) {
        if (!answerArr) {
            answerArr = [[[NSMutableArray alloc]initWithCapacity:10]autorelease];
        }
        Answer *answer = [self analysisAnswerWithRS:rs];
        [answerArr addObject:answer];
    }
    if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
	}
    return answerArr;
}


-(Answer *)analysisAnswerWithRS:(FMResultSet*)rs{
    Answer *answer =[[[Answer alloc]init] autorelease];;
    answer.ID = [rs intForColumn:@"id"];
    answer.questionID = [rs intForColumn:@"question_id"];
    answer.content =[rs stringForColumn:@"content"];
    answer.score = [rs  doubleForColumn:@"score"];
    return answer;
}
@end

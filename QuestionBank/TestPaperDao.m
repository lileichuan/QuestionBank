//
//  TestPaperDao.m
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-19.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import "TestPaperDao.h"
#import "TestPaper.h"
#import "Question.h"
#define TABLE_NAME @"test_paper"
@implementation TestPaperDao
-(id)init{
    if ([super init]) {
        qDao = [[QuestionDAO alloc]init];
    }
    return self;
}

-(void)dealloc{
    if (qDao) {
        [qDao release];
        qDao = nil;
    }
    [super dealloc];
}


-(BOOL)insertTestPaper:(TestPaper *)testPaper{
    BOOL success = YES;
    NSString *questionIDs ;
    for (NSInteger i = 0; i < testPaper.questionArr.count; i++ ) {
        Question *question = [testPaper.questionArr objectAtIndex:i];
        if (i ==0 ) {
            questionIDs = [NSString stringWithFormat:@"%ld,",question.questionID];
        }
        else{
            questionIDs =[questionIDs stringByAppendingString:[NSString stringWithFormat:@",%ld",question.questionID]];
        }
    }
	[db executeUpdate:[self SQL:@"INSERT INTO %@ (id,created_time,duration,error_num,correct_num,un_write_num,socre,question_ids) VALUES(?,?,?,?,?,?,?,?)" inTable:TABLE_NAME],
    [NSNumber numberWithInteger:testPaper.paperID],
     [NSNumber numberWithDouble:[testPaper.createdTime timeIntervalSince1970]],
      [NSNumber numberWithInteger:testPaper.duration],
     [NSNumber numberWithInteger:testPaper.errorNum],
     [NSNumber numberWithInteger:testPaper.correctNum],
     [NSNumber numberWithInteger:testPaper.unWriteNum],
     [NSNumber numberWithFloat:testPaper.score],
     questionIDs
     ];
    if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
		success = NO;
    }
	return success;
    return YES;
}

-(NSInteger)getTestPaperCount{
    NSInteger result = 0;
    FMResultSet *rs =[db executeQuery:[self SQL:@"SELECT * FROM %@ " inTable:TABLE_NAME]];
	while ([rs next]) {
        result ++;
    }
    if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
	}
    return result;
}

-(NSArray *)getAllTestPaper{
    NSMutableArray *arr = nil;
    FMResultSet *rs =[db executeQuery:[self SQL:@"SELECT * FROM %@ w" inTable:TABLE_NAME]];
	while ([rs next]) {
        if (!arr) {
            arr = [[[NSMutableArray alloc]initWithCapacity:10]autorelease];
        }
        TestPaper *testPaper = [self analysisTestPaperWithRS: rs];
        [arr addObject:testPaper];
    }
    if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
	}
    return arr;
    
}

-(TestPaper *)analysisTestPaperWithRS:(FMResultSet*)rs {
    TestPaper *testPaper =[[[TestPaper alloc]init] autorelease];;
    testPaper.paperID = [rs intForColumn:@"id"];
    testPaper.createdTime =[NSDate dateWithTimeIntervalSince1970:[rs doubleForColumn:@"created_time"]];
    testPaper.duration = [rs intForColumn:@"duration"];
    testPaper.correctNum =  [rs intForColumn:@"correct_num"];
    testPaper.errorNum = [rs intForColumn:@"error_num"];
    testPaper.unWriteNum = [rs intForColumn:@"un_write_num"];
    testPaper.score = [rs doubleForColumn:@"socre"];
    testPaper.questionArr = [[rs stringForColumn:@"question_ids"] componentsSeparatedByString:@","];
    return testPaper;
}
@end

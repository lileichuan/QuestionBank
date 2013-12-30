//
//  ChapterDao.m
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-21.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import "ChapterDao.h"
#import "QuestionDAO.h"
#define TABLE_NAME @"chapter"
@implementation ChapterDao
-(BOOL)insertChapter:(Chapter *)_chapter{
    BOOL success = YES;
	[db executeUpdate:[self SQL:@"INSERT INTO %@ (id,name) VALUES(?,?)" inTable:TABLE_NAME],
     [NSNumber numberWithInteger:_chapter.ID],_chapter.name
     ];
    if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
		success = NO;
    }
	return success;
}

-(NSArray *)getAllChapters{
    NSMutableArray *arr = nil;
    FMResultSet *rs =[db executeQuery:[self SQL:@"SELECT * FROM %@ " inTable:TABLE_NAME]];
	while ([rs next]){
        if (!arr) {
            arr = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
        }
        Chapter *chapter = [self analysisChapterWithRS:rs];
        [arr addObject:chapter];
    }
    if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
	}
    return arr;
}

-(NSArray *)getAllChapterWithExamType:(EXAM_TYPE)type{
    NSMutableArray *arr = nil;
    QuestionDAO *qDao = [[QuestionDAO alloc]init];
    FMResultSet *rs =[db executeQuery:[self SQL:@"SELECT * FROM %@ " inTable:TABLE_NAME]];
	while ([rs next]){
        if (!arr) {
            arr = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
        }
        Chapter *chapter = [self analysisChapterWithRS:rs];
        chapter.amount = [qDao getQuestionAmountWithChapterID:chapter.ID withExamType:type];
        [arr addObject:chapter];
    }
    if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
	}
    [qDao release];
    return arr;
    
}
-(Chapter *)getChapterWithID:(NSInteger)chapterID{
    Chapter *chapter = nil;
    FMResultSet *rs =[db executeQuery:[self SQL:@"SELECT * FROM %@ where id = ?" inTable:TABLE_NAME],[NSNumber numberWithInteger:chapterID]];
	while ([rs next]){
       chapter = [self analysisChapterWithRS:rs];
    }
    if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
	}
    return chapter;
}


-(Chapter *)analysisChapterWithRS:(FMResultSet*)rs{
    Chapter *chapter = [[[Chapter alloc]init]autorelease];
    chapter.ID = [rs intForColumn:@"id"];
    chapter.name = [rs stringForColumn:@"name"];
    return chapter;
}
@end

//
//  SightDao.m
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-27.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "SightDao.h"

#define TABLE_NAME @"sight"
@implementation SightDao
@synthesize userDao;

-(id)init{
    if (self =[super init]) {
        userDao = [[UserInfoDao alloc]init];
    }
    return self;
}

-(void)dealloc{
    if (userDao) {
        [userDao release];
        userDao = nil;
    }
    [super dealloc];
}

-(BOOL)insertSight:(Sight *)_sight{
    BOOL success = YES;
	[db executeUpdate:[self SQL:@"INSERT INTO %@ (id,content,from_user_id,time_created,pic_names) VALUES(?)" inTable:TABLE_NAME],
     _sight.sightID,
     _sight.content,
     _sight.fromUser.userID,
     [NSNumber numberWithDouble:_sight.timeCreated],
      _sight.picNames
     ];
    if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
		success = NO;
    }
	return success;
}

-(NSArray *)getSights{
    NSMutableArray *arr = nil;
    FMResultSet *rs =[db executeQuery:[self SQL:@"SELECT * FROM %@ " inTable:TABLE_NAME]];
	while ([rs next]){
        if (!arr) {
            arr = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
        }
        Sight *sight = [self analysisSightyWithRS:rs];
        [arr addObject:sight];
    }
    if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
	}
    return arr;
}


-(Sight *)analysisSightyWithRS:(FMResultSet*)rs{
    Sight *sight = [[[Sight alloc]init]autorelease];
    sight.sightID = [rs stringForColumn:@"id"];
    sight.content =[rs stringForColumn:@"content"];
    sight.picNames = [rs stringForColumn:@"pic_names"];
    sight.timeCreated = [rs doubleForColumn:@"time_created"];
    NSString *userID = [rs stringForColumn:@"from_user_id"];
    sight.fromUser = [userDao getUserWithID:userID];
    return sight;
}


@end

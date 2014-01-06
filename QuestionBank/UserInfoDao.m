//
//  UserInfoDao.m
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-4.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "UserInfoDao.h"
#define TABLE_NAME @"UserInfo"
@implementation UserInfoDao
-(BOOL)insertUser:(UserInfo *)_userInfo{
    BOOL success = YES;
	[db executeUpdate:[self SQL:@"INSERT INTO %@ (id,name,company) VALUES(?,?,?)" inTable:TABLE_NAME],
    _userInfo.userID,_userInfo.name,_userInfo.company
     ];
    if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
		success = NO;
    }
	return success;
    
}

-(UserInfo *)getUserWithID:(NSString *)userID{
  UserInfo *userInfo = nil;
    FMResultSet *rs =[db executeQuery:[self SQL:@"SELECT * FROM %@ where id = ?" inTable:TABLE_NAME],userID];
	while ([rs next]){
        userInfo = [self analysisUserWithRS:rs];
    }
    if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
	}
    return userInfo;
}

-(UserInfo *)analysisUserWithRS:(FMResultSet*)rs{
    UserInfo *userInfo = [[[UserInfo alloc]init]autorelease];
    userInfo.userID = [rs stringForColumn:@"id"];
    userInfo.name = [rs stringForColumn:@"name"];
    userInfo.company = [rs stringForColumn:@"company"];
    return userInfo;
}
@end

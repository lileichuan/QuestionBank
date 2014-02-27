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
	[db executeUpdate:[self SQL:@"INSERT INTO %@ (id,name,company,login_name,password,telephone,sex,photo_name) VALUES(?,?,?,?,?,?,?,?)" inTable:TABLE_NAME],
    _userInfo.userID,_userInfo.name,_userInfo.company,
     _userInfo.loginName,
     _userInfo.password,
     _userInfo.telephone,
    [NSNumber numberWithInteger: _userInfo.sex],
     _userInfo.photoName
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
     userInfo.loginName = [rs stringForColumn:@"login_name"];
     userInfo.password = [rs stringForColumn:@"password"];
     userInfo.telephone = [rs stringForColumn:@"telephone"];
     userInfo.sex = [rs intForColumn:@"sex"];
    userInfo.photoName = [rs stringForColumn:@"photo_name"];
    return userInfo;
}
-(BOOL)updateUserInfo:(UserInfo *)_userInfo{
    BOOL success = YES;
    [db executeUpdate:[self SQL:@"UPDATE %@ SET name =?,company = ?,login_name = ? ,password = ? ,telephone = ?,photo_name = ?  WHERE id = ?" inTable:TABLE_NAME],
   _userInfo.name,
   _userInfo.company,
     _userInfo.loginName,
     _userInfo.password,
     _userInfo.telephone,
     _userInfo.photoName,
     _userInfo.userID];
    if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
		success = NO;
    }
	return success;
}

-(BOOL)isHasUserWithID:(NSString *)userID{
    BOOL success = NO;
    FMResultSet *rs =[db executeQuery:[self SQL:@"SELECT * FROM %@ where id = ?" inTable:TABLE_NAME],userID];
	while ([rs next]){
        success = YES;
        break;
    }
    return success;
}
@end

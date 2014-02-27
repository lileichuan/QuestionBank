//
//  UserInfo.m
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-4.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "UserInfo.h"
#import "UserInfoDao.h"

@implementation UserInfo
UserInfo *userInfo;
@synthesize userID,name,company,loginName,password;
@synthesize telephone,sex,photoName;
+(UserInfo *)sharedUserInfo{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSString *userID = [userDefaults objectForKey:@"user_ID"];
    if (userID) {
        if (userInfo) {
            if ([userInfo.userID isEqualToString:userID] == NO) {
                [userInfo release];
                UserInfoDao *dao = [[UserInfoDao alloc]init];
                userInfo = [dao getUserWithID:userID];
                [userInfo retain];
                [dao release];
                dao = nil;
            }
        }
        else {
            UserInfoDao *dao = [[UserInfoDao alloc]init];
            userInfo = [dao getUserWithID:userID];
            [userInfo retain];
            [dao release];
            dao = nil;
        }
        
    }
    else{
        return nil;
    }
   return userInfo;
}

-(void)closeUserInfo{
    if (userInfo) {
        [userInfo release];
        userInfo = nil;
    }
}

-(void)dealloc{
    if (userID) {
        [userID release];
        userID = nil;
    }
    if (name) {
        [name release];
        name = nil;
    }
    if (company) {
        [company release];
        company = nil;
    }
    if (loginName) {
        [loginName release];
        loginName = nil;
    }
    if (password) {
        [password release];
        password = nil;
    }
    if (telephone) {
        [telephone release];
        telephone = nil;
    }
    if (photoName) {
        [photoName release];
        photoName = nil;
    }
    [super dealloc];
}

@end

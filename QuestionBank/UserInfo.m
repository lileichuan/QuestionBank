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
@synthesize userID,name,company;
+(UserInfo *)sharedUserInfo{
    if (!userInfo) {
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        NSString *userID = [userDefaults objectForKey:@"userID"];
        if (userID) {
            UserInfoDao *dao = [[UserInfoDao alloc]init];
            userInfo = [dao getUserWithID:userID];
            [userInfo retain];
            [dao release];
            dao = nil;
        }
        else{
            userInfo = nil;
        }
        
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
    [super dealloc];
}

@end

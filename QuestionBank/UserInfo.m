//
//  UserInfo.m
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-4.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo
@synthesize userID,name,company;

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

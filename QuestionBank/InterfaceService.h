//
//  InterfaceService.h
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-4.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HistoryRecord.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "UserInfo.h"

@interface InterfaceService : NSObject<ASIHTTPRequestDelegate>

-(BOOL)uploadUserInfo:(UserInfo *)userInfo;

-(BOOL)uploadAnswerRecord:(NSDictionary *)recordDic;

-(NSArray *)loadAnswerRaking;

-(BOOL)uploadCompany:(NSString *)company;

-(NSArray *)getCompanylist;

-(NSArray *)loadRakingWithCompany:(NSString *)company;

-(NSDictionary *)checkClientUpadte;

-(BOOL)feedbackWithContent:(NSDictionary *)info;

-(BOOL)uploadNewsWithInfo:(NSDictionary *)newsInfo;

//参数：user_id、content、type（1新闻 2通知 3报道）
-(NSArray *)loadNewWithType:(NSInteger)type withCompany:(NSString *)company;

//-(BOOL)uploadMemberWithInfo:(NSDictionary *)newsInfo;

-(NSArray *)loadFriendswithCompany:(NSString *)company;
@end

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

@end

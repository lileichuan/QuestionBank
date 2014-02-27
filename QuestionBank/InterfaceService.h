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


-(BOOL)uploadAnswerRecord:(NSDictionary *)recordDic;



-(BOOL)uploadCompany:(NSString *)company;

-(NSArray *)getCompanylist;

-(NSArray *)loadAllRaking;

-(NSArray *)loadRakingWithCompany:(NSString *)company;

-(NSArray *)loadRakingWithCompany:(NSString *)company withPageNum:(NSInteger)pageNum;

-(NSArray *)loadRakingWithPageNum:(NSInteger)pageNum;

-(NSDictionary *)checkClientUpadte;

-(BOOL)feedbackWithContent:(NSDictionary *)info;

-(BOOL)uploadNewsWithInfo:(NSDictionary *)newsInfo;

//获取短信验证码
//参数：mobile
-(NSString *)getCaptchaWithPhoneNum:(NSString *)phoneNum;

//检查验证码是否正确
//参数：mobile code identifier
-(BOOL)checkCaptchaWithPhoneNum:(NSString *)phoneNum  withCaptcha:(NSString *)code
                 withIdentifier:(NSString*)identifier;

//用户注册
-(BOOL)userRegister:(NSDictionary *)userInfo;

//找回密码
-(BOOL)findPassword:(NSDictionary *)info;

//用户登录
-(BOOL)userLogin:(NSDictionary *)userInfo;


//上传头像
-(BOOL)uploadPhoto:(NSDictionary *)userInfo;

//添加一条看见记录
-(BOOL)addSight:(NSDictionary *)dic;

//获得所有用户所有打看见记录
-(NSArray *)getAllSights:(NSString *)userID;

//参数：user_id、content、type（1新闻 2通知 3报道）
-(NSArray *)loadNewWithType:(NSInteger)type withCompany:(NSString *)company;

//-(BOOL)uploadMemberWithInfo:(NSDictionary *)newsInfo;

-(NSArray *)loadFriendswithCompany:(NSString *)company;
@end

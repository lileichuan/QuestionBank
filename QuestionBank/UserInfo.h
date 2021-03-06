//
//  UserInfo.h
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-4.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject{
    NSString   *userID;
    NSString   *name;
    NSString   *company;
    NSString   *loginName; //用户登录名，手机号
    NSString   *password;  //用户密码
    NSString   *telephone; //手机号
    NSInteger  sex;
    NSString   *photoName;
}
@property(nonatomic, retain)NSString   *userID;
@property(nonatomic, retain)NSString   *name;
@property(nonatomic, retain)NSString   *company;
@property(nonatomic, retain)NSString   *loginName; //用户登录名
@property(nonatomic, retain)NSString   *password;  //用户密码
@property(nonatomic, retain)NSString   *telephone; //手机号
@property(nonatomic, assign)NSInteger  sex;
@property(nonatomic, retain)NSString   *photoName;
+(UserInfo *)sharedUserInfo;

-(void)closeUserInfo;
@end

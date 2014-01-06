//
//  UserInfoDao.h
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-4.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDao.h"
#import "UserInfo.h"
@interface UserInfoDao : BaseDao
-(BOOL)insertUser:(UserInfo *)_userInfo;
-(UserInfo *)getUserWithID:(NSString *)userID;

@end

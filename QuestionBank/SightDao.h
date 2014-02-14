//
//  SightDao.h
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-27.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDao.h"
#import "Sight.h"
#import "UserInfoDao.h"
@interface SightDao : BaseDao{
    UserInfoDao *userDao;
}
@property(nonatomic, retain)UserInfoDao *userDao;

-(BOOL)insertSight:(Sight *)_sight;

-(NSArray *)getSights;
@end

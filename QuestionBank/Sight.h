//
//  Sight.h
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-25.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

@interface Sight : NSObject{
    NSString        *sightID;
    NSString        *content; //发表内容
    NSString        *picNames; //以逗号分开
    UserInfo        *fromUser; //来知用户
    NSTimeInterval  timeCreated;
}
@property(nonatomic, retain) NSString    *sightID;
@property(nonatomic, retain) NSString    *content; //发表内容
@property(nonatomic, retain) NSString    *picNames;
@property(nonatomic, retain) UserInfo    *fromUser; //来知用户
@property(nonatomic, assign) NSTimeInterval  timeCreated;
@end

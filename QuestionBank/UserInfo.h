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
}
@property(nonatomic, retain)NSString   *userID;
@property(nonatomic, retain)NSString   *name;
@property(nonatomic, retain)NSString   *company;

@end

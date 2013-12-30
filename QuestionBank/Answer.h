//
//  Answer.h
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-17.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Answer : NSObject{
    NSInteger ID;
    NSInteger questionID;
    NSString *content;
    float    score;
}
@property(nonatomic, assign) NSInteger ID;
@property(nonatomic, assign)NSInteger questionID;
@property(nonatomic, retain)NSString *content;
@property(nonatomic, assign)float    score;


@end

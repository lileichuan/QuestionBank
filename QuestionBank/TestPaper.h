//
//  TestPaper.h
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-19.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TestPaper : NSObject{
    NSInteger    paperID;
    NSDate       *createdTime;
    NSInteger    duration;
    NSInteger    errorNum;//错题数
    NSInteger    correctNum;//正确数
    NSInteger    unWriteNum;//未做数
    float        score;//分数
    NSArray      *questionArr;
}
@property(nonatomic, assign) NSInteger    paperID;
@property(nonatomic, retain) NSDate       *createdTime;
@property(nonatomic, assign) NSInteger     duration;
@property(nonatomic, assign) NSInteger    errorNum;//错题数
@property(nonatomic, assign) NSInteger    correctNum;//正确数
@property(nonatomic, assign) NSInteger    unWriteNum;//未做数
@property(nonatomic, assign) float        score;//分数
@property(nonatomic, retain) NSArray      *questionArr;

@end

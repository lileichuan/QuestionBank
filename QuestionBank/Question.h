//
//  Question.h
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-8.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HistoryRecord.h"
@interface Question : NSObject
{
    NSInteger  questionID;
    OPTION_TYPE  optionType;//题目类型:0表示单选；1表示多选;2表示判断;
    NSArray    *answerArr;
    NSInteger  mediaType;//试题类型:0表示普通题目
    NSInteger  chapterID;//章
    NSInteger  sectionID;//节
    NSString   *question;
    NSString   *explain;
    BOOL   star; //0表示没有收藏;1表示收藏；
    BOOL   error;
    
    HistoryRecord *historyRecord;
}
@property(nonatomic, assign) NSInteger  questionID;
@property(nonatomic, assign) OPTION_TYPE  optionType;//题目类型:0表示单选；1表示多选;2表示判断;
@property(nonatomic, retain) NSArray   *answerArr;
@property(nonatomic, assign) NSInteger  mediaType;//试题类型:0表示普通题目
@property(nonatomic, assign) NSInteger  chapterID;//章
@property(nonatomic, assign) NSInteger  sectionID;//节
@property(nonatomic, retain) NSString   *question;
@property(nonatomic, retain) NSString   *explain;
@property(nonatomic, assign) BOOL   star;
@property(nonatomic, retain) HistoryRecord *historyRecord;
@property(nonatomic, assign)  BOOL   error;


@end

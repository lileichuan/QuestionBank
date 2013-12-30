//
//  Question.m
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-8.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import "Question.h"

@implementation Question
@synthesize questionID,optionType,answerArr,mediaType,chapterID,sectionID,question,explain,star,historyRecord,error;
-(void)dealloc{
    if (answerArr) {
        [answerArr release];
        answerArr = nil;
    }
    if (question) {
        [question release];
        question = nil;
    }
    if (explain) {
        [explain release];
        explain = nil;
    }
    if (historyRecord) {
        [historyRecord release];
        historyRecord = nil;
    }
    [super dealloc];
}
@end

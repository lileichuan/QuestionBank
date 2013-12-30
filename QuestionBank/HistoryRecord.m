//
//  HistoryRecord.m
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-14.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import "HistoryRecord.h"

@implementation HistoryRecord
@synthesize questionID,score,answerIDs,testPaperID;
-(void)dealloc{
    if (answerIDs) {
        [answerIDs release];
        answerIDs = nil;
    }
    [super dealloc];
}
@end

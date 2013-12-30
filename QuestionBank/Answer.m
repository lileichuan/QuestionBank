//
//  Answer.m
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-17.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import "Answer.h"

@implementation Answer
@synthesize ID,questionID,content,score;
-(void)dealloc{
    if (content) {
        [content release];
        content = nil;
    }
    [super dealloc];
}
@end

//
//  Chapter.m
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-21.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import "Chapter.h"

@implementation Chapter
@synthesize ID,name,amount;

-(void)dealloc{
    if (name) {
        [name release];
        name = nil;
    }
    [super dealloc];
}

@end

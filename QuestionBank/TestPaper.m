//
//  TestPaper.m
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-19.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import "TestPaper.h"

@implementation TestPaper
@synthesize paperID,createdTime,duration,errorNum,correctNum,unWriteNum,score,questionArr;
-(id)init{
    if ([super init]) {
        errorNum = 0;
        duration = 0;
//        CFUUIDRef uuidObj = CFUUIDCreate(nil);   //create a new UUID
//        NSString *uuidString = (NSString *)CFUUIDCreateString(nil, uuidObj);
//        NSLog(@"uuidString is:%@",uuidString);
//        CFRelease(uuidObj);
//        self.paperID = [uuidString integerValue];
    }
    return self;
}

-(void)dealloc{
    if (createdTime) {
        [createdTime release];
        createdTime = nil;
    }
    if (questionArr) {
        [questionArr release];
        questionArr = nil;
    }
    [super dealloc];
}

@end

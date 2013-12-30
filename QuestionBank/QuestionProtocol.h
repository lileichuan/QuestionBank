//
//  QuestionProtocol.h
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-9.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#ifndef QuestionBank_QuestionProtocol_h
#define QuestionBank_QuestionProtocol_h

#import <Foundation/Foundation.h>

@protocol QuestionProtocol <NSObject>

@optional
-(void)enterQuestionWithIndex:(NSInteger)index;

-(void)exitQuestion:(NSInteger)viewType;
@end

#endif

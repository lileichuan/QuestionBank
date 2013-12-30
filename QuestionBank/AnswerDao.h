//
//  AnswerDao.h
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-17.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Answer.h"
#import "BaseDao.h"
@interface AnswerDao : BaseDao
-(BOOL)insertAnswer:(Answer *)_answer;

-(NSArray *)getQuestionAnswersWithID:(NSInteger)questionID;

@end

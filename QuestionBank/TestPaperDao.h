//
//  TestPaperDao.h
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-19.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDao.h"
#import "TestPaper.h"
#import "QuestionDAO.h"
@interface TestPaperDao : BaseDao{
    QuestionDAO *qDao;
}


-(BOOL)insertTestPaper:(TestPaper *)testPaper;

-(NSInteger)getTestPaperCount;

@end

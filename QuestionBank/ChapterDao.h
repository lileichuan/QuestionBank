//
//  ChapterDao.h
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-21.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDao.h"
#import "Chapter.h"
@interface ChapterDao : BaseDao

-(BOOL)insertChapter:(Chapter *)_chapter;

-(Chapter *)getChapterWithID:(NSInteger)chapterID;

-(NSArray *)getAllChapters;

-(NSArray *)getAllChapterWithExamType:(EXAM_TYPE)type;
@end

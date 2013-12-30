//
//  HistoryRecordDao.h
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-14.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDao.h"
#import "HistoryRecord.h"
@interface HistoryRecordDao : BaseDao{

}

-(BOOL)insertHistoryRecord:(HistoryRecord *)_historyRecord;

-(BOOL)inHasCurRecored:(NSInteger )recordID withPaperID:(NSInteger)paperID;

-(BOOL)updateHisrtoryRecord:(HistoryRecord*)_historyRecord;

-(HistoryRecord *)getHistoryRecordWithID:(NSInteger)questionID;
@end

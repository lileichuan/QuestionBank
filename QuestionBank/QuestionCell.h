//
//  QuestionCell.h
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-19.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import "UIGridViewCell.h"
//@class HistoryRecord;
@interface QuestionCell : UIGridViewCell{
    UILabel *label;
    NSInteger num;
    
    NSInteger state; //0表示未做;1表示正确;2表示错误;
    //HistoryRecord *historyRecord;
    
}
@property(nonatomic, assign) NSInteger num;
@property(nonatomic, assign) NSInteger state; //0表示未做;1表示正确;2表示错误;
//@property(nonatomic, retain) HistoryRecord *historyRecord;

@end

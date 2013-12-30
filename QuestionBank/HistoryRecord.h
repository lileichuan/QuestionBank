//
//  HistoryRecord.h
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-14.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryRecord : NSObject{
    NSInteger   questionID; //试题id
    NSString    *answerIDs; //选择答案ids
    float       score;      //分数
    NSInteger   testPaperID;
}
@property(nonatomic, assign)NSInteger   questionID; //试题id
@property(nonatomic, retain)NSString    *answerIDs; //选择答案ids
@property(nonatomic, assign)float       score;      //分数
@property(nonatomic, assign)NSInteger   testPaperID;
;


@end

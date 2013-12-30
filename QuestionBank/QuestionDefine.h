//
//  QuestionDefine.h
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-19.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#ifndef QuestionBank_QuestionDefine_h
#define QuestionBank_QuestionDefine_h
#import <Foundation/Foundation.h>
#define TOP_BAR_HEIGHT 50
#define BOTTOM_BAR_HEIGHT 48

typedef enum{
    MOCK_EXAM = 0,  //模拟
    FREEDOM_EXAM,   //自由练习
    ERROR_BOOK,     //错题本
    START_BOOK,      //收藏本
    HOT_SPORT,      //热点提问
}EXAM_TYPE;
typedef enum{
    SINGLE_CHOOSE = 0,  //单选
    MUTABLE_CHOOSE,   //多选
     TRUE_FALSE,     //对错题
}OPTION_TYPE;
#endif

//
//  QuestionResultView.h
//  QuestionBank
//
//  Created by hanbo on 13-12-19.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionCell.h"
#import "TopView.h"

#import "QuestionProtocol.h"
#import "TestPaper.h"
#import "BottomView.h"
#import "TranscriptView.h"
//@protocol QuestionResultDelegate <NSObject>
//
//-(void)exitQuestionResult;
//
//@end

@interface QuestionResultView : UIView{
    BottomView *bottomView;
    
    id<QuestionProtocol> delegate;
    TestPaper   *testPaper;
    

    TranscriptView  *transcripView;
    UIButton    *restartBtn;
    


}
@property(nonatomic, assign)  id<QuestionProtocol> delegate;
@property(nonatomic, retain) TestPaper   *testPaper;
@property(nonatomic, retain)  NSArray *questionArr;
@property(nonatomic, copy) dispatch_block_t answerListBlock;
@property(nonatomic, copy) dispatch_block_t restartBlock;
@end

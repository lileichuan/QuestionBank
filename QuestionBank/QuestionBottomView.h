//
//  QuestionBottomView.h
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-11.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionProtocol.h"
#import "TIButton.h"

@interface QuestionBottomView : UIView{
    TIButton  *preBtn;
    TIButton  *nextBtn;
    TIButton  *showAnswerBtn;
    TIButton  *starBtn;
    
    UILabel   *numLabel;
    
    EXAM_TYPE   examType;
}
@property(nonatomic, assign) EXAM_TYPE   examType;

- (id)initWithFrame:(CGRect)frame;

- (void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;

-(void)configureQuestionInfo:(NSDictionary *)info;

-(void)updateExamTime:(NSString *)examTime;

@end

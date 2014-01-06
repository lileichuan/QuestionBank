//
//  QuestionView.h
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-8.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionProtocol.h"
#import "QuestionTitleView.h"
@class Question;

@interface QuestionView : UIScrollView<QuestionProtocol,UITableViewDataSource,UITableViewDelegate>{
    Question *question;
    
    QuestionTitleView *titleView;
    UITableView     *optionTableView;
    NSArray         *optionArr;
    NSArray         *cellHeightArr;
    NSInteger   titleNum;  //题目编号
    
}
@property (nonatomic, retain)Question *question;;
@property (nonatomic, assign)id<QuestionProtocol> delegate;
@property (nonatomic, retain)NSString   *chooseAnswer;
@property (nonatomic, assign)NSInteger   titleNum;  //题目编号
@property (nonatomic, copy)dispatch_block_t switchPageBlock;
- (id)initWithFrame:(CGRect)frame;
- (void)prepareForReuse;

-(void)feedbackCorrectAnswer;

@end

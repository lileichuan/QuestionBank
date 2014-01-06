//
//  QuestionView.m
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-8.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import "QuestionView.h"
#import "Question.h"
#import "Answer.h"
#import "HistoryRecord.h"
#import "QuestionInterface.h"
#import "DXAlertView.h"

@interface   OptionViewCell:UITableViewCell{
    UIImageView   *imageView;
    UILabel       *optionLabel;
    UILabel       *answerLabel;
    
    OPTION_TYPE     optionType;
    BOOL          isOptionSelect;
    
    BOOL          isCorrect;
    float         score;
    
    UIButton     *submitBtn;
}
@property(nonatomic, assign)OPTION_TYPE  optionType;
@property(nonatomic, assign)BOOL isOptionSelect;
@property(nonatomic, assign)BOOL isCorrect;
@property(nonatomic, assign)float score;
@property(nonatomic, copy)dispatch_block_t submitBlock;
-(void)feedback;

-(void)feedbackMutiChooseCorrectAnswer:(NSString *)answer;

-(void)configureCellInfo:(NSDictionary *)cellInfo;

@end
@implementation OptionViewCell
@synthesize optionType,isOptionSelect,isCorrect,score;
-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.selectedBackgroundView.backgroundColor = [UIColor clearColor];
        [self configureSingleChooseCell];
        [self configureMutiChooseCell];

    }
    return self;
}

-(void)dealloc{
    [super dealloc];
}

-(void)configureCellInfo:(NSDictionary *)cellInfo{
    optionLabel.hidden = YES;
    imageView.hidden = YES;
    answerLabel.hidden = YES;
    submitBtn.hidden = YES;
    NSInteger answerID = [[cellInfo objectForKey:@"answerID"]integerValue];
    float cellHeigth = [[cellInfo objectForKey:@"cellHeight"]floatValue];
    float cellHeigth1 = CGRectGetHeight(self.bounds);
    NSLog(@"cellHeigth is:%f %f",cellHeigth,cellHeigth1);
    self.tag = answerID;
    if (answerID != 0) {
        optionLabel.hidden = NO ;
        imageView.hidden = NO ;
        float _score = [[cellInfo objectForKey:@"score"]floatValue];
       
        self.score = _score;
        score == 0.0 ? (isCorrect = NO) :(isCorrect = YES);
        CGRect imageRect = CGRectMake(20,cellHeigth/2 - 12,24, 24);
        imageView.frame = imageRect;
        NSString *content = [cellInfo objectForKey:@"content"];
        CGRect optionRect = CGRectMake(CGRectGetMaxX(imageView.frame) + 5,0,CGRectGetWidth(self.frame) - 50,cellHeigth);
        optionLabel.frame = optionRect;
        optionLabel.text = content;
           }
    else{
        submitBtn.hidden = NO;
    }
}

-(void)configureSingleChooseCell{
    if (!imageView) {
        imageView = [[UIImageView alloc]initWithFrame:CGRectMake(20,CGRectGetMidY(self.frame) - 12,24, 24)];
        imageView.image = [UIImage imageNamed:@"exercise_option_n.png"];
        [self addSubview:imageView];
        imageView.hidden = YES;
        [imageView release];
    }
    if (!optionLabel) {
        optionLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(imageView.frame) + 5,4,CGRectGetWidth(self.bounds) - 50,CGRectGetHeight(self.bounds) - 8)];
        [optionLabel setNumberOfLines:0];
        optionLabel.font = [UIFont systemFontOfSize:16];
        optionLabel.backgroundColor = [UIColor clearColor];
        [self addSubview:optionLabel];
        optionLabel.hidden = YES;
        [optionLabel release];
    }
}

-(void)configureMutiChooseCell{
    if (!submitBtn) {
        submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [submitBtn setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithRed:227.0/255.0 green:100.0/255.0 blue:83.0/255.0 alpha:1]] forState:UIControlStateNormal];
        submitBtn.layer.masksToBounds  = YES;
        //submitBtn.layer.cornerRadius  = 3.0;
        submitBtn.backgroundColor = [UIColor colorWithRed:227.0/255.0 green:100.0/255.0 blue:83.0/255.0 alpha:1];
        [submitBtn setTitle:@"确定" forState:UIControlStateNormal];
        
        float btnWidth = 90;
        float btnHeight = 35;
        submitBtn.frame = CGRectMake(CGRectGetWidth(self.frame) - btnWidth -30,CGRectGetMidY(self.frame) - btnHeight/2, btnWidth, btnHeight);
        [submitBtn addTarget:self action:@selector(submitAnswer:) forControlEvents:UIControlEventTouchUpInside];
        submitBtn.hidden = YES;
        [self addSubview:submitBtn];
    }
    
    if (!answerLabel) {
        answerLabel = [[UILabel alloc]initWithFrame:CGRectMake(5,4, CGRectGetWidth(self.bounds) - 100,40)];
        [answerLabel setNumberOfLines:0];
        answerLabel.font = [UIFont systemFontOfSize:16];
        answerLabel.textColor = [UIColor redColor];
        [self addSubview:answerLabel];
        answerLabel.hidden = YES;
        [answerLabel release];
    }
}

-(void)clearSingleChooseCell{
    if (imageView) {
        [imageView removeFromSuperview];
        imageView = nil;
    }
    if (optionLabel) {
        [optionLabel removeFromSuperview];
        optionLabel  =nil;
    }
    
}

-(void)clearMutiChooseCell{
    if (submitBtn) {
        [submitBtn removeFromSuperview];
        submitBtn = nil;
    }
    if (answerLabel) {
        [answerLabel removeFromSuperview];
        answerLabel = nil;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated{
    if (optionType != MUTABLE_CHOOSE) {
        selected?(imageView.image = [UIImage imageNamed:@"exercise_option_s.png"]):(imageView.image = [UIImage imageNamed:@"exercise_option_n.png"]);
        isOptionSelect = selected;
    }
    else{
        if (selected) {
            isOptionSelect = !isOptionSelect;
        }
        isOptionSelect?(imageView.image = [UIImage imageNamed:@"exercise_option_s.png"]):(imageView.image = [UIImage imageNamed:@"exercise_option_n.png"]);
    }
}


-(void)submitAnswer:(id)sender{
    if (self.submitBlock) {
        self.submitBlock();
    }
}
-(void)feedback{
    isCorrect?(imageView.image = [UIImage imageNamed:@"exercise_option_t.png"]):(imageView.image = [UIImage imageNamed:@"exercise_option_f.png"]);

}
-(void)feedbackMutiChooseCorrectAnswer:(NSString *)answer{
    answerLabel.text = answer;
    answerLabel.hidden = NO;
    submitBtn.hidden = YES;
}

@end

@implementation QuestionView
@synthesize question,chooseAnswer,titleNum;

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        titleNum = 0;
        //self.backgroundColor = [UIColor blackColor];
    }
    return self;
}
-(void)dealloc{
    if (question) {
        [question release];
        question = nil;
    }
    if (chooseAnswer) {
        [chooseAnswer release];
        chooseAnswer = nil;
    }
    if (titleView) {
        [titleView removeFromSuperview];
        titleView = nil;
    }
    if (optionTableView) {
        [optionTableView removeFromSuperview];
        optionTableView = nil;
    }
    [super dealloc];
}
- (void)prepareForReuse{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(gotoNextQuestion) object:nil];
}


-(void)setQuestion:(Question *)_question{
    if (question) {
        [question release];
    }
    question = [_question retain];

   
    if (optionArr) {
        [optionArr release];
        optionArr = nil;
    }
    if (question.optionType == SINGLE_CHOOSE) {
        optionArr =[@[@"A",@"B",@"C",@"D"] retain];
    }
    else if(question.optionType == MUTABLE_CHOOSE){
        optionArr = [@[@"A",@"B",@"C",@"D",@"E"] retain];
    }
    else if (question.optionType == TRUE_FALSE){
         optionArr = [@[@"正确",@"错误"] retain];
    }
    if (!titleView) {
        titleView = [[QuestionTitleView alloc]initWithFrame:CGRectMake(0, 0,CGRectGetWidth(self.bounds),18)];
        [self addSubview:titleView];
        [titleView release];
    }
    if (!optionTableView) {
        optionTableView = [[UITableView alloc]initWithFrame:CGRectZero];
        optionTableView.dataSource = self;
        optionTableView.delegate = self;
        optionTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
        optionTableView.scrollEnabled = NO;
        optionTableView.backgroundColor = [UIColor clearColor];
        [self addSubview:optionTableView];
        [optionTableView release];
    }

    
    NSString *questionTitle = [NSString stringWithFormat:@"%ld.%@",titleNum,question.question];
    NSDictionary *dic = @{@"type":[NSNumber numberWithInteger:question.optionType],@"title":questionTitle};
    [titleView configureTitleInfo:dic];

    float tableY =CGRectGetMaxY(titleView.frame);
    [self configureCellHeight];
    float totalHeigth = 0;
    
    for (id height in cellHeightArr) {
        totalHeigth += [height floatValue];
    }
    optionTableView.frame = CGRectMake(0,tableY, CGRectGetWidth(self.bounds),totalHeigth);
    self.contentSize = CGSizeMake(CGRectGetWidth(self.bounds),CGRectGetHeight(titleView.frame) + CGRectGetHeight(optionTableView.frame));
    [optionTableView reloadData];
}

-(void)configureCellHeight{
    if (cellHeightArr) {
        [cellHeightArr release];
        cellHeightArr = nil;
    }
    CGFloat contentWidth = CGRectGetWidth(self.bounds);
    NSInteger numCount;
    if (question.optionType != MUTABLE_CHOOSE) {
        numCount = question.answerArr.count;
    }
    else{
        numCount = question.answerArr.count + 1;
    }
    NSMutableArray *arr = [NSMutableArray arrayWithCapacity:5];
    for (NSInteger i =0; i < numCount; i++) {
        float height;
        if (question.optionType == MUTABLE_CHOOSE && i == numCount -1 ) {
            height = 100.0;
        }
        else {
            Answer *answer = [question.answerArr objectAtIndex:i];
            NSString *content = [NSString stringWithFormat:@"%@",answer.content];;
            if (question.optionType != TRUE_FALSE) {
                NSString *option = [optionArr objectAtIndex:i];
                content = [NSString stringWithFormat:@"%@.%@",option,content];
            }
            // 計算出顯示完內容需要的最小尺寸
            UIFont *font = [UIFont systemFontOfSize:16];
            CGSize size = [content sizeWithFont:font constrainedToSize:CGSizeMake(contentWidth - 50,200) lineBreakMode:NSLineBreakByWordWrapping];
            if (size.height < 38) {
                height = 40;
            }
            else{
                height = (size.height + 2);
            }
        }
        [arr addObject:[NSNumber numberWithFloat:height]];
    }
    cellHeightArr = [arr retain];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */
#pragma mark
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [[cellHeightArr objectAtIndex:indexPath.row] floatValue];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger count = 0;
    if (question.optionType != MUTABLE_CHOOSE) {
          count = question.answerArr.count;
    }
    else{
          count = question.answerArr.count + 1;
    }
    return count;
}

#pragma mark
#pragma mark UITableViewDataSource

-(void)makeCellAnswerWithCell:(OptionViewCell *)cell cellforRowIndexPath:(NSIndexPath *)indexPath{
    NSUInteger row = [indexPath row];
    NSDictionary *cellInfo;
    cell.optionType = question.optionType;
    cell.isOptionSelect = NO;

    if (question.optionType == MUTABLE_CHOOSE && indexPath.row == question.answerArr.count) {
        cellInfo = @{@"answerID":[NSNumber numberWithInteger:0],@"cellHeight":[cellHeightArr objectAtIndex:row]};
    }
    else{
        Answer *answer = [question.answerArr objectAtIndex:row];
        NSString *content = [NSString stringWithFormat:@"%@",answer.content];;
        if (question.optionType != TRUE_FALSE) {
            NSString *option = [optionArr objectAtIndex:row];
            content = [NSString stringWithFormat:@"%@.%@",option,content];
        }
         cellInfo = @{@"answerID":[NSNumber numberWithInteger:answer.ID],@"content":content,@"score":[NSNumber numberWithFloat:answer.score],@"cellHeight":[cellHeightArr objectAtIndex:row]};
        
    }
    [cell configureCellInfo:cellInfo];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    OptionViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[OptionViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
        cell.submitBlock = ^(){
            [self saveQuestionRecord];
        };
    }
    [self makeCellAnswerWithCell:cell cellforRowIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (question.optionType != MUTABLE_CHOOSE) {
        [self saveQuestionRecord];
    }
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
    OptionViewCell *optionCell =  (OptionViewCell *)cell;
    if (question.historyRecord.answerIDs) {
        optionCell.userInteractionEnabled = NO;
        if (indexPath.row  == question.answerArr.count && question.optionType == MUTABLE_CHOOSE) {
            NSString *answer = [NSString stringWithFormat:@"正确答案:%@",[self formatCorrectAnswer]];
            [optionCell feedbackMutiChooseCorrectAnswer:answer];
            return;
        }
        NSRange range = [question.historyRecord.answerIDs rangeOfString:[NSString stringWithFormat:@"%ld",optionCell.tag]];
        if (range.location != NSNotFound) {//重新回来后加载上一次的选项需要修改
            if (question.optionType != MUTABLE_CHOOSE) {
              [optionCell feedback];
            }
            else{
                optionCell.selected = YES;
                //optionCell.isOptionSelect = YES;
            }
        }
    }
    else{
        optionCell.userInteractionEnabled = YES;
    }

 
}


-(void)gotoNextQuestion{
    if (self.switchPageBlock) {
        self.switchPageBlock();
    }
}

-(NSString *)formateAnswerIDs{
    NSString *answerIDs = nil;
    for (NSInteger i = 0; i < [[optionTableView visibleCells] count]; i++){
        OptionViewCell *cell = (OptionViewCell *)[[optionTableView visibleCells] objectAtIndex:i];
        if (cell.isOptionSelect) {
            if (answerIDs == nil) {
                answerIDs =[NSString stringWithFormat:@"%d",cell.tag];
            }
            else {
                answerIDs =[answerIDs stringByAppendingString:[NSString stringWithFormat:@",%d",cell.tag]];
            }
        }
    }
    return answerIDs;
}

-(void)saveQuestionRecord{
    NSString *answerIDs = [self formateAnswerIDs];
    if (answerIDs == nil) {
        UIAlertView *alert  =[[UIAlertView alloc]initWithTitle:@"提示" message:@"还没有选择答案" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil,nil];

        [alert show];
        [alert release];
        return;
    }
    float score = 0.0;
    BOOL isCorrect = YES;
    for (NSInteger i = 0; i < [[optionTableView visibleCells] count]; i++)
    {
        OptionViewCell *cell = (OptionViewCell *)[[optionTableView visibleCells] objectAtIndex:i];
        cell.userInteractionEnabled = NO;
        if (cell.isOptionSelect) {
            if (cell.isCorrect) {
                score += cell.score;
            }
            else{
                score = 0;
                isCorrect = NO;
            }
            if (question.optionType != MUTABLE_CHOOSE) {
                [cell feedback];
            }
        }
    }
    TestPaper *testPaper =   [[QuestionInterface sharedQuestionInterface]getCurTestPaper];
    if (isCorrect && score ==  1.0) {
         testPaper.correctNum += 1;
         testPaper.score += score;
    }
    else{
        isCorrect = NO;
        score = 0.0;
      
        testPaper.errorNum += 1;
        [[QuestionInterface sharedQuestionInterface]updateQuestonWithError:YES withQuestionID:question.questionID];
    }
    testPaper.unWriteNum -= 1;
    HistoryRecord *historyRecord = [[HistoryRecord alloc]init];
    historyRecord.questionID = question.questionID;
    historyRecord.score =score;
    historyRecord.answerIDs = answerIDs;
    question.historyRecord = historyRecord;
    [[QuestionInterface sharedQuestionInterface]addHistoryRecord:historyRecord];
    [historyRecord release];
    if (question.optionType == MUTABLE_CHOOSE) {
        [self feedbackMutiblechooswWithCorrect:isCorrect];
    }
    else {
        if (!isCorrect) {
              [self feedbackCorrectAnswer];
        }
    }

    isCorrect ?([self performSelector:@selector(gotoNextQuestion) withObject:nil afterDelay:1.0]):([self performSelector:@selector(gotoNextQuestion) withObject:nil afterDelay:2.0]);
}
                
-(void)feedbackCorrectAnswer{
    for (NSInteger i = 0; i < [[optionTableView visibleCells] count]; i++)
    {
        OptionViewCell *cell = (OptionViewCell *)[[optionTableView visibleCells] objectAtIndex:i];
        if (cell.isCorrect) {
            [cell feedback];
        }
    }
}

-(void)feedbackMutiblechooswWithCorrect:(BOOL)isCorrect{
    OptionViewCell *cell = (OptionViewCell *)[[optionTableView visibleCells] objectAtIndex:question.answerArr.count];
    if (cell.tag == 0) {
        NSString *answer = nil;
        if (!isCorrect) {
            answer = [NSString stringWithFormat:@"答错了,正确答案:%@",[self formatCorrectAnswer]];
        }
        else {
            answer = @"恭喜你,答对啦!";
            
        }
        [cell feedbackMutiChooseCorrectAnswer:answer];
    }
}

-(NSString *)formatCorrectAnswer{
    NSString *answerStr =nil;
    for (NSInteger i = 0;i< question.answerArr.count; i++) {
        Answer *answer = [question.answerArr objectAtIndex:i];
        if (answer.score != 0) {
            if (!answerStr) {
                answerStr = [optionArr objectAtIndex:i];
            }
            else{
                answerStr =[NSString stringWithFormat:@"%@,%@",answerStr,[optionArr objectAtIndex:i]];
            }
        }
    }
    return answerStr;
}
@end

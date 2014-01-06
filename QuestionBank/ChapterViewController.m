//
//  ChapterViewController.m
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-1.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "ChapterViewController.h"
#import "Chapter.h"
#import "QuestionBrowser.h"
#import "TopView.h"
#import "QuestionInterface.h"


@interface ChapterCell : UITableViewCell {
    
}
@property (retain, nonatomic) UILabel *titleLable;
@property (retain, nonatomic) UILabel *amountLable;
@property (retain, nonatomic) UIImageView *imageview;
@end

@implementation ChapterCell
@synthesize titleLable,imageView,amountLable;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
        float height = 22;
        titleLable = [[UILabel alloc]initWithFrame:CGRectMake(10,CGRectGetMidY(self.frame) - height/2, CGRectGetWidth(self.frame),22)];
        [self addSubview:titleLable];
        [titleLable release];
        
        amountLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetWidth(self.frame) -45,CGRectGetHeight(self.frame) - 15,40,15)];
        amountLable.font = [UIFont systemFontOfSize:10];
        [self addSubview:amountLable];
        [amountLable release];
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)dealloc {
    
    [super dealloc];
}

@end

@interface ChapterViewController ()<QuestionBrowserDelegate,UITableViewDataSource,UITableViewDelegate>{
    NSArray  *chapterArr;
    NSArray  *questionArr;
    EXAM_TYPE    examType;
    QuestionBrowser *questionBrowser;
    NSInteger curSelectRow;
    
    
    TopView *topView;
    UITableView *chapterTableView;
}
@property(nonatomic, retain)NSArray  *chapterArr;
@property(nonatomic, retain) NSArray  *questionArr;
@end

@implementation ChapterViewController
@synthesize chapterArr,questionArr;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (BOOL)shouldAutorotate{
    return NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
      self.view.backgroundColor = [UIColor colorWithRed:156/255.0 green:28/255.5 blue:27/255.0 alpha:1.0];
    [self addTopBarView];
    [self addTableView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
    if (chapterArr) {
        [chapterArr release];
        chapterArr = nil;
    }
    if (topView) {
        [topView removeFromSuperview];
        topView = nil;
    }
    if (chapterTableView) {
        [chapterTableView removeFromSuperview];
        chapterTableView = nil;
    }
    
    [super dealloc];
}


-(void)close{
    if (questionBrowser) {
        [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            CGRect tableRect = chapterTableView.frame;
            tableRect.origin.x = 0;
            chapterTableView.frame = tableRect;
            
            CGRect broswerRect = questionBrowser.frame;
            broswerRect.origin.x = broswerRect.size.width;
            questionBrowser.frame = broswerRect;
        } completion:^(BOOL finished) {
            [questionBrowser removeFromSuperview];
            questionBrowser = nil;
        }];
    }
    else{
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    
    }
    
    
}

-(void)initChapterWithType:(EXAM_TYPE)type{
    examType = type;
    [self initChapterData];
    [chapterTableView reloadData];
    
}

-(void)addTopBarView{
    if (!topView) {
        CGRect topRect =   CGRectMake(0,20,CGRectGetWidth(self.view.bounds), TOP_BAR_HEIGHT);
        topView = [[TopView alloc]initWithFrame:topRect];
        [topView addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:topView];
        [topView  release];
    }
    NSString *title;
    switch (examType) {
        case FREEDOM_EXAM:
            title = @"章节练习";
            break;
        case ERROR_BOOK:
            title = @"错题本";
            break;
        case START_BOOK:
            title = @"收藏本";
            break;
        default:
            break;
    }
    topView.title.text = title;
    
}

-(void)addTableView{
    if (!chapterTableView) {
        CGRect contentRect =   CGRectMake(0, CGRectGetMaxY(topView.frame),CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(topView.frame) );
        chapterTableView = [[UITableView alloc]initWithFrame:contentRect];
        chapterTableView.dataSource = self;
        chapterTableView.delegate = self;
        //chapterTableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
        [self.view addSubview:chapterTableView];
        [chapterTableView release];
    }
    
}

-(void)initChapterData{
    if (chapterArr) {
        [chapterArr release];
        chapterArr = nil;
    }
    self.chapterArr = [[QuestionInterface sharedQuestionInterface]gtChaptersWithAnswerType:examType];
}

-(void)initQuestionDataWithChapterID:(NSInteger)chapterID{
    if (questionArr) {
        [questionArr release];
        questionArr = nil;
    }
    self.questionArr =[[QuestionInterface sharedQuestionInterface]getQuestionWithChapterID:chapterID withExamType:examType];
}
#pragma mark
#pragma mark UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 48;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return chapterArr.count;
}

#pragma mark
#pragma mark UITableViewDataSource

-(void)makeCellAnswerWithCell:(ChapterCell *)cell cellforRowIndexPath:(NSIndexPath *)indexPath{
    Chapter *chapter =[chapterArr objectAtIndex:indexPath.row];
    cell.titleLable.text = chapter.name;
    cell.amountLable.text = [NSString stringWithFormat:@"共%d题",chapter.amount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellWithIdentifier = @"Cell";
    ChapterCell *cell = [tableView dequeueReusableCellWithIdentifier:CellWithIdentifier];
    if (cell == nil) {
        cell = [[ChapterCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:CellWithIdentifier];
    }
    [self makeCellAnswerWithCell:cell cellforRowIndexPath:indexPath];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Chapter *chapter =[chapterArr objectAtIndex:indexPath.row];
    curSelectRow = indexPath.row;
    [self initQuestionDataWithChapterID:chapter.ID];
    [self enterQuestionBroswerView];
    
}


#pragma mark
#pragma mark QuestionBrowserDelegate
- (NSUInteger)numberOfQuestionInQuestionBrowser:(QuestionBrowser *)questionBrowser{
    if (questionArr && questionArr.count > 0) {
        return questionArr.count;
    }
    return 0;
}

- (Question *)questionBrowser:(QuestionBrowser *)questionBrowser questionAtIndex:(NSUInteger)index{
    if (index < questionArr.count) {
        Question * question = [questionArr objectAtIndex:index];
        return question;
    }
    return nil;
}
-(void)finishExam{

}
-(void)updateQuestionData{
    Chapter *chapter = [chapterArr objectAtIndex:curSelectRow];
    [self initQuestionDataWithChapterID:chapter.ID];
    chapter.amount = questionArr.count;
    [chapterTableView reloadData];
    if (questionBrowser) {
        [questionBrowser reloadData];
    }
}

-(void)enterQuestionBroswerView{
    
    CGRect startRect =   CGRectMake(CGRectGetWidth(self.view.bounds), CGRectGetMaxY(topView.frame),CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(topView.frame) );
    CGRect contentRect =   CGRectMake(0,CGRectGetMaxY(topView.frame),CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(topView.frame) );
    if (!questionBrowser) {
        questionBrowser = [[QuestionBrowser alloc]initWithFrame:startRect withDelegate:self withAnswerType:examType];
        [self.view addSubview:questionBrowser];
        [questionBrowser release];
    }
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect tableRect = chapterTableView.frame;
        tableRect.origin.x = - tableRect.size.width;
        chapterTableView.frame = tableRect;
        questionBrowser.frame = contentRect;
    } completion:^(BOOL finished) {
    }];
    [UIView animateWithDuration:1.0
                     animations:^{
                         questionBrowser.frame = contentRect;
                     }];
    
}

@end

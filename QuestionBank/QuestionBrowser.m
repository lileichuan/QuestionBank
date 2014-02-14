//
//  QuestionBrowser.m
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-9.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import "QuestionBrowser.h"
#import "QuestionView.h"
#import "QuestionBottomView.h"
#import "Question.h"
#import "QuestionInterface.h"
#import "DXAlertView.h"
#import "ProgressHUD.h"
#define PADDING                 2
#define PAGE_INDEX_TAG_OFFSET   1000
#define PAGE_INDEX(page)        ([(page) tag] - PAGE_INDEX_TAG_OFFSET)

@interface QuestionBrowser(){
     // Views
	UIScrollView *_pagingScrollView;
    NSUInteger _questionCount;
    NSMutableArray *_questions;

    
    // Paging
	NSMutableSet *_visiblePages, *_recycledPages;
	NSUInteger _currentPageIndex;
    
    QuestionBottomView *questionBottomView;
    
    NSTimer *examTimer;
    NSInteger    second;
}

- (void)didStartViewingPageAtIndex:(NSUInteger)index;
@end

@implementation QuestionBrowser
@synthesize _delegate,answerType,_questionData;
- (void)initDefault {
    _questionCount = NSNotFound;
    _questions = [[NSMutableArray alloc] init];
    _visiblePages = [[NSMutableSet alloc] init];
    _recycledPages = [[NSMutableSet alloc] init];
}

- (id)initWithFrame:(CGRect)frame
       withDelegate:(id <QuestionBrowserDelegate>)delegate
     withAnswerType:(EXAM_TYPE)type{
    if ((self = [self initWithFrame:frame])) {
        self.userInteractionEnabled = YES;
        [self initDefault];
        self.backgroundColor = [UIColor whiteColor];

        _delegate = delegate;
        answerType = type;

        // Get data
        NSUInteger numberOfPhotos = [self numberOfQuestions];
        [_questions removeAllObjects];
        for (int i = 0; i < numberOfPhotos; i++) [_questions addObject:[NSNull null]];

        
        CGRect pagingScrollViewFrame = [self frameForPagingScrollView];
        _pagingScrollView = [[UIScrollView alloc] initWithFrame:pagingScrollViewFrame];
        _pagingScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _pagingScrollView.pagingEnabled = YES;
        _pagingScrollView.delegate = self;
        _pagingScrollView.showsHorizontalScrollIndicator = NO;
        _pagingScrollView.showsVerticalScrollIndicator = NO;
        _pagingScrollView.contentSize = [self contentSizeForPagingScrollView];
        [self addSubview:_pagingScrollView];
        
        if (answerType == MOCK_EXAM) {
            second = 0;
            examTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateExamTime) userInfo:nil repeats:YES];
            [examTimer retain];
        }
        
        [self performLayout];
        [self displayBar];
	}
	return self;
}


- (id)initWithQuestions:(NSArray *)questions  __attribute__((deprecated)){
    if ((self = [self init])) {
        _questionData = [questions retain];
	}
	return self;
}


-(void)dealloc{
    [_questions release];
    [_visiblePages release];
    [_questionData release];
    [_recycledPages release];
    [_pagingScrollView release];
    if (examTimer) {
        [examTimer invalidate];
        [examTimer release];
        examTimer = nil;
    }
    _delegate = nil;
    [super dealloc];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)performLayout{
    // Setup pages
    [_visiblePages removeAllObjects];
    [_recycledPages removeAllObjects];
    if (_questionCount != 0) {
         [self tilePages];
    }
    else{
        [self displayBlankView];
    }
    
}

-(void)displayBlankView{
    
}
#pragma mark - Data
- (NSUInteger)numberOfQuestions {
    if (_questionCount == NSNotFound) {
        if ([_delegate respondsToSelector:@selector(numberOfQuestionInQuestionBrowser:)]) {
            _questionCount = [_delegate numberOfQuestionInQuestionBrowser:self];
        } else if (_questionData) {
            _questionCount = _questionData.count;
        }
    }
    if (_questionCount == NSNotFound) _questionCount = 0;
    return _questionCount;
}

- (Question *)questionAtIndex:(NSUInteger)index {
   Question *question = nil;
    if (index < _questions.count) {
        if ([_questions objectAtIndex:index] == [NSNull null]) {
            if ([_delegate respondsToSelector:@selector(questionBrowser:questionAtIndex:)]) {
                question = [_delegate questionBrowser:self questionAtIndex:index];
            } else if (_questionData && index < _questionData.count) {
                question = [_questionData objectAtIndex:index];
            }
            if (question) [_questions replaceObjectAtIndex:index withObject:question];
        }
        else {
            question = [_questions objectAtIndex:index];
        }
    }
    return question;
}

- (void)jumpToQuestionIndex:(NSInteger)index{
    // Change page
	if (index < [self numberOfQuestions]) {
		CGRect pageFrame = [self frameForPageAtIndex:index];
        _pagingScrollView.contentOffset = CGPointMake(pageFrame.origin.x - PADDING, 0);
        _currentPageIndex = index;
        [self configureBottomBar];

	}
}

-(void)swithcExamType:(EXAM_TYPE)type{
    answerType = type;
    questionBottomView.examType = answerType;
}
#pragma mark - Frame Calculations

- (CGRect)frameForPagingScrollView {
    CGRect frame = self.bounds;// [[UIScreen mainScreen] bounds];
    frame.origin.x -= PADDING;
    frame.size.width += (2 * PADDING);
    frame.size.height -= BOTTOM_BAR_HEIGHT;
    return frame;
}

- (CGRect)frameForPageAtIndex:(NSUInteger)index {
    CGRect bounds = _pagingScrollView.bounds;
    CGRect pageFrame = bounds;
    pageFrame.size.width -= (2 * PADDING);
    pageFrame.origin.x = (bounds.size.width * index) + PADDING;
    return pageFrame;
}

- (CGSize)contentSizeForPagingScrollView {
    CGRect bounds = _pagingScrollView.bounds;
    return CGSizeMake(bounds.size.width * [self numberOfQuestions], bounds.size.height);
}

- (CGPoint)contentOffsetForPageAtIndex:(NSUInteger)index {
	CGFloat pageWidth = _pagingScrollView.bounds.size.width;
	CGFloat newOffset = index * pageWidth;
	return CGPointMake(newOffset, 0);
}


#pragma mark - Paging

-(void)clearTilePages{
    for (QuestionView *subView in _pagingScrollView.subviews) {
        if ([subView isKindOfClass:[QuestionView class]]) {
            [subView removeFromSuperview];
            subView = nil;
        }
    }
}

-(void)displayBar{
    CGRect bottomRect =  CGRectMake(0,CGRectGetHeight(self.bounds)- BOTTOM_BAR_HEIGHT, CGRectGetWidth(self.bounds),BOTTOM_BAR_HEIGHT);
    if (!questionBottomView) {
        questionBottomView = [[QuestionBottomView alloc]initWithFrame:bottomRect];
        [questionBottomView addTarget:self action:@selector(doBottomBtnFunction:) forControlEvents:UIControlEventTouchUpInside];
        questionBottomView.examType = self.answerType;
        [self addSubview:questionBottomView];
        [questionBottomView release];
    }
    
    [self configureBottomBar];
}
- (void)tilePages {
	
	// Calculate which pages should be visible
	// Ignore padding as paging bounces encroach on that
	// and lead to false page loads
	CGRect visibleBounds = _pagingScrollView.bounds;
	NSInteger iFirstIndex = (int)floorf((CGRectGetMinX(visibleBounds)+PADDING*2) / CGRectGetWidth(visibleBounds));
	NSInteger iLastIndex  = (int)floorf((CGRectGetMaxX(visibleBounds)-PADDING*2-1) / CGRectGetWidth(visibleBounds));
    if (iFirstIndex < 0) iFirstIndex = 0;
    if (iFirstIndex > [self numberOfQuestions] - 1) iFirstIndex = [self numberOfQuestions] - 1;
    if (iLastIndex < 0) iLastIndex = 0;
    if (iLastIndex > [self numberOfQuestions] - 1) iLastIndex = [self numberOfQuestions] - 1;
	
	// Recycle no longer needed pages
    NSInteger pageIndex;
	for (QuestionView *page in _visiblePages) {
        pageIndex = PAGE_INDEX(page);
		if (pageIndex < (NSUInteger)iFirstIndex || pageIndex > (NSUInteger)iLastIndex) {
			[_recycledPages addObject:page];
            [page prepareForReuse];
			[page removeFromSuperview];
		}
	}
	[_visiblePages minusSet:_recycledPages];
    while (_recycledPages.count > 2) // Only keep 2 recycled pages
        [_recycledPages removeObject:[_recycledPages anyObject]];
	// Add missing pages
	for (NSUInteger index = (NSUInteger)iFirstIndex; index <= (NSUInteger)iLastIndex; index++) {
		if (![self isDisplayingPageForIndex:index]) {
            
            // Add new page
			QuestionView *page = [self dequeueRecycledPage];
			if (!page) {
				page = [[[QuestionView alloc] initWithFrame:CGRectZero]autorelease];
                page.switchPageBlock = ^(){
                    [self enterNextQuestion];
                };
			}
			[self configurePage:page forIndex:index];
			[_visiblePages addObject:page];
			[_pagingScrollView addSubview:page];
        }
            
	}
	
}

- (BOOL)isDisplayingPageForIndex:(NSUInteger)index {
	for (QuestionView *page in _visiblePages)
		if (PAGE_INDEX(page) == index) return YES;
	return NO;
}

- (QuestionView *)pageDisplayedAtIndex:(NSUInteger)index {
	QuestionView *thePage = nil;
	for (QuestionView *page in _visiblePages) {
		if (PAGE_INDEX(page) == index) {
			thePage = page; break;
		}
	}
	return thePage;
}

- (QuestionView *)pageDisplayingPhoto:(Question *)_question {
	QuestionView *thePage = nil;
	for (QuestionView *page in _visiblePages) {
		if (page.question == _question) {
			thePage = page; break;
		}
	}
	return thePage;
}

- (void)configurePage:(QuestionView *)page forIndex:(NSUInteger)index {
	page.frame = [self frameForPageAtIndex:index];
    page.tag = PAGE_INDEX_TAG_OFFSET + index;
    page.titleNum = index + 1;
    page.question = [self questionAtIndex:index];
}

-(void)configureBottomBar{
    BOOL isShowPreBtn;
    _currentPageIndex == 0?(isShowPreBtn = NO):(isShowPreBtn = YES);
    
    BOOL isShowNextBtn;
    _currentPageIndex == _questionCount - 1 || _questionCount == 0?(isShowNextBtn = NO):(isShowNextBtn = YES);
    
    NSString *title = @"没有题目";
    if (_questionCount > 0) {
        title = [NSString stringWithFormat:@"%d/%d",_currentPageIndex + 1,_questionCount];
    }
    Question *_question = [self questionAtIndex:_currentPageIndex];
    NSDictionary *dic = @{@"isShowPreBtn":[NSNumber numberWithBool:isShowPreBtn],@"isShowNextBtn":[NSNumber numberWithBool:isShowNextBtn],@"title":title,@"isStar":[NSNumber numberWithBool:_question.star]};
    if (questionBottomView) {
        [questionBottomView configureQuestionInfo:dic];
    }
}


-(void)updateExamTime{
    second ++;
    NSInteger leftTime = 5400 - second;
    NSString *time = [NSString stringWithFormat:@"%d:%d",leftTime/60,leftTime%60];
    [questionBottomView updateExamTime:time];
    
    if (leftTime <= 0) {
        if (examTimer) {
            [examTimer invalidate];
            [examTimer release];
            examTimer = nil;
        }
        [ProgressHUD showSuccess:@"时间到,试卷自动提交!"];
        [self finishExam];
    }
}

- (QuestionView *)dequeueRecycledPage {
	QuestionView *page = [_recycledPages anyObject];
	if (page) {
		[[page retain] autorelease];
		[_recycledPages removeObject:page];
	}
	return page;
}

// Handle page changes
- (void)didStartViewingPageAtIndex:(NSUInteger)index {
    
    // Release images further away than +/-1
    NSUInteger i;
    if (index > 0) {
        // Release anything < index - 1
        for (i = 0; i < index-1; i++) {
            id photo = [_questions objectAtIndex:i];
            if (photo != [NSNull null]) {
                [_questions replaceObjectAtIndex:i withObject:[NSNull null]];
                    }
        }
    }
    if (index < [self numberOfQuestions] - 1) {
        // Release anything > index + 1
        for (i = index + 2; i < _questions.count; i++) {
            id photo = [_questions objectAtIndex:i];
            if (photo != [NSNull null]) {
                [_questions replaceObjectAtIndex:i withObject:[NSNull null]];
            }
        }
    }
    
}


#pragma mark - UIScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
	
	[self tilePages];

	
	// Calculate current page
	CGRect visibleBounds = _pagingScrollView.bounds;
	NSInteger index = (int)(floorf(CGRectGetMidX(visibleBounds) / CGRectGetWidth(visibleBounds)));
    if (index < 0) index = 0;
	if (index > [self numberOfQuestions] - 1) index = [self numberOfQuestions] - 1;
	NSUInteger previousCurrentPage = _currentPageIndex;
	_currentPageIndex = index;
	if (_currentPageIndex != previousCurrentPage) {
        [self didStartViewingPageAtIndex:index];
        [self configureBottomBar];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {

//    if ([_delegate respondsToSelector:@selector(photoAtIndex:)]) {
//        [_delegate photoAtIndex:_currentPageIndex];
//    }
}




-(void)enterPreQuestion{
    if (_currentPageIndex - 1 > 0 || _currentPageIndex - 1== 0) {
        _currentPageIndex = _currentPageIndex -1;
        CGPoint contentOffset = _pagingScrollView.contentOffset;
        contentOffset.x -= [self frameForPagingScrollView].size.width;
        [_pagingScrollView setContentOffset:contentOffset animated:YES];
    }

}

-(void)enterNextQuestion{
    if (_currentPageIndex + 1 < _questionCount) {
        _currentPageIndex = _currentPageIndex + 1;
        CGPoint contentOffset = _pagingScrollView.contentOffset;
        contentOffset.x += [self frameForPagingScrollView].size.width;
        [_pagingScrollView setContentOffset:contentOffset animated:YES];
    }
    else{
        [self finishExam];
    }
}

-(void)showQuestionAnswer{
    QuestionView *page = [self pageDisplayedAtIndex:_currentPageIndex];
    if (page) {
        [page feedbackCorrectAnswer];
    }
}

-(void)doBottomBtnFunction:(id)sender{
    UIButton *btn = sender;
    switch (btn.tag) {
        case 0:
            [self enterPreQuestion];
            break;
        case 1:{
            [self showQuestionAnswer];
        }
            break;
        case 2:
            
            [self starQuestion];
            break;
        case 3:
            [self enterNextQuestion];
            break;
        case 4:
            [self removeErrorQuestion];
            break;
        case 5:
            [self submitTestPaper];
            break;
            
        default:
            break;
    }
}

//交卷
-(void)submitTestPaper{
     TestPaper *testPaper =   [[QuestionInterface sharedQuestionInterface]getCurTestPaper];
    if (testPaper.unWriteNum > 0) {
        
        NSString *messsage = [NSString stringWithFormat:@"还有%d道题没完成,是否提交",testPaper.unWriteNum];
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"是否确认提交考试" contentText:messsage leftButtonTitle:@"取消" rightButtonTitle:@"提交"];
        [alert show];
        alert.leftBlock = ^() {
            NSLog(@"left button clicked");
        };
        alert.rightBlock = ^() {
             [self finishExam];
            NSLog(@"right button clicked");
        };
        alert.dismissBlock = ^() {
            NSLog(@"Do something interesting after dismiss block");
        };
        [alert release];
        
       
//        UIAlertView *alert  =[[UIAlertView alloc]initWithTitle:@"提示" message:messsage delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"提交", nil];
//        [alert show];
//        [alert release];
    }
    else{
        [self finishExam];
    }

}
-(void)restartExam{
    [self reloadData];
    [self jumpToQuestionIndex:0];
    
    if (answerType == MOCK_EXAM) {
        second = 0;
        examTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateExamTime) userInfo:nil repeats:YES];
        [examTimer retain];
    }
}

-(void)starQuestion{
     Question *_question = [self questionAtIndex:_currentPageIndex];
    _question.star = !_question.star;
    [[QuestionInterface sharedQuestionInterface]updateQuestonWithStar:_question.star withQuestionID:_question.questionID];
    [self configureBottomBar];
    if (_question.star) {
         [ProgressHUD showSuccess:@"收藏成功"];
    }
    else{
        if (answerType == START_BOOK) {
            [_delegate updateQuestionData];

        }
        [ProgressHUD showSuccess:@"取消收藏成功"];
    }
   
}

-(void)finishExam{
    TestPaper *testPaper =   [[QuestionInterface sharedQuestionInterface]getCurTestPaper];
    testPaper.duration = second;
    if (examTimer) {
        [examTimer invalidate];
        [examTimer release];
        examTimer = nil;
    }
    [_delegate finishExam];

}

-(void)removeErrorQuestion{
    if (_questionCount == 0) {
        [ProgressHUD showSuccess:@"没有可移除试题"];
    }
    else{
        Question *_question = [self questionAtIndex:_currentPageIndex];
        _question.error = NO;
        [[QuestionInterface sharedQuestionInterface]updateQuestonWithError:NO withQuestionID:_question.questionID];
        [_delegate updateQuestionData];
        [ProgressHUD showSuccess:@"移除试题成功!"];
    }
}


-(void)reloadData{
    // Reset
    [self clearTilePages];
    _questionCount = NSNotFound;
    // Get data
    NSUInteger numberQuestion = [self numberOfQuestions];
    [_questions removeAllObjects];
    for (int i = 0; i < numberQuestion; i++) [_questions addObject:[NSNull null]];
    // Update
    [self performLayout];
    [self configureBottomBar];
     _pagingScrollView.contentSize = [self contentSizeForPagingScrollView];
}
#pragma mark
#pragma mark UIAlertDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex != 0) {
        [self finishExam];
    }
    
}

@end

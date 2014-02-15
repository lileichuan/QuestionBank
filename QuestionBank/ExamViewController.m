//
//  ExamViewController.m
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-1.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "ExamViewController.h"
#import "QuestionBrowser.h"
#import "QuestionResultView.h"
#import "TopView.h"
#import "QuestionInterface.h"
#import "DXAlertView.h"
#import "UIGridView.h"
#import "UIGridViewDelegate.h"
#import "UserInfo.h"
#import "UserInfoDao.h"
#import "InterfaceService.h"
#import "Catalog.h"
#import "RankingViewController.h"
#import "ImageExt.h"

@interface ExamViewController ()<QuestionBrowserDelegate,QuestionProtocol,UIGridViewDelegate,UIGestureRecognizerDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationBarDelegate>{
    UIView *guideView;
    IBOutlet TopView *topView;
    QuestionBrowser     *questionBrowser;
    QuestionResultView *questionResultView;
    
    NSArray     *questionArr;
    NSInteger       viewTag; //0表示向导页面；1表示考试界面；2表示答题结果页面；3表示查看答案；
    UIGridView *answerList ;
    UserInfo   *userInfo;
}
@property(nonatomic, retain)  NSArray          *questionArr;
@property(nonatomic, retain)  UserInfo         *userInfo;
@property(nonatomic, assign)  NSInteger       viewTag;
@property(nonatomic, retain)  IBOutlet TopView *topView;
@end

@implementation ExamViewController
@synthesize questionArr,viewTag,userInfo,topView;

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
    

    photoImageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    photoImageView.layer.masksToBounds = YES;
    photoImageView.layer.cornerRadius = photoImageView.frame.size.width/2;
    photoImageView.layer.borderColor = [UIColor grayColor].CGColor;
    photoImageView.layer.borderWidth = 3.0f;
    photoImageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    photoImageView.layer.shouldRasterize = YES;
    photoImageView.clipsToBounds = YES;
    
    
    [self addTopBarView];
    self.viewTag = 0;
    self.userInfo = [UserInfo sharedUserInfo];
    
    nameLabel.text = userInfo.name;
    companyLabel.text = userInfo.company;
    NSString *photoPath = [[Catalog getPhotoForlder]stringByAppendingString:[NSString stringWithFormat:@"%@.png",userInfo.userID]];
    if ([[NSFileManager defaultManager]fileExistsAtPath:photoPath]) {
        photoImageView.image = [UIImage imageWithContentsOfFile:photoPath];
    }
}

-(void)viewDidAppear:(BOOL)animated{

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{
//    if (userInfo) {
//        [userInfo release];
//        userInfo = nil;
//    }
    if (questionArr) {
        [questionArr release];
        questionArr = nil;
    }
    [super dealloc];
}

-(void)close{
    if (viewTag == 1) {
        NSString *messsage = [NSString stringWithFormat:@"试卷还没有提交，是否退出考试!"];
        DXAlertView *alert = [[DXAlertView alloc] initWithTitle:@"是否退出考试" contentText:messsage leftButtonTitle:@"取消" rightButtonTitle:@"退出考试"];
        [alert show];
        alert.leftBlock = ^() {
        };
        alert.rightBlock = ^() {
            [self dismissViewControllerAnimated:YES completion:^{
                
            }];
                          };
        alert.dismissBlock = ^() {
        };
        [alert release];
    }
    else if (viewTag == 3){
        [self removeAnswerListView];
        self.viewTag = 2;
    }
    else{
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

-(void)setViewTag:(NSInteger)_viewTag{
    viewTag = _viewTag;
    NSString *title;
    switch (viewTag) {
        case 0:
            title = @"考试简介";
              [topView setReturnTitle:@"主菜单"];
            break;
        case 1:
            title = @"模拟考试";
            [topView setReturnTitle:@"主菜单"];
            break;
        case 2:{
            title = @"答题结果";
            [topView setReturnTitle:@"主菜单"];
        }
            break;
        case 3:
            title = @"查看答案";
            [topView setReturnTitle:@"返回"];
            break;
        case 4:
            title = @"回顾答题";
            [topView setReturnTitle:@"主菜单"];
            break;
            
        default:
            break;
    }
    topView.title.text = title;
}

-(void)initQuestionData{
    if (questionArr) {
        [questionArr release];
        questionArr = nil;
    }
    TestPaper *testPaper = [[QuestionInterface sharedQuestionInterface]generateTestPaper];
    self.questionArr = testPaper.questionArr;
}

-(void)addTopBarView{
    if (!topView) {
        CGRect topRect =   CGRectMake(0,20,CGRectGetWidth(self.view.bounds), TOP_BAR_HEIGHT);
        topView = [[TopView alloc]initWithFrame:topRect];
        [self.view addSubview:topView];
        [topView  release];
    }
    [topView addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
   
}

-(void)removeTopBarView{
    if (topView) {
        [topView removeFromSuperview];
        topView = nil;
    }
}


-(void)removeGuidView{
    if (guideView) {
        [guideView removeFromSuperview];
        guideView  = nil;
    }
}

-(IBAction)enterExamView:(id)sender{
    [self initQuestionData];
    CGRect startRect =   CGRectMake(CGRectGetWidth(self.view.bounds), CGRectGetMaxY(topView.frame),CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(topView.frame) );
    CGRect contentRect =   CGRectMake(0,CGRectGetMaxY(topView.frame),CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(topView.frame) );
    if (!questionBrowser) {
        questionBrowser = [[QuestionBrowser alloc]initWithFrame:startRect withDelegate:self withAnswerType:MOCK_EXAM];
        questionBrowser._questionData = questionArr;
        [self.view addSubview:questionBrowser];
        [questionBrowser release];
    }
    [UIView animateWithDuration:0.35f delay:0.0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        CGRect guidRect = guideView.frame;
        guidRect.origin.x = - guidRect.size.width;
        guideView.frame = guidRect;
        questionBrowser.frame = contentRect;
    } completion:^(BOOL finished) {
        [guideView removeFromSuperview];
        guideView = nil;
    }];
    self.viewTag = 1;
}

-(void)removeQuestionBrowserView{
    if (questionBrowser) {
        [questionBrowser removeFromSuperview];
        questionBrowser = nil;
    }
}

-(void)restartQuestionBroswerView{
    [self initQuestionData];
    if (questionBrowser) {
        [questionBrowser restartExam];
    }
    [self removeQuestionResultView];
    self.viewTag = 1;
}

-(void)addQuestionResultView{
    TestPaper *testPaper =   [[QuestionInterface sharedQuestionInterface]getCurTestPaper];
    CGRect contentRect =   CGRectMake(0,CGRectGetMaxY(topView.frame),CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(topView.frame) );
    if (!questionResultView) {
        questionResultView = [[QuestionResultView alloc] initWithFrame:contentRect];
        questionResultView.testPaper = testPaper;
        questionResultView.answerListBlock =^(){
            [self addAnswerListView];
        };
        questionResultView.restartBlock =^(){
            [self restartQuestionBroswerView];
        };
        questionResultView.rankBlock =^(){
            [self addRanking];
        };
        [self.view addSubview:questionResultView];
        [questionResultView release];
    }
    self.viewTag = 2;
}

-(void)removeQuestionResultView{
    if (questionResultView) {
        [questionResultView removeFromSuperview];
        questionResultView = nil;
    }
}

-(void)addRanking{
    RankingViewController * viewController =  [self.storyboard instantiateViewControllerWithIdentifier:@"Ranking"];
    [self presentViewController:viewController animated:YES completion:^{
        
    }];
}

//查看答题结果
-(void)addAnswerListView{
    if (!answerList) {
        CGRect contentRect =   CGRectMake(0,CGRectGetMaxY(topView.frame),CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds) - CGRectGetMaxY(topView.frame) );
        answerList = [[UIGridView alloc] initWithFrame:contentRect];
        answerList.uiGridViewDelegate = self;
        [self.view addSubview:answerList];
        [answerList release];
    }
    //[self removeQuestionResultView];
    self.viewTag = 3;
}

-(void)removeAnswerListView{
    if (answerList) {
        [answerList removeFromSuperview];
        answerList = nil;
    }
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

-(void)reloadData{
    [self initQuestionData];
}

//
-(void)finishExam{
    [self addQuestionResultView];
    //上传到服务器
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [self uploadAnswerRecord];
    });
    [[QuestionInterface sharedQuestionInterface]saveTestPaper];//保存试卷
    
  
}

-(void)uploadAnswerRecord{
    TestPaper *testPaper = [[QuestionInterface sharedQuestionInterface]getCurTestPaper];
    NSDictionary *recordDic = @{@"user_id":userInfo.userID,@"score":[NSNumber numberWithFloat:testPaper.score],@"duration":[NSNumber numberWithInteger:testPaper.duration]};
    InterfaceService *interface = [[InterfaceService alloc]init];
    [interface uploadAnswerRecord:recordDic];
    [interface release];
    
}
#pragma mark
#pragma mark QuestionProtocol
-(void)enterQuestionWithIndex:(NSInteger)index{
    [UIView animateWithDuration:1.0
                     animations:^{
                         if (questionBrowser) {
                             [questionBrowser jumpToQuestionIndex:index];
                             [questionBrowser swithcExamType:FREEDOM_EXAM];
                         }
                         CGRect rect = questionResultView.frame;
                         rect.origin.x = CGRectGetMaxX(self.view.frame);
                         questionResultView.frame = rect;
                     }
                     completion:^(BOOL finished){
                         [questionResultView removeFromSuperview];
                         [questionResultView release];
                         questionResultView = nil;
                         
                     }];
    self.viewTag = 1;
    
}

-(void)exitQuestion:(NSInteger)viewType{
    if (questionResultView) {
        [questionResultView removeFromSuperview];
        [questionResultView release];
    }
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */


#pragma mark gridView delegate methods

#pragma mark gridView datasource methods

- (CGFloat) gridView:(UIGridView *)grid widthForColumnAt:(int)columnIndex
{
	return CGRectGetWidth(self.view.bounds) / 6;
}

- (CGFloat) gridView:(UIGridView *)grid heightForRowAt:(int)rowIndex
{
	return CGRectGetWidth(self.view.bounds) / 6;
}

- (NSInteger) numberOfColumnsOfGridView:(UIGridView *) grid
{
	return 6;
}

- (NSInteger) numberOfCellsOfGridView:(UIGridView *) grid
{
	return questionArr.count;
}

- (QuestionCell *) gridView:(UIGridView *)grid cellForRowAt:(int)rowIndex AndColumnAt:(int)columnIndex
{
	QuestionCell *cell = (QuestionCell *)[grid dequeueReusableCell];
	
	if (cell == nil) {
        float width = CGRectGetWidth(self.view.bounds) / 6;
        float heigth = CGRectGetWidth(self.view.bounds) / 6;
		cell = [[QuestionCell alloc] initWithFrame:CGRectMake(0, 0, width, heigth)];
	}
	NSInteger num = rowIndex * 6 + columnIndex;
    cell.num = num + 1;
    
    Question *question = [questionArr objectAtIndex:num];
    HistoryRecord *record = question.historyRecord;
    //0表示未做；1表示正确;2表示错误
    if (record) {
        if (record.score == 1.0) {
            cell.state = 1;
        }
        else{
            cell.state = 2;
        }
    }
    else {
        cell.state = 0;
    }
    
	return cell;
}

- (void) gridView:(UIGridView *)grid didSelectRowAt:(int)rowIndex AndColumnAt:(int)colIndex
{
    NSInteger num = rowIndex * 6 + colIndex;
    if (questionBrowser) {
        [questionBrowser swithcExamType:FREEDOM_EXAM];
        [questionBrowser jumpToQuestionIndex:num];
    }
    [self removeAnswerListView];
    viewTag = 1;
}


#pragma mark
#pragma mark 切换头像

- (IBAction)showPhotoLibary:(id)sender{
    UIActionSheet* actionsheet = [[UIActionSheet alloc] initWithTitle:nil
                                                             delegate:nil
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"拍照",@"从相册中选取",nil];
    
    actionsheet.delegate = self;
    [actionsheet showInView:self.view];
    [actionsheet release];
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    NSLog(@"buttonIndex is:%d",buttonIndex);
    if (buttonIndex == 2) {
        return;
    }
    UIImagePickerControllerSourceType sourceType;
    //判断是否有摄像头
    if (buttonIndex == 0) {
        sourceType = UIImagePickerControllerSourceTypeCamera;
        if(![UIImagePickerController isSourceTypeAvailable:sourceType])
        {
            sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
    }
    else if(buttonIndex == 1){
         sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    }
    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.delegate = self;   // 设置委托
    imagePickerController.sourceType = sourceType;
    imagePickerController.allowsEditing = YES;
    [self presentViewController:imagePickerController animated:YES completion:nil];  //需要以模态的形式展示
    [imagePickerController release];
}
#pragma mark -
#pragma mark UIImagePickerController Method
//完成拍照
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    NSLog(@"完成拍照");
    [picker dismissViewControllerAnimated:YES completion:^{}];
    //UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    //UIImage* edit = [info objectForKey:UIImagePickerControllerEditedImage];
    //获取图片裁剪后，剩下的图
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    if (image == nil)
        image = [info objectForKey:UIImagePickerControllerOriginalImage];
    //获取图片的url
    [self performSelector:@selector(saveImage:) withObject:image];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo {
    NSLog(@"完成编辑拍照");
}
//用户取消拍照
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)updateUserInfo{
    nameLabel.text = userInfo.name;
    companyLabel.text = userInfo.company;
    NSString *photoPath = [[Catalog getPhotoForlder]stringByAppendingString:[NSString stringWithFormat:@"%@.png",userInfo.userID]];
    if ([[NSFileManager defaultManager]fileExistsAtPath:photoPath]) {
        photoImageView.image = [UIImage imageWithContentsOfFile:photoPath];
    }
}
//将照片保存到disk上
-(void)saveImage:(UIImage *)image
{
    if (image){
       image =[image scaleToSize:image size:CGSizeMake(image.size.width / 5, image.size.height / 5)];
        NSData *imageData = UIImagePNGRepresentation(image);
        if(imageData != nil)
        {
            imageData = UIImageJPEGRepresentation(image, 1.0);
        }
        NSString *photoPath = [[Catalog getPhotoForlder]stringByAppendingString:[NSString stringWithFormat:@"%@.png",userInfo.userID]];
        [imageData writeToFile:photoPath atomically:YES];
        [self updateUserInfo];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            InterfaceService *service = [[InterfaceService alloc]init];
            [service uploadUserInfo:userInfo];
            [service release];
        });
        
    }
}


@end

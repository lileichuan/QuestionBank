//
//  AppDelegate.m
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-8.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import "AppDelegate.h"
#import "SqliteInterface.h"
#import "InterfaceService.h"
#import "UserInfo.h"
#import "MobClick.h"
#import "Question.h"
#import "QuestionDAO.h"
#import "Chapter.h"
#import "ChapterDao.h"





@implementation AppDelegate


- (void)umengTrack {
    //    [MobClick setCrashReportEnabled:NO]; // 如果不需要捕捉异常，注释掉此行
    //[MobClick setLogEnabled:YES];  // 打开友盟sdk调试，注意Release发布时需要注释掉此行,减少io消耗
    [MobClick setAppVersion:XcodeAppVersion]; //参数为NSString * 类型,自定义app版本信息，如果不设置，默认从CFBundleVersion里取
    [MobClick startWithAppkey:UMENG_APPKEY];
    [MobClick checkUpdate];

   // [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:(ReportPolicy) REALTIME channelId:nil];
    //   reportPolicy为枚举类型,可以为 REALTIME, BATCH,SENDDAILY,SENDWIFIONLY几种
    //   channelId 为NSString * 类型，channelId 为nil或@""时,默认会被被当作@"App Store"渠道
    
    //      [MobClick checkUpdate];   //自动更新检查, 如果需要自定义更新请使用下面的方法,需要接收一个(NSDictionary *)appInfo的参数
    //    [MobClick checkUpdateWithDelegate:self selector:@selector(updateMethod:)];
    
    [MobClick updateOnlineConfig];  //在线参数配置
    
    //    1.6.8之前的初始化方法
    //    [MobClick setDelegate:self reportPolicy:REALTIME];  //建议使用新方法
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(onlineConfigCallBack:) name:UMOnlineConfigDidFinishedNotification object:nil];
    
}

- (void)onlineConfigCallBack:(NSNotification *)note {
    
    NSLog(@"online config has fininshed and note = %@", note.userInfo);
}

//检测客户端是否有更新
-(void)checkClientVersion{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        InterfaceService  *interface = [[InterfaceService alloc]init];
        NSDictionary *versionDic = [interface checkClientUpadte];
        [interface release];
        interface = nil;
        dispatch_async(dispatch_get_main_queue(), ^{
            if ([[versionDic objectForKey:@"result"] isEqualToString:@"success"]) {
                NSString *changelog = [versionDic objectForKey:@"data"];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"有新版本更新" message:changelog delegate:self cancelButtonTitle:@"暂不更新" otherButtonTitles:@"立即更新", nil];
                alert.tag = 130;
                [alert show];
                [alert release];
            }
        });
        
    });

}


-(void)setDataWithChapterNum:(NSInteger)num{
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc]init];
    QuestionDAO *qDao = [[QuestionDAO alloc]init];
    NSInteger chapterID = 10000 * num;
    NSInteger startID = 10000 * num;
    NSInteger answerID =100000 * num;
    NSString *filePath = nil;
    NSString *fileName = [NSString stringWithFormat:@"Question%d",num];
    filePath = [[NSBundle mainBundle]pathForResource:fileName ofType:@"txt"];
    NSString *chapterName = nil;
    switch (num) {
        case 1:
            chapterName = @"第一章《中国特色社会主义》练习题";
            break;
        case 2:
            chapterName = @"第二章《马克思主义新闻观》练习题";
            break;
        case 3:
            chapterName = @"第三章《新闻伦理》练习题";
            break;
        case 4:
            chapterName = @"第四章《新闻法规》练习题";
            break;
        case 5:
            chapterName = @"第五章《新闻采编规范》练习题";
            break;
        case 6:
            chapterName = @"第六章《防止虚假新闻》练习题";
            break;
            
        default:
            break;
    }
    ChapterDao *chapterDao  =[[ChapterDao alloc]init];
    Chapter *chapter = [[Chapter alloc]init];
    chapter.ID = chapterID;
    chapter.name = chapterName;
    [chapterDao insertChapter:chapter];
    [chapter release];
    [chapterDao release];
    NSString *questionContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    NSArray *optionTypeArr =[questionContent componentsSeparatedByString:@"#"];//选择题类型
    for (NSInteger i = 0; i < optionTypeArr.count; i ++) {
        NSString *questions = [optionTypeArr objectAtIndex:i];
        NSMutableArray *dataArr =[NSMutableArray arrayWithArray: [questions componentsSeparatedByString:@"@"]];
        for (NSInteger j = 0; j < dataArr.count; j++) {
            NSString *content = [dataArr objectAtIndex:j];
            NSMutableArray *arr =[NSMutableArray arrayWithArray: [content componentsSeparatedByString:@"\n"]];
            if ([[arr objectAtIndex:0] isEqualToString:@"\r"] || [[arr objectAtIndex:0] isEqualToString:@","]) {
                [arr removeObjectAtIndex:0];
            }
            
            Question *question = [[Question alloc]init];
            question.questionID = startID;
            question.optionType = i;
            NSString *title = [arr objectAtIndex:0];
            NSRange range0 = [title rangeOfString:@"."];
            title = [title substringFromIndex:range0.location + 1];
            NSRange range = [title rangeOfString:@"("];
            question.question =[title substringToIndex:range.location];
            
            
            NSString *answer =[title substringFromIndex:range.location + 1];
            NSRange range1 = [answer rangeOfString:@")"];
            answer = [[answer substringToIndex:range1.location]  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            
            NSMutableArray *answerArr = [[NSMutableArray alloc]init];
            
            if (question.optionType == SINGLE_CHOOSE) {
                for (NSInteger k = 1; k < arr.count; k ++) {
                    NSString *option = [arr objectAtIndex:k];
                    Answer *optionAnswer = [[Answer alloc]init];
                    optionAnswer.ID = answerID;
                    NSRange rangeOption = NSMakeRange(0,1);
                    NSString *option1 = [option substringWithRange:rangeOption];
                    if ([option1 isEqualToString:answer]) {
                        optionAnswer.score = 1.0;
                    }
                    else{
                        optionAnswer.score = 0.0;
                    }
                    
                    optionAnswer.questionID = startID;
                    optionAnswer.content = [option substringFromIndex:2];
                    [answerArr addObject:optionAnswer];
                    [optionAnswer release];
                    answerID +=1;
                    
                }
            }
            else if(question.optionType == MUTABLE_CHOOSE ){
                if (answer.length !=3) {
                    float  avScore= 1.0 / answer.length;
                    for (NSInteger k = 1; k < arr.count; k ++) {
                        NSString *option = [arr objectAtIndex:k];
                        Answer *optionAnswer = [[Answer alloc]init];
                        optionAnswer.ID = answerID;
                        NSRange rangeOption = NSMakeRange(0,1);
                        
                        NSString *option1 = [option substringWithRange:rangeOption];
                        NSRange range = [answer rangeOfString:option1];
                        if (range.location != NSNotFound) {
                            optionAnswer.score = avScore;
                        }
                        else{
                            optionAnswer.score = 0.0;
                        }
                        optionAnswer.questionID = startID;
                        optionAnswer.content = [option substringFromIndex:2];
                        [answerArr addObject:optionAnswer];
                        [optionAnswer release];
                        answerID +=1;
                    }
                }
                else{
                    NSInteger correctFlag = 0;
                    for (NSInteger k = 1; k < arr.count; k ++) {
                        NSString *option = [arr objectAtIndex:k];
                        Answer *optionAnswer = [[Answer alloc]init];
                        optionAnswer.ID = answerID;
                        NSRange rangeOption = NSMakeRange(0,1);
                        
                        NSString *option1 = [option substringWithRange:rangeOption];
                        NSLog(@"*********************************************");
                        
                        NSRange range = [answer rangeOfString:option1];
                        if (range.location != NSNotFound) {
                            if (correctFlag == 0) {
                                optionAnswer.score = 0.20;
                            }
                            else if(correctFlag == 1){
                                optionAnswer.score = 0.30;
                            }
                            else if(correctFlag == 2){
                                optionAnswer.score = 0.50;
                            }
                            correctFlag ++;
                        }
                        else{
                            optionAnswer.score = 0.0;
                        }
                        NSLog(@"option1 is:%@ and answer is:%@ and cur option answer is:%f",option1,answer,optionAnswer.score);
                        optionAnswer.questionID = startID;
                        optionAnswer.content = [option substringFromIndex:2];
                        [answerArr addObject:optionAnswer];
                        [optionAnswer release];
                        answerID +=1;
                    }
                }
                
                
            }
            else if(question.optionType == TRUE_FALSE){
                for (NSInteger k = 0; k < 2; k ++) {
                    Answer *optionAnswer = [[Answer alloc]init];
                    optionAnswer.ID = answerID;
                    optionAnswer.questionID = startID;
                    NSString *content;
                    if (k == 0) {
                        content = @"错误";
                    }
                    else{
                        content = @"正确";
                    }
                    if ([answer isEqualToString:@"√"]) {
                        if (k == 0) {
                            optionAnswer.score = 0.0;
                        }
                        else if (k == 1){
                            optionAnswer.score = 1.0;
                        }
                        
                    }
                    else if([answer isEqualToString:@"×"]){
                        if (k == 0) {
                            optionAnswer.score = 1.0;
                        }
                        else if (k == 1){
                            optionAnswer.score = 0.0;
                        }
                    }
                    optionAnswer.content = content;
                    [answerArr addObject:optionAnswer];
                    [optionAnswer release];
                    answerID +=1;
                    
                }
            }
            startID +=1;
            question.answerArr = answerArr;
            [answerArr release];
            question.mediaType = 0;
            question.explain = @"无";
            question.chapterID = chapterID;
            [qDao insertQuestion:question];
            [question release];
        }
        
    }
    [qDao release];
    qDao = nil;
    [pool release];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
//    InterfaceService *service = [[InterfaceService alloc]init];
//    
//    NSDictionary *infoDic = @{@"user_id":@"1111",@"mobile":@"1111",@"email":@"123@qq.com",@"content":@"123"};
//    [service feedbackWithContent:infoDic];
   
//    UserInfo *userInfo = [[UserInfo alloc]init];
//    userInfo.userID = @"1234567";
//    userInfo.name = @"李雷川";
//    userInfo.company = @"北大方正";
//    [service uploadUserInfo:userInfo];
    
    //[service loadAllRaking];
    
    // Override point for customization after application launch.
    //  友盟的方法本身是异步执行，所以不需要再异步调用
    [self umengTrack];
    //打开数据库
    [[SqliteInterface sharedSqliteInterface] setupDB:DB_NAME];
    [[SqliteInterface sharedSqliteInterface] connectDB];
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Storyboard" bundle:[NSBundle mainBundle]];
//    UIViewController *vc = [storyboard instantiateInitialViewController];
//    self.window.rootViewController = vc;
//    self.window.backgroundColor = [UIColor colorWithRed:156/255.0 green:28/255.5 blue:27/255.0 alpha:1.0];
    //[self.window makeKeyAndVisible];
    
//    for (NSInteger i = 1; i < 7; i++) {
//        [self setDataWithChapterNum:i];
//    }
    [self checkClientVersion];
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - UIAlertViewDelegate
- (void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APP_URL]];

    }
    
}

@end

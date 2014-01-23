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



#define APP_URL @"itms-services://?action=download-manifest&url=http://jizhehome.duapp.com/jizhi.plist"
#define DB_NAME @"question.db"

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
   InterfaceService  *interface = [[InterfaceService alloc]init];
    NSDictionary *versionDic = [interface checkClientUpadte];
    if ([[versionDic objectForKey:@"result"] isEqualToString:@"success"]) {
        NSString *changelog = [versionDic objectForKey:@"data"];
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"有新版本更新" message:changelog delegate:self cancelButtonTitle:@"暂不更新" otherButtonTitles:@"立即更新", nil];
        alert.tag = 130;
        [alert show];
        [alert release];
    }
    [interface release];
    interface = nil;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    InterfaceService *service = [[InterfaceService alloc]init];
    
    NSDictionary *infoDic = @{@"user_id":@"1111",@"mobile":@"1111",@"email":@"123@qq.com",@"content":@"123"};
    [service feedbackWithContent:infoDic];
   
//    UserInfo *userInfo = [[UserInfo alloc]init];
//    userInfo.userID = @"1234567";
//    userInfo.name = @"李雷川";
//    userInfo.company = @"北大方正";
//    [service uploadUserInfo:userInfo];
    
    //[service loadAnswerRaking];
    
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

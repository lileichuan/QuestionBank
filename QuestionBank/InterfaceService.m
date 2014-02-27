//
//  InterfaceService.m
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-4.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "InterfaceService.h"
#import "Catalog.h"
#import "JSON.h"
#import "UserInfoDao.h"

#define BASE_URL @"http://jizhehome.duapp.com"
@implementation InterfaceService


-(NSDictionary *)checkClientUpadte{
    NSDictionary *dic = nil;
    NSString *clientVersion = [NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleVersion"]];
    NSString *serveraddress = [NSString stringWithFormat:@"%@/app/version.c?version=%@",BASE_URL,clientVersion];
    NSURL *url = [NSURL URLWithString:[serveraddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:3.0];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        // NSString *jsonString = [request responseString];
        //NSDictionary *dic = [jsonString JSONValue];
        NSData *data = [request responseData];
         dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        return dic;

    }
    return nil;
}
-(BOOL)feedbackWithContent:(NSDictionary *)info{
    BOOL success = NO;
    NSError *error;
    NSString *serveraddress = [NSString stringWithFormat:@"%@/app/feedback_add.c?user_id=%@&mobile=%@&email=%@&content=%@",BASE_URL,[info objectForKey:@"user_id"],[info objectForKey:@"mobile"],[info objectForKey:@"email"],[info objectForKey:@"content"]];
    NSURL *url = [NSURL URLWithString:[serveraddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:5.0];
    [request startSynchronous];
    error = [request error];
    if (!error) {
        NSString *str = [request responseString];
        NSLog(@"str is:%@",str);
        NSData *data = [request responseData];
        NSString *reuslt = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSLog(@"reuslt is:%@",reuslt);
        success = YES;
    }
    return success;
}


//获取短信验证码
//参数：mobile
-(NSString *)getCaptchaWithPhoneNum:(NSString *)phoneNum{
    NSString *identifierCode = nil;
   NSString *serveraddress = [NSString stringWithFormat:@"%@/app/get_captcha.c?mobile=%@",BASE_URL,phoneNum];
    NSURL *url = [NSURL URLWithString:[serveraddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:3.0];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        // NSString *jsonString = [request responseString];
        //NSDictionary *dic = [jsonString JSONValue];
        NSData *data = [request responseData];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSLog(@"getCaptchaWithPhoneNum is:%@",dic);
        if ([[dic objectForKey:@"result"] isEqualToString:@"success"]== YES) {
            identifierCode = [dic objectForKey:@"data"];
        }
        else{
            NSString *mes = [dic objectForKey:@"data"];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"验证失败" message:mes delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
    }
    return identifierCode;
}

//检查验证码是否正确
//参数：mobile code
-(BOOL)checkCaptchaWithPhoneNum:(NSString *)phoneNum  withCaptcha:(NSString *)code
                 withIdentifier:(NSString*)identifier{
   BOOL success = NO;
    NSString *serveraddress = [NSString stringWithFormat:@"%@/app/check_captcha.c?mobile=%@&code=%@&identifier=%@",
                               BASE_URL,phoneNum,code,identifier];
    NSURL *url = [NSURL URLWithString:[serveraddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:3.0];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        // NSString *jsonString = [request responseString];
        //NSDictionary *dic = [jsonString JSONValue];
        NSData *data = [request responseData];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSLog(@"checkCaptchaWithPhoneNum is:%@",dic);
        if ([[dic objectForKey:@"result"] isEqualToString:@"success"]) {
            success =  YES;
        }
        else{
            NSString *mes = [dic objectForKey:@"data"];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"验证失败" message:mes delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
        
    }
    return success;
}

//用户注册
-(BOOL)userRegister:(NSDictionary *)userInfo{
    BOOL success = NO;
    NSString *phoneNum =[userInfo objectForKey:@"phoneNum"];
    NSString *password =[userInfo objectForKey:@"password"];
    NSString *conpmay =[userInfo objectForKey:@"company"];
    NSString *name = [userInfo objectForKey:@"name"];
    NSInteger sex = [[userInfo objectForKey:@"sex"]integerValue];
    NSString *serveraddress = [NSString stringWithFormat:@"%@/app/register_detail.c?mobile=%@&password=%@&company=%@&name=%@&sex=%ld",BASE_URL,phoneNum,password,conpmay,name,sex
                               ];
    NSURL *url = [NSURL URLWithString:[serveraddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:3.0];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSData *data = [request responseData];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSLog(@"userRegister is:%@",dic);
        if ([[dic objectForKey:@"result"] isEqualToString:@"success"]) {
            NSDictionary *userDic = [[dic objectForKey:@"data"]objectForKey:@"user"];
            UserInfo *user =  [self analysisUserInfo:userDic];
            user.password = password;
            user.loginName = name;
            [self saveUserInfo:user];
            success =  YES;
        }
        else{
            NSString *mes = [dic objectForKey:@"data"];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"验证失败" message:mes delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
        
    }
    return success;
}

//找回密码
-(BOOL)findPassword:(NSDictionary *)info{
    BOOL success = NO;
    NSString *phoneNum =[info objectForKey:@"phoneNum"];
    NSString *password =[info objectForKey:@"password"];
    NSString *code =[info objectForKey:@"code"];
    NSString *identifier =[info objectForKey:@"identifier"];
   
    NSString *serveraddress = [NSString stringWithFormat:@"%@/app/find_password.c?mobile=%@&password=%@&code=%@&identifier=%@",BASE_URL,phoneNum,password,code,identifier
                               ];
    NSURL *url = [NSURL URLWithString:[serveraddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:3.0];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        NSData *data = [request responseData];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSLog(@"userRegister is:%@",dic);
        if ([[dic objectForKey:@"result"] isEqualToString:@"success"]) {
            NSDictionary *userDic = [[dic objectForKey:@"data"]objectForKey:@"user"];
            UserInfo *user =  [self analysisUserInfo:userDic];
            user.password = password;
            [self saveUserInfo:user];
            success =  YES;
        }
        else{
            NSString *mes = [dic objectForKey:@"data"];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"验证失败" message:mes delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
        }
        
    }
    return success;

}


-(void)saveUserInfo:(UserInfo *)user{
    UserInfoDao *dao = [[UserInfoDao alloc]init];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:user.userID forKey:@"user_ID"];
    [userDefaults synchronize];
    if ([dao isHasUserWithID:user.userID]) {
        [dao updateUserInfo:user];
    }
    else{
            [dao insertUser:user];
    }
    [dao release];
}

//用户登录
-(BOOL)userLogin:(NSDictionary *)userInfo{
    BOOL success = NO;
    NSString *password =[userInfo objectForKey:@"password"];
    NSString *loginName = [userInfo objectForKey:@"name"];
    NSString *serveraddress = [NSString stringWithFormat:@"%@/app/login.c?user_name=%@&password=%@",BASE_URL,loginName,password
                               ];
    NSURL *url = [NSURL URLWithString:[serveraddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:3.0];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        // NSString *jsonString = [request responseString];
        //NSDictionary *dic = [jsonString JSONValue];
        NSData *data = [request responseData];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSLog(@"userlogin is:%@",dic);
        if ([[dic objectForKey:@"result"] isEqualToString:@"success"]) {
            NSDictionary *userDic = [[dic objectForKey:@"data"]objectForKey:@"user"];
            UserInfo *user =  [self analysisUserInfo:userDic];
            user.loginName = loginName;
            user.password = password;
            [self saveUserInfo:user];
            success =  YES;
        }
        else{
            NSString *mes = [dic objectForKey:@"data"];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"登录失败" message:mes delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            [alert release];
            
        }
        
    }
    return success;
}


//上传头像
-(BOOL)uploadPhoto:(NSDictionary *)userInfo{
    //    NSString *serveraddress = [NSString stringWithFormat:@"http://www.jizhehome.com/app/register.c?u="];
    NSString *serveraddress = [[NSString stringWithFormat:@"%@/app/register_head.c",BASE_URL] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url =[ NSURL URLWithString :serveraddress ];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    // 字符串使用 GBK 编码，因为 servlet 只识别 GBK
    //NSStringEncoding enc= CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingMacChineseSimp );
    //NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    //NSStringEncoding enc= CFStringConvertEncodingToNSStringEncoding (NSUTF8StringEncoding );
    //[request setStringEncoding :enc];
    NSString *photoPath = [userInfo objectForKey:@"photoPath"];
    [request setRequestMethod:@"post"];
    [request setPostValue :[userInfo objectForKey:@"userID"] forKey : @"user_id" ];

    NSString *photo;
    //[request setPostValue:[compoments lastObject] forKey:@"img_file"];
    if ([[NSFileManager defaultManager]fileExistsAtPath:photoPath]) {
        photo = photoPath;
        NSArray *compoments = [photo componentsSeparatedByString:@"/"];
        [request setFile:photo withFileName:[compoments lastObject] andContentType:nil forKey:@"img_file"];
    }
    [ request startSynchronous ];
    
    NSError *error = [request error];
    if (!error) {
        NSData *data = [request responseData];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if ([[dic objectForKey:@"result"] isEqualToString:@"success"]) {
            NSDictionary *userDic = [[dic objectForKey:@"data"]objectForKey:@"user"];
            NSString *photoName = [[userDic objectForKey:@"head_url"]lastPathComponent];
            NSString *newPhotoPath = [[Catalog getPhotoForlder]stringByAppendingPathComponent:photoName];
            if ([[NSFileManager defaultManager]moveItemAtPath:photoPath toPath:newPhotoPath error:nil]) {
                UserInfoDao *dao = [[UserInfoDao alloc]init];
                UserInfo *user =  [UserInfo sharedUserInfo];
                user.photoName = photoName;
                [dao updateUserInfo:user];
            }
            return YES;
        }
    }
    else{
        NSLog(@"error is:%@",error);
    }
    return YES;

}

//添加一条看见记录
-(BOOL)addSight:(NSDictionary *)dic{
    BOOL success = NO;
    //content img_file
    NSError *error;
    NSString *userID = [dic objectForKey:@"userID"];
    NSString *content = [dic objectForKey:@"content"];
    NSString *serveraddress = [NSString stringWithFormat:@"%@/app/feed_add.c?user_id=%@&content=%@",BASE_URL,userID,content];
    NSURL *url = [NSURL URLWithString:[serveraddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:5.0];
    [request startSynchronous];
    error = [request error];
    if (!error) {
        NSString *str = [request responseString];
        NSLog(@"str is:%@",str);
        NSData *data = [request responseData];
        NSString *reuslt = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSLog(@"reuslt is:%@",reuslt);
        success = YES;
    }
    return success;
}

//获得所有用户所有打看见记录
-(NSArray *)getAllSights:(NSString *)userID{
   // http://jizhehome.duapp.com/app/feed_add.c
    NSString *serveraddress = [NSString stringWithFormat:@"%@/app/feed.c?user_id=%@",BASE_URL,userID];
    NSURL *url = [NSURL URLWithString:[serveraddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:5.0];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        // NSString *jsonString = [request responseString];
        //NSDictionary *dic = [jsonString JSONValue];
        NSData *data = [request responseData];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if ([[dic objectForKey:@"result"] isEqualToString:@"success"]) {
            NSArray *rankArr = [dic objectForKey:@"data"];
            //              NSArray *rankArr = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding: NSUTF8StringEncoding]options:kNilOptions error:&error];
            for (id rankInfo in rankArr) {
                [self analysisRankInfo:rankInfo];
            }
            return rankArr;
        }
    }
    return nil;

}


-(BOOL)uploadAnswerRecord:(NSDictionary *)recordDic{
    BOOL success = NO;
    NSError *error;
    NSString *serveraddress = [NSString stringWithFormat:@"%@/app/record.c?user_id=%@&score=%@&duration=%ld",BASE_URL,[recordDic objectForKey:@"user_id"],[recordDic objectForKey:@"score"],[[recordDic objectForKey:@"duration"]integerValue]];
    NSURL *url = [NSURL URLWithString:[serveraddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:5.0];
    [request startSynchronous];
     error = [request error];
    if (!error) {
        NSString *str = [request responseString];
        NSLog(@"str is:%@",str);
        NSData *data = [request responseData];
       NSString *reuslt = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSLog(@"reuslt is:%@",reuslt);
        success = YES;
    }
    return success;
}

-(NSArray *)loadAllRaking{
    NSString *serveraddress = [NSString stringWithFormat:@"%@/app/sort.c",BASE_URL];
    NSURL *url = [NSURL URLWithString:[serveraddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:5.0];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
       // NSString *jsonString = [request responseString];
         //NSDictionary *dic = [jsonString JSONValue];
        NSData *data = [request responseData];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if ([[dic objectForKey:@"result"] isEqualToString:@"success"]) {
            NSArray *rankArr = [dic objectForKey:@"data"];
//              NSArray *rankArr = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding: NSUTF8StringEncoding]options:kNilOptions error:&error];
            for (id rankInfo in rankArr) {
                [self analysisRankInfo:rankInfo];
            }
            return rankArr;
        }
    }
    return nil;
}

-(NSArray *)loadRakingWithCompany:(NSString *)company{
    NSString *serveraddress = [NSString stringWithFormat:@"%@/app/sort.c?company=%@",BASE_URL,company];
    NSURL *url = [NSURL URLWithString:[serveraddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:5.0];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        // NSString *jsonString = [request responseString];
        //NSDictionary *dic = [jsonString JSONValue];
        NSData *data = [request responseData];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if ([[dic objectForKey:@"result"] isEqualToString:@"success"]) {
            NSArray *rankArr = [dic objectForKey:@"data"];
            //              NSArray *rankArr = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding: NSUTF8StringEncoding]options:kNilOptions error:&error];
            for (id rankInfo in rankArr) {
                [self analysisRankInfo:rankInfo];
            }
            return rankArr;
        }
    }
    return nil;
}

-(NSArray *)loadRakingWithCompany:(NSString *)company withPageNum:(NSInteger)pageNum{
    NSString *serveraddress = [NSString stringWithFormat:@"%@/app/sort.c?company=%@&pageNo=%ld",BASE_URL,company,pageNum];
    NSURL *url = [NSURL URLWithString:[serveraddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:5.0];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        // NSString *jsonString = [request responseString];
        //NSDictionary *dic = [jsonString JSONValue];
        NSData *data = [request responseData];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if ([[dic objectForKey:@"result"] isEqualToString:@"success"]) {
            NSArray *rankArr = [dic objectForKey:@"data"];
            //              NSArray *rankArr = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding: NSUTF8StringEncoding]options:kNilOptions error:&error];
            for (id rankInfo in rankArr) {
                [self analysisRankInfo:rankInfo];
            }
            return rankArr;
        }
    }
    return nil;
}

-(NSArray *)loadRakingWithPageNum:(NSInteger)pageNum{
    NSString *serveraddress = [NSString stringWithFormat:@"%@/app/sort.c?pageNo=%ld",BASE_URL,pageNum];
    NSURL *url = [NSURL URLWithString:[serveraddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:5.0];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        // NSString *jsonString = [request responseString];
        //NSDictionary *dic = [jsonString JSONValue];
        NSData *data = [request responseData];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if ([[dic objectForKey:@"result"] isEqualToString:@"success"]) {
            NSArray *rankArr = [dic objectForKey:@"data"];
            //              NSArray *rankArr = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding: NSUTF8StringEncoding]options:kNilOptions error:&error];
            for (id rankInfo in rankArr) {
                [self analysisRankInfo:rankInfo];
            }
            return rankArr;
        }
    }
    return nil;
}

-(void)analysisRankInfo:(NSDictionary *)rankInfo{
    NSLog(@"rankInfo is:%@",rankInfo);
   NSDictionary  *userInfo = [rankInfo objectForKey:@"user"];
//    NSDictionary  *userInfo = [NSJSONSerialization JSONObjectWithData:[userStr dataUsingEncoding: NSUTF8StringEncoding]options:kNilOptions error:nil];
    NSString *urlString = [userInfo objectForKey:@"head_url"];
     NSString *fullPhotoPath = [[Catalog getPhotoForlder] stringByAppendingPathComponent:[urlString lastPathComponent]];
    [self requestPhotoImageFile:urlString photoPath:fullPhotoPath];
    
}

//-(void)analysisRankInfo:(NSDictionary *)rankInfo{
//    NSLog(@"rankInfo is:%@",rankInfo);
//    NSDictionary  *userInfo = [rankInfo objectForKey:@"user"];
//    //    NSDictionary  *userInfo = [NSJSONSerialization JSONObjectWithData:[userStr dataUsingEncoding: NSUTF8StringEncoding]options:kNilOptions error:nil];
//    NSString *urlString = [userInfo objectForKey:@"head_url"];
//    NSString *fullPhotoPath = [[Catalog getPhotoForlder] stringByAppendingPathComponent:[urlString lastPathComponent]];
//    [self requestPhotoImageFile:urlString photoPath:fullPhotoPath];
//    
//}

//请求头像
- (void)requestPhotoImageFile:(NSString *)urlString photoPath:(NSString *)path
{
    if (urlString) {
        NSLog(@"urlString is:%@",urlString);
        if (![[NSFileManager defaultManager]fileExistsAtPath:path]) {
            ASIHTTPRequest *photoRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlString]];
            [photoRequest setDownloadDestinationPath:path];
            [photoRequest startSynchronous];
            //头像请求错误
            NSError *error = [photoRequest error];
            if (!error) {
                NSString *response = [photoRequest responseString];
                NSLog(@"response error is:%@",response);
            }
        }
    }
}

-(BOOL)uploadCompany:(NSString *)company{
    BOOL success = NO;
    NSError *error;
    NSString *serveraddress = [NSString stringWithFormat:@"%@/app/company_add.c?company=%@",BASE_URL,company];
    NSURL *url = [NSURL URLWithString:[serveraddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:5.0];
    [request startSynchronous];
    error = [request error];
    if (!error) {
        NSString *str = [request responseString];
        NSLog(@"str is:%@",str);
        NSData *data = [request responseData];
        NSString *reuslt = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        NSLog(@"reuslt is:%@",reuslt);
        success = YES;
    }
    return success;
}

-(NSArray *)getCompanylist{
    NSString *serveraddress = [NSString stringWithFormat:@"%@/app/company.c",BASE_URL];
    NSURL *url = [NSURL URLWithString:[serveraddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:5.0];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        // NSString *jsonString = [request responseString];
        //NSDictionary *dic = [jsonString JSONValue];
        NSData *data = [request responseData];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if ([[dic objectForKey:@"result"] isEqualToString:@"success"]) {
            NSArray *companyArr = [dic objectForKey:@"data"];
            //              NSArray *rankArr = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding: NSUTF8StringEncoding]options:kNilOptions error:&error];
            return companyArr;
        }
    }
    return nil;
}

-(BOOL)uploadNewsWithInfo:(NSDictionary *)newsInfo{
    NSString *serveraddress = [[NSString stringWithFormat:@"%@/app/news_add.c",BASE_URL] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url =[ NSURL URLWithString :serveraddress ];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    // 字符串使用 GBK 编码，因为 servlet 只识别 GBK
    NSStringEncoding enc= CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingMacChineseSimp );
    //NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    //NSStringEncoding enc= CFStringConvertEncodingToNSStringEncoding (NSUTF8StringEncoding );
    //[request setStringEncoding :enc];
    
//    NSString *photoPath = [[Catalog getPhotoForlder]stringByAppendingString:[NSString stringWithFormat:@"%@.png",userInfo.userID]];
    [request setRequestMethod:@"post"];
    [request setPostValue :[newsInfo objectForKey:@"user_id"] forKey : @"user_id" ];
    [request setPostValue :[newsInfo objectForKey:@"content"] forKey : @"content"];
    [request setPostValue :[newsInfo objectForKey:@"company"] forKey: @"company"];
    [request setPostValue :[newsInfo objectForKey:@"title"] forKey: @"title"];
    [request setPostValue :[newsInfo objectForKey:@"type"] forKey: @"type"];
    
//    NSString *photo;
//    //[request setPostValue:[compoments lastObject] forKey:@"img_file"];
//    if ([[NSFileManager defaultManager]fileExistsAtPath:photoPath]) {
//        photo = photoPath;
//    }
//    else{
//        photo = [[NSBundle mainBundle]pathForResource:@"Photo_Default" ofType:@"png"];
//    }
//    NSArray *compoments = [photo componentsSeparatedByString:@"/"];
//    //[request setFile:photo forKey:@"png" ];
//    [request setFile:photo withFileName:[compoments lastObject] andContentType:nil forKey:@"img_file"];
//    //    [ request setDelegate : self ];
//    //    [ request setDidFinishSelector : @selector ( responseComplete:)];
//    //    [ request setDidFailSelector : @selector (responseFailed:)];
//    [ request startSynchronous ];
    
    NSError *error = [request error];
    if (!error) {
        NSString *str = [request responseString];
        NSLog(@"str is:%@",str);
        
    }
    else{
        NSLog(@"error is:%@",error);
    }
    return YES;

}

//参数：user_id、content、type（1新闻 2通知 3报道）
-(NSArray *)loadNewWithType:(NSInteger)type withCompany:(NSString *)company{
    NSString *serveraddress = [NSString stringWithFormat:@"%@/app/news.c?company=%@&type=%d",BASE_URL,company,type];
    NSURL *url = [NSURL URLWithString:[serveraddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:5.0];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        // NSString *jsonString = [request responseString];
        //NSDictionary *dic = [jsonString JSONValue];
        NSData *data = [request responseData];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if ([[dic objectForKey:@"result"] isEqualToString:@"success"]) {
            NSArray *newsArr = [dic objectForKey:@"data"];
            //              NSArray *rankArr = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding: NSUTF8StringEncoding]options:kNilOptions error:&error];
            return newsArr;
        }
    }
    return nil;
}

-(NSArray *)loadFriendswithCompany:(NSString *)company{
    NSString *serveraddress = [NSString stringWithFormat:@"%@/app/company_person.c?company=%@",BASE_URL,company];
    NSURL *url = [NSURL URLWithString:[serveraddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:url];
    [request setTimeOutSeconds:5.0];
    [request startSynchronous];
    NSError *error = [request error];
    if (!error) {
        // NSString *jsonString = [request responseString];
        //NSDictionary *dic = [jsonString JSONValue];
        NSData *data = [request responseData];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
        if ([[dic objectForKey:@"result"] isEqualToString:@"success"]) {
            NSArray *friendArr = [dic objectForKey:@"data"];
            //              NSArray *rankArr = [NSJSONSerialization JSONObjectWithData:[data dataUsingEncoding: NSUTF8StringEncoding]options:kNilOptions error:&error];
            return friendArr;
        }
    }
    return nil;
}

-(UserInfo *)analysisUserInfo:(NSDictionary *)userDic{
    UserInfo *user = [[[UserInfo alloc]init]autorelease];
    user.userID = [userDic objectForKey:@"user_id"];
    user.name = [userDic objectForKey:@"name"];
    user.sex = [[userDic objectForKey:@"sex"]integerValue];
    user.company = [userDic objectForKey:@"company"];
    user.telephone = [userDic objectForKey:@"telephone"];
    NSString *headURL =  [userDic objectForKey:@"head_url"];
    user.photoName = [headURL lastPathComponent];
    NSString *urlString =headURL;
    NSString *fullPhotoPath = [[Catalog getPhotoForlder] stringByAppendingPathComponent:user.photoName];
    [self requestPhotoImageFile:urlString photoPath:fullPhotoPath];
    return user;
}
@end

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

#define BASE_URL @"http://jizhehome.duapp.com"
@implementation InterfaceService

//上传用户头像
-(BOOL)uploadUserInfo:(UserInfo *)userInfo{
//    NSString *serveraddress = [NSString stringWithFormat:@"http://www.jizhehome.com/app/register.c?u="];
     NSString *serveraddress = [[NSString stringWithFormat:@"%@/app/register.c",BASE_URL] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSURL *url =[ NSURL URLWithString :serveraddress ];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    // 字符串使用 GBK 编码，因为 servlet 只识别 GBK
    NSStringEncoding enc= CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingMacChineseSimp );
    //NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
    //NSStringEncoding enc= CFStringConvertEncodingToNSStringEncoding (NSUTF8StringEncoding );
    //[request setStringEncoding :enc];
    
    NSString *photoPath = [[Catalog getPhotoForlder]stringByAppendingString:[NSString stringWithFormat:@"%@.png",userInfo.userID]];
    [request setRequestMethod:@"post"];
    [request setPostValue :userInfo.userID forKey : @"user_id" ];
    [request setPostValue :userInfo.name forKey : @"name"];
    [request setPostValue :userInfo.company forKey : @"company"];
    
    NSString *photo;
    //[request setPostValue:[compoments lastObject] forKey:@"img_file"];
    if ([[NSFileManager defaultManager]fileExistsAtPath:photoPath]) {
        photo = photoPath;
        NSArray *compoments = [photo componentsSeparatedByString:@"/"];
        [request setFile:photo withFileName:[compoments lastObject] andContentType:nil forKey:@"img_file"];
    }
//    else{
//       photo = [[NSBundle mainBundle]pathForResource:@"Photo_Default" ofType:@"png"];
//    }

    //[request setFile:photo forKey:@"png" ];
//   [request setFile:photo withFileName:[compoments lastObject] andContentType:nil forKey:@"img_file"];
//    [ request setDelegate : self ];
//    [ request setDidFinishSelector : @selector ( responseComplete:)];
//    [ request setDidFailSelector : @selector (responseFailed:)];
    [ request startSynchronous ];
    
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
    [request setTimeOutSeconds:15.0];
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



-(BOOL)uploadAnswerRecord:(NSDictionary *)recordDic{
    BOOL success = NO;
    NSError *error;
    NSString *serveraddress = [NSString stringWithFormat:@"%@/app/record.c?user_id=%@&score=%@&duration=%d",BASE_URL,[recordDic objectForKey:@"user_id"],[recordDic objectForKey:@"score"],[[recordDic objectForKey:@"duration"]integerValue]];
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

-(NSArray *)loadAnswerRaking{
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
    [request setTimeOutSeconds:15.0];
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
     NSString *fullPhotoPath = [[Catalog getPhotoForlder] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png",[userInfo objectForKey:@"user_id"]]];
    [self requestPhotoImageFile:urlString photoPath:fullPhotoPath];
    
}

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
    [request setTimeOutSeconds:15.0];
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
    [request setTimeOutSeconds:15.0];
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
    [request setTimeOutSeconds:15.0];
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
    [request setTimeOutSeconds:15.0];
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
@end

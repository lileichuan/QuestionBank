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
@implementation InterfaceService

//上传用户头像
-(BOOL)uploadUserInfo:(UserInfo *)userInfo{
//    NSString *serveraddress = [NSString stringWithFormat:@"http://www.jizhehome.com/app/register.c?u="];
     NSString *serveraddress = [[NSString stringWithFormat:@"http://www.jizhehome.com/app/register.c"] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];

    NSURL *url =[ NSURL URLWithString :serveraddress ];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    // 字符串使用 GBK 编码，因为 servlet 只识别 GBK
    NSStringEncoding enc= CFStringConvertEncodingToNSStringEncoding (kCFStringEncodingMacChineseSimp );
    // NSStringEncoding enc= CFStringConvertEncodingToNSStringEncoding (NSUTF8StringEncoding );
    [request setStringEncoding :enc];
    
//    NSDictionary *userDic = @{@"user_id":userInfo.userID,@"name":userInfo.name,@"company":userInfo.company};
//    
//    NSError *error;
//    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:userDic options:NSJSONWritingPrettyPrinted error:&error];
//    NSString *json =[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSString *photoPath = [[Catalog getPhotoForlder]stringByAppendingString:[NSString stringWithFormat:@"%@.png",userInfo.userID]];
    [request setRequestMethod:@"post"];
    [request setPostValue :userInfo.userID forKey : @"user_id" ];
    [request setPostValue :userInfo.name forKey : @"name" ];
    [request setPostValue :userInfo.company forKey : @"company" ];
    NSString *photo = [[NSBundle mainBundle]pathForResource:@"Photo_Default" ofType:@"png"];
    NSArray *compoments = [photo componentsSeparatedByString:@"/"];
    //[request setPostValue:[compoments lastObject] forKey:@"img_file"];
    if ([[NSFileManager defaultManager]fileExistsAtPath:photoPath]) {
        
    }
    [request setFile:photo forKey:@"png" ];
    [request setFile:photo withFileName:[compoments lastObject] andContentType:nil forKey:@"img_file"];
//    [ request setDelegate : self ];
//    [ request setDidFinishSelector : @selector ( responseComplete:)];
//    [ request setDidFailSelector : @selector (responseFailed:)];
    [ request startSynchronous ];
    NSError *error = [request error];
    if (!error) {

    }
    else{
        NSLog(@"error is:%@",error);
    }
    return YES;
}

-(BOOL)uploadAnswerRecord:(NSDictionary *)recordDic{
    BOOL success = NO;
    NSError *error;
    NSString *serveraddress = [NSString stringWithFormat:@"http://www.jizhehome.com/app/record.c?user_id=%@&score=%@&time_long=%d",[recordDic objectForKey:@"user_id"],[recordDic objectForKey:@"score"],[[recordDic objectForKey:@"duration"]integerValue]];
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

-(NSArray *)loadAnswerRaking{
    NSString *serveraddress = [NSString stringWithFormat:@"http://www.jizhehome.com/app/sort.c"];
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
    NSString *urlString = [userInfo objectForKey:@"headUrl"];
    [self requestPhotoImageFile:urlString];
    
}

//请求头像
- (void)requestPhotoImageFile:(NSString *)urlString
{
    if (urlString) {
        NSString *fullPhotoPath = [[Catalog getPhotoForlder] stringByAppendingPathComponent:[urlString lastPathComponent]];
        if (![[NSFileManager defaultManager]fileExistsAtPath:fullPhotoPath]) {
            ASIHTTPRequest *photoRequest = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:urlString]];
            [photoRequest setDownloadDestinationPath:fullPhotoPath];
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
@end

//
//  Catlog.m
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-4.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "Catalog.h"

@implementation Catalog

+(NSString *)getPhotoForlder{
   NSString *forlderPath = [NSString stringWithFormat:@"%@%@/", [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0],@"/Photo"];
    if (![[NSFileManager defaultManager]fileExistsAtPath:forlderPath]) {
        [[NSFileManager defaultManager]createDirectoryAtPath:forlderPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    return forlderPath;

}

+(NSString *)getCompanyFilePath{
    NSString *filePath = [NSString stringWithFormat:@"%@%@", [NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0],@"/Company.plist"];
//    if (![[NSFileManager defaultManager]fileExistsAtPath:forlderPath]) {
//        [[NSFileManager defaultManager]createDirectoryAtPath:forlderPath withIntermediateDirectories:YES attributes:nil error:nil];
//    }
    return filePath;
}
@end

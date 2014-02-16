//
//  DeviceInfo.m
//  QuestionBank
//
//  Created by hanbo on 14-2-16.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "DeviceInfo.h"
#import "OpenUDID.h"

@implementation DeviceInfo

+(NSString *)getOpenUDID{
    NSString *udid = [OpenUDID value];
    return udid;
}
@end

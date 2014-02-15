//
//  DateMethod.m
//  QuestionBank
//
//  Created by hanbo on 14-2-15.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "DateMethod.h"

@implementation DateMethod

+(NSString *)timestampFromString:(NSString *)time{
    NSString *timestampStr = nil;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    
    NSDate *destDate= [dateFormatter dateFromString:time];
    NSDate *nowDate = [NSDate date];
    NSTimeInterval timestamp = [nowDate timeIntervalSinceDate:destDate];
    NSTimeInterval oneDaySecond = 60 * 60 * 24;
    NSTimeInterval oneHourSecond = 60 * 60;
    if (timestamp > oneDaySecond) {
        NSInteger day = timestamp / oneDaySecond;
        timestampStr = [NSString stringWithFormat:@"%ld天前",day];
    }

    else if (timestamp > oneHourSecond){
        NSInteger hour = timestamp / oneHourSecond;
        timestampStr = [NSString stringWithFormat:@"%ld小时前",hour];
    }
    else if (timestamp > 60){
        NSInteger minute = timestamp / 60;
        timestampStr = [NSString stringWithFormat:@"%ld分钟前",minute];
    }
    else{
        NSInteger sencond = (NSInteger)timestamp % 60;
        timestampStr = [NSString stringWithFormat:@"%ld秒前",sencond];
    }
    [dateFormatter release];
    return timestampStr;
    
}

@end

//
//  Chapter.h
//  QuestionBank
//
//  Created by 李 雷川 on 13-12-21.
//  Copyright (c) 2013年 李 雷川. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Chapter : NSObject{
    NSInteger     ID;
    NSString      *name;
    
    NSInteger     amount;
}
@property(nonatomic, assign) NSInteger     ID;
@property(nonatomic, retain) NSString      *name;
@property(nonatomic, assign) NSInteger     amount;

@end

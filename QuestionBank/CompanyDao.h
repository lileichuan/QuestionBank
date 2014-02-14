//
//  CompanyDao.h
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-18.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseDao.h"

@interface Company : NSObject{
    NSString   *name;
}
@property(nonatomic, retain)NSString   *name;

@end

@interface CompanyDao : BaseDao

-(BOOL)insertCompany:(Company *)_company;

-(BOOL)clearCompany;

-(NSArray *)getCompanys;

-(NSArray *)searchCompanysWithName:(NSString *)searchKey;

@end

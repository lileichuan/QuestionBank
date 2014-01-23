//
//  CompanyDao.m
//  QuestionBank
//
//  Created by 李 雷川 on 14-1-18.
//  Copyright (c) 2014年 李 雷川. All rights reserved.
//

#import "CompanyDao.h"
#define TABLE_NAME @"Company"
@implementation Company
@synthesize name;
-(void)dealloc{
    if (name) {
        [name release];
        name = nil;
    }
    [super dealloc];
}

@end

@implementation CompanyDao

-(BOOL)insertCompany:(Company *)_company{
    BOOL success = YES;
	[db executeUpdate:[self SQL:@"INSERT INTO %@ (name) VALUES(?)" inTable:TABLE_NAME],
   _company.name
     ];
    if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
		success = NO;
    }
	return success;
}

-(NSArray *)getCompanys{
    NSMutableArray *arr = nil;
    FMResultSet *rs =[db executeQuery:[self SQL:@"SELECT * FROM %@ " inTable:TABLE_NAME]];
	while ([rs next]){
        if (!arr) {
            arr = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
        }
        Company *company = [self analysisCompanyWithRS:rs];
        [arr addObject:company];
    }
    if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
	}
    return arr;
}

-(NSArray *)searchCompanysWithName:(NSString *)name{
    NSMutableArray *arr = nil;
    NSString *pro = [NSString stringWithFormat:@"select * from %@ where name like \'",TABLE_NAME];
	
    //	NSString *likeBef = [NSString stringWithString:@"\%"];
    //	NSString *likeAft = [NSString stringWithString:@"\%'"];
    NSString *likeBef = @"\%";
    NSString *likeAft = @"\%";
    
	
	NSString *sql = [pro stringByAppendingString:likeBef];
	sql = [sql stringByAppendingString:name];
	sql = [sql stringByAppendingString:likeAft];
	NSLog(@"searchBar sql:\n%@", sql);
    FMResultSet *rs =[db executeQuery:sql];
	while ([rs next]){
        if (!arr) {
            arr = [[[NSMutableArray alloc]initWithCapacity:0]autorelease];
        }
        Company *company = [self analysisCompanyWithRS:rs];
        [arr addObject:company];
    }
    if ([db hadError]) {
		NSLog(@"Err %d: %@", [db lastErrorCode], [db lastErrorMessage]);
	}
    return arr;
}
-(Company *)analysisCompanyWithRS:(FMResultSet*)rs{
    Company *company = [[[Company alloc]init]autorelease];
    company.name = [rs stringForColumn:@"name"];
    return company;
}
@end

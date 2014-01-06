//
//  SqliteInterface.m
//  CALayer
//
//  Created by Terry on 11-5-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SqliteInterface.h"


@implementation SqliteInterface

@synthesize  db;
@synthesize dbRealPath;

SqliteInterface *sharedSqliteInterface;

+ (SqliteInterface *) sharedSqliteInterface
{
	if (!sharedSqliteInterface) {
		sharedSqliteInterface = [[SqliteInterface alloc] init];
	}
	return sharedSqliteInterface;
}


- (void) connectDB
{
	if (db == nil) {
		db = [[FMDatabase alloc] initWithPath:dbRealPath];
	}
	if (![db open]) {
		NSLog(@"Could not open database.");
	}else {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        BOOL isHasDatabase = [defaults boolForKey:@"isCreateDatabase"];
        if (!isHasDatabase) {
           BOOL success = [self createDatabase];
            if (success) {
                [defaults setBool:YES forKey:@"isCreateDatabase"];
            }
        }
        [defaults synchronize];
		NSLog(@"DataBase has already opened");
	}
	
}
- (void) closeDB
{ 
    if (db == nil) {
        return;
    }
	[db close];
	[db release],
    db= nil;
	NSLog(@"DataBase has already close");
}


- (void) setupDB:(NSString *)dbFileName
{
	if (dbFileName == nil) {
		return;
	}
    if (db) {
         [[SqliteInterface sharedSqliteInterface] closeDB]; //关闭数据库
    }
	
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
	NSString *libraryPath = [paths objectAtIndex:0];
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *err;

    dbRealPath = [libraryPath stringByAppendingString:[NSString stringWithFormat:@"/%@",dbFileName]];
	if (![fileManager fileExistsAtPath:dbRealPath]) {
		NSString *dbSrcPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:dbFileName];
		BOOL copySuccess = [fileManager copyItemAtPath:dbSrcPath toPath:dbRealPath error:&err];
		if (copySuccess) {
            NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
            NSNumber *datebaseVersion =[self getDatebaseVersionCode];
            [defaults setValue:datebaseVersion forKey:@"DatebaseVersion"];
            [defaults synchronize];
		}
        else{
            NSLog(@"Failed to copy dataBase %@",[err localizedDescription]);
        }
	}

	NSLog(@"dbRealPath: %@",dbRealPath);
}


-(NSNumber *)getDatebaseVersionCode{
    NSString *versionCodePath = [[NSBundle mainBundle]pathForResource:@"VersionCode" ofType:@"plist"];
    NSDictionary *versionDic = [NSDictionary dictionaryWithContentsOfFile:versionCodePath];
    NSNumber *versionCode = [versionDic objectForKey:@"DatebaseVersion"];
    return versionCode;
}



-(BOOL)createDatabase{
    BOOL success = NO;
    //增加了表ResourceGroup(ID,name,course_id,material_ids)，课程表增加resource_ids
    BOOL result1 = [db executeUpdate:@"Create table if not exists question (id integer PRIMARY KEY,question text,chapter_id integer,section_id integer,explain text,star boolen,media_type integer,option_type integer,error boolen)"];
    
    BOOL result2 =[db executeUpdate:@"Create table if not exists answer (id integer PRIMARY KEY,question_id integer,content text,score float)"];
    
    BOOL result3 =[db executeUpdate:@"Create table if not exists history_record (question_id integer,answer_ids text,score float,test_paper_id integer,PRIMARY KEY(question_id,test_paper_id))"];
    

    BOOL result4 =[db executeUpdate:@"Create table if not exists test_paper (id integer PRIMARY KEY,created_time double,duration integer,error_num integer,correct_num integer ,un_write_num integer,socre float,question_ids text)"];
    
    BOOL result5 =[db executeUpdate:@"Create table if not exists chapter (id integer PRIMARY KEY,name text)"];
    
    BOOL result6 =[db executeUpdate:@"Create table if not exists userInfo (id text PRIMARY KEY,name text,company text)"];
      success = result1&& result2 && result3 && result4 && result5 && result6;
    return success;
}



- (void)dealloc
{
	//[db release];
	[dbRealPath release];
	[super dealloc];
}

@end

//
//  SqliteInterface.h
//  CALayer
//
//  Created by Terry on 11-5-30.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"

@class FMDatabase;
@interface SqliteInterface : NSObject {
	NSString *dbRealPath;
	FMDatabase *db;
}

@property (nonatomic, retain) NSString *dbRealPath;
@property (nonatomic, retain) FMDatabase *db;

+(SqliteInterface *) sharedSqliteInterface;
- (void) connectDB;
- (void) closeDB;
- (void) setupDB : (NSString *)dbFileName;

@end

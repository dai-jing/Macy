//
//  DBManager.m
//  Macy
//
//  Created by Kobe Dai on 5/18/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import "DBManager.h"

static DBManager *sharedInstance = nil;
static sqlite3 *database = nil;
static sqlite3_stmt *statement = nil;

@implementation DBManager

// get singleton variable
+ (DBManager *)sharedInstance {
    
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        
        sharedInstance = [[DBManager alloc] init];
    });
    
    return sharedInstance;
}

- (BOOL)createDatabase {
    
    // Get the documents directory
    NSArray *docDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory = docDirectories[0];
    
    NSString *databasePath = [[NSString alloc] initWithString: [docDirectory  stringByAppendingPathComponent: @"macy.db"]];
    
    BOOL success = YES;
    
    // check the DB path is exiting or not
    
    if (![[NSFileManager defaultManager] fileExistsAtPath: databasePath]) {
        
        const char *dbPath = [databasePath UTF8String];
        
        if (sqlite3_open(dbPath, &database) == SQLITE_OK) {
            
            char *errMessage;
            const char *sql_stmt = "CREATE TABLE IF NOT EXISTS PRODUCTS (ID TEXT PRIMARY KEY, NAME TEXT, DESCRIPTION TEXT, REGULARPRICE TEXT, SALEPRICE TEXT, PRODUCTPHOTOURL TEXT, COLORSSTRING TEXT, STORESSTRING TEXT)";
            if (sqlite3_exec(database, sql_stmt, NULL, NULL, &errMessage) != SQLITE_OK) {
                success = NO;
                NSLog(@"Failed to create table");
            }
            
            sqlite3_close(database);
            
            return success;
        }
        
    } else {
        
        success = NO;
        NSLog(@"Failed to open database");
    }
    
    return success;
}

- (NSArray *)findAllProducts {
    
    // Get the documents directory
    NSArray *docDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory = docDirectories[0];
    NSString *databasePath = [[NSString alloc] initWithString: [docDirectory  stringByAppendingPathComponent: @"macy.db"]];
    const char *dbPath = [databasePath UTF8String];
    
    if (sqlite3_open(dbPath, &database) == SQLITE_OK) {
        
        NSString *query = @"SELECT * FROM PRODUCTS";
        NSMutableArray *products = [NSMutableArray new];
        
        if (sqlite3_prepare_v2(database, [query UTF8String], -1, &statement, NULL) == SQLITE_OK) {
            
            while (sqlite3_step(statement) == SQLITE_ROW) {
                
                NSMutableArray *product = [NSMutableArray new];
                NSString *id = [[NSString alloc] initWithUTF8String: (const char *)sqlite3_column_text(statement, 0)];
                [product addObject: id];
                NSString *name = [[NSString alloc] initWithUTF8String: (const char *)sqlite3_column_text(statement, 1)];
                [product addObject: name];
                NSString *description = [[NSString alloc] initWithUTF8String: (const char *)sqlite3_column_text(statement, 2)];
                [product addObject: description];
                NSString *regularPrice = [[NSString alloc] initWithUTF8String: (const char *)sqlite3_column_text(statement, 3)];
                [product addObject: regularPrice];
                NSString *salePrice = [[NSString alloc] initWithUTF8String: (const char *)sqlite3_column_text(statement, 4)];
                [product addObject: salePrice];
                NSString *productPhotoUrl = [[NSString alloc] initWithUTF8String: (const char *)sqlite3_column_text(statement, 5)];
                [product addObject: productPhotoUrl];
                NSString *colorsString = [[NSString alloc] initWithUTF8String: (const char *)sqlite3_column_text(statement, 6)];
                [product addObject: colorsString];
                NSString *storesString = [[NSString alloc] initWithUTF8String: (const char *)sqlite3_column_text(statement, 7)];
                [product addObject: storesString];
                
                [products addObject: product];
            }
            
            return products;
            
            //sqlite3_reset(statement);
        }
    }
    
    return nil;
}

- (BOOL)insertProductWithName: (NSString *)name
              withDescription: (NSString *)description
             withRegularPrice: (NSString *)regularPrice
                withSalePrice: (NSString *)salePrice
          withProductPhotpUrl: (NSString *)productPhotoUrl
             withColorsString: (NSString *)colorsString
             withStoresString: (NSString *)storesString
                       withId: (NSString *)id
{
    
    // Get the documents directory
    NSArray *docDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory = docDirectories[0];
    NSString *databasePath = [[NSString alloc] initWithString: [docDirectory  stringByAppendingPathComponent: @"macy.db"]];
    const char *dbPath = [databasePath UTF8String];
    
    if (sqlite3_open(dbPath, &database) == SQLITE_OK) {
        
        NSString *query = [NSString stringWithFormat:@"INSERT INTO PRODUCTS (ID, NAME, DESCRIPTION, REGULARPRICE, SALEPRICE, PRODUCTPHOTOURL, COLORSSTRING, STORESSTRING) VALUES (\"%@\", \"%@\",\"%@\", \"%@\", \"%@\", \"%@\", \"%@\", \"%@\")", id, name, description, regularPrice, salePrice, productPhotoUrl, colorsString, storesString];
        sqlite3_prepare_v2(database, [query UTF8String], -1,  &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE) {
            return YES;
        } else {
            return NO;
        }
        
        sqlite3_reset(statement);
    }
    
    return NO;
}

- (BOOL)deleteProductWithId: (NSString *)id {
    
    NSArray *docDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory = docDirectories[0];
    NSString *databasePath = [[NSString alloc] initWithString: [docDirectory  stringByAppendingPathComponent: @"macy.db"]];
    const char *dbPath = [databasePath UTF8String];
    
    if (sqlite3_open(dbPath, &database) == SQLITE_OK) {
        NSString *query = [NSString stringWithFormat: @"DELETE FROM PRODUCTS WHERE ID = \"%@\"", id];
        sqlite3_prepare_v2(database, [query UTF8String], -1,  &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE) {
            return YES;
        } else {
            return NO;
        }
        
        sqlite3_reset(statement);
    }
    
    return NO;
}

- (BOOL)updateProductWithId: (NSString *)id
                   withName: (NSString *)name
            withDescription: (NSString *)description
           withRegularPrice: (NSString *)regularPrice
              withSalePrice: (NSString *)salePrice
        withProductPhotpUrl: (NSString *)productPhotoUrl
           withColorsString: (NSString *)colorsString
           withStoresString: (NSString *)storesString
{
    
    // Get the documents directory
    NSArray *docDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory = docDirectories[0];
    NSString *databasePath = [[NSString alloc] initWithString: [docDirectory  stringByAppendingPathComponent: @"macy.db"]];
    const char *dbPath = [databasePath UTF8String];
    
    if (sqlite3_open(dbPath, &database) == SQLITE_OK) {
        NSString *query = [NSString stringWithFormat: @"UPDATE PRODUCTS SET NAME=\"%@\", DESCRIPTION=\"%@\", REGULARPRICE=\"%@\", SALEPRICE=\"%@\", PRODUCTPHOTOURL=\"%@\", COLORSSTRING=\"%@\", STORESSTRING=\"%@\" WHERE ID = \"%@\"", name, description, regularPrice, salePrice, productPhotoUrl, colorsString, storesString, id];
        sqlite3_prepare_v2(database, [query UTF8String], -1,  &statement, NULL);
        if (sqlite3_step(statement) == SQLITE_DONE) {
            return YES;
        } else {
            return NO;
        }
        
        sqlite3_reset(statement);
    }
    
    return NO;
}

@end

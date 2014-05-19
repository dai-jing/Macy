//
//  DBManager.h
//  Macy
//
//  Created by Kobe Dai on 5/18/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBManager : NSObject

+ (DBManager *)sharedInstance;  // get singleton variable

- (BOOL)createDatabase;

- (NSArray *)findAllProducts;

- (BOOL)insertProductWithName: (NSString *)name
              withDescription: (NSString *)description
             withRegularPrice: (NSString *)regularPrice
                withSalePrice: (NSString *)salePrice
          withProductPhotpUrl: (NSString *)productPhotoUrl
             withColorsString: (NSString *)colorsString
             withStoresString: (NSString *)storesString
                       withId: (NSString *)id;

- (BOOL)deleteProductWithId: (NSString *)id;

- (BOOL)updateProductWithId: (NSString *)id
                   withName: (NSString *)name
            withDescription: (NSString *)description
           withRegularPrice: (NSString *)regularPrice
              withSalePrice: (NSString *)salePrice
        withProductPhotpUrl: (NSString *)productPhotoUrl
           withColorsString: (NSString *)colorsString
           withStoresString: (NSString *)storesString;

@end

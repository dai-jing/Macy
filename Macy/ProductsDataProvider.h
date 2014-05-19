//
//  ProductsDataProvider.h
//  Macy
//
//  Created by Kobe Dai on 5/17/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^loadSuccess)(NSArray *products);
typedef void (^loadFailed)(NSError *error);

@interface ProductsDataProvider : NSObject

+ (id)sharedInstance;

- (void)loadJsonDataPath:(NSString *)path
             onSuccess:(loadSuccess)onSuccess
               onError:(loadFailed)onError;

@end

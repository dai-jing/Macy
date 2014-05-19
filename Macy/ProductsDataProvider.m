//
//  ProductsDataProvider.m
//  Macy
//
//  Created by Kobe Dai on 5/17/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import "ProductsDataProvider.h"

@implementation ProductsDataProvider

+ (id)sharedInstance {
    
    static ProductsDataProvider *provider = nil;
    
    @synchronized(self) {
        
        provider = [[ProductsDataProvider alloc] init];
        
        return provider;
    }
}

- (void)loadJsonDataPath:(NSString *)path
               onSuccess:(loadSuccess)onSuccess
                 onError:(loadFailed)onError
{
    NSData *data = [NSData dataWithContentsOfFile: path];
    NSError *error = nil;
    id result = [NSJSONSerialization JSONObjectWithData: data
                                                options: kNilOptions
                                                  error: &error];
    // Load data failed.
    if (error) {
        
        onError(error);
        
    // Load data success
    } else {
        
        onSuccess(result);
    }
}

@end

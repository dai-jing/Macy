//
//  Product.h
//  Macy
//
//  Created by Kobe Dai on 5/17/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Product : NSObject

@property (nonatomic) NSString *id;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *description;
@property (nonatomic) NSString *regularPrice;
@property (nonatomic) NSString *salePrice;
@property (nonatomic) NSString *productPhotoUrl;
@property (nonatomic) NSArray *colors;
@property (nonatomic) NSDictionary *stores;

@end

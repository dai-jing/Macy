//
//  ProductDetailsViewController.h
//  Macy
//
//  Created by Kobe Dai on 5/18/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProductDetailsViewController : UIViewController

@property (nonatomic) NSArray *dataArray;
@property (nonatomic) IBOutlet UITextField *nameField;
@property (nonatomic) IBOutlet UITextView *descriptionView;
@property (nonatomic) IBOutlet UITextField *priceField;
@property (nonatomic) IBOutlet UITextField *salesPriceField;
@property (nonatomic) IBOutlet UITextField *colorsField;
@property (nonatomic) IBOutlet UITextField *storesField;
@property (nonatomic) IBOutlet UIButton *deleteButton;
@property (nonatomic) IBOutlet UIButton *saveButton;

@end

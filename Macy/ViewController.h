//
//  ViewController.h
//  Macy
//
//  Created by Kobe Dai on 5/17/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic) IBOutlet UIButton *showProductsButton;
@property (nonatomic) IBOutlet UIButton *createProductButton;

- (IBAction)showProducts: (id)sender;
- (IBAction)createProduct :(id)sender;

@end

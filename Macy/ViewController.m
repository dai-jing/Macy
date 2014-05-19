//
//  ViewController.m
//  Macy
//
//  Created by Kobe Dai on 5/17/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ShowProductsViewController.h"
#import "CreateProductViewController.h"
#import "ProductsDataProvider.h"
#import "DBManager.h"

@interface ViewController ()

@property (nonatomic) ShowProductsViewController *showProductsVC;
@property (nonatomic) CreateProductViewController *createProductVC;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.showProductsButton.layer.cornerRadius = 4.0f;
    self.showProductsButton.layer.borderColor = [UIColor blueColor].CGColor;
    self.showProductsButton.layer.borderWidth = 1.0f;
    
    self.createProductButton.layer.cornerRadius = 4.0f;
    self.createProductButton.layer.borderColor = [UIColor blueColor].CGColor;
    self.createProductButton.layer.borderWidth = 1.0f;
    
    DBManager *dbMgr = [DBManager sharedInstance];
    
    BOOL success = [dbMgr createDatabase];
    NSLog(@"create db success: %d", success);
}

- (IBAction)showProducts:(id)sender {
    
    if (self.showProductsVC == nil) {
        self.showProductsVC = [[ShowProductsViewController alloc] init];
    }
    
    [self.navigationController pushViewController: _showProductsVC animated: YES];
}

- (IBAction)createProduct:(id)sender {
    
    if (self.createProductVC == nil) {
        self.createProductVC = [[CreateProductViewController alloc] init];
    }
    
    [self.navigationController pushViewController: _createProductVC animated: YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

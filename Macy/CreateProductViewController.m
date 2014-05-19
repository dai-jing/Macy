//
//  CreateProductViewController.m
//  Macy
//
//  Created by Kobe Dai on 5/18/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import "CreateProductViewController.h"
#import "ProductsDataProvider.h"
#import "Product.h"
#import "DBManager.h"

@interface CreateProductViewController ()

@property (nonatomic) NSMutableArray *dataArray;

@property (nonatomic) IBOutlet UIButton *firstProductButton;
@property (nonatomic) IBOutlet UIButton *secondProductButton;
@property (nonatomic) IBOutlet UIButton *thirdProductButton;

@end

@implementation CreateProductViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.firstProductButton.layer.cornerRadius = 4.0f;
    self.firstProductButton.layer.borderColor = [UIColor blueColor].CGColor;
    self.firstProductButton.layer.borderWidth = 1.0f;
    
    self.secondProductButton.layer.cornerRadius = 4.0f;
    self.secondProductButton.layer.borderColor = [UIColor blueColor].CGColor;
    self.secondProductButton.layer.borderWidth = 1.0f;
    
    self.thirdProductButton.layer.cornerRadius = 4.0f;
    self.thirdProductButton.layer.borderColor = [UIColor blueColor].CGColor;
    self.thirdProductButton.layer.borderWidth = 1.0f;
    
    self.navigationItem.title = @"Create Product";
    
    ProductsDataProvider *provider = [ProductsDataProvider sharedInstance];
    
    NSString *jsonString = [[NSBundle mainBundle] pathForResource: @"Products" ofType: @"json"];
    [provider loadJsonDataPath: jsonString
                     onSuccess:^(NSArray *products) {
                         
                         [self loadProductsWithArray: products];
                         
                         //NSLog(@"%@", products);
                         
                     } onError:^(NSError *error) {
                         
                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"Load Failed"
                                                                             message: @"JSON data load failed"
                                                                            delegate: nil
                                                                   cancelButtonTitle: @"OK"
                                                                   otherButtonTitles: nil];
                         [alertView show];
                     }];
}

- (void)loadProductsWithArray: (NSArray *)arr {
    
    self.dataArray = [NSMutableArray new];
    
    for (NSDictionary *dict in arr) {
        
        Product *newProduct = [Product new];
        newProduct.id = [dict objectForKey: @"id"];
        newProduct.name = [dict objectForKey: @"name"];
        newProduct.description = [dict objectForKey: @"description"];
        newProduct.regularPrice = [dict objectForKey: @"regularPrice"];
        newProduct.salePrice = [dict objectForKey: @"salePrice"];
        newProduct.productPhotoUrl = [dict objectForKey: @"productPhoto"];
        newProduct.colors = [dict objectForKey: @"colors"];
        newProduct.stores = [dict objectForKey: @"stores"];
        
        [_dataArray addObject: newProduct];
    }
}

- (IBAction)addFirstProduct:(id)sender {
    
    if (_dataArray.count >= 1) {
        
        Product *product = _dataArray[0];
        
        [self insertProduct: product];
        
    } else {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"Insert Failed"
                                                            message: @"Product 1 inserted failed"
                                                           delegate: nil
                                                  cancelButtonTitle: @"OK"
                                                  otherButtonTitles: nil];
        [alertView show];
    }
}

- (IBAction)addSecondProduct:(id)sender {
    
    if (_dataArray.count >= 2) {
        
        Product *product = _dataArray[1];
        
        [self insertProduct: product];
        
    } else {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"Insert Failed"
                                                            message: @"Product 2 inserted failed"
                                                           delegate: nil
                                                  cancelButtonTitle: @"OK"
                                                  otherButtonTitles: nil];
        [alertView show];
    }
}

- (IBAction)addThirdProduct:(id)sender {
    
    if (_dataArray.count >= 3) {
        
        Product *product = _dataArray[2];
        
        [self insertProduct: product];
        
    } else {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"Insert Failed"
                                                            message: @"Product 3 inserted failed"
                                                           delegate: nil
                                                  cancelButtonTitle: @"OK"
                                                  otherButtonTitles: nil];
        [alertView show];
    }
}

#pragma mark - private methods

- (void)insertProduct: (Product *)product {
    
    DBManager *dbMgr = [DBManager sharedInstance];
    
    NSString *colorString = @"";
    for (int i = 0; i < product.colors.count; i++) {
        if (i == product.colors.count-1) {
            colorString = [colorString stringByAppendingString: product.colors[i]];
        } else {
            colorString = [colorString stringByAppendingString: [NSString stringWithFormat: @"%@,", product.colors[i]]];
        }
    }
    
    NSString *storesString = @"";
    for (int i = 0; i < product.stores.allKeys.count; i++) {
        if (i == product.stores.allKeys.count-1) {
            storesString = [storesString stringByAppendingString: [NSString stringWithFormat: @"%@:%@", product.stores.allKeys[i], [product.stores objectForKey: product.stores.allKeys[i]]]];
        } else {
            storesString = [storesString stringByAppendingString: [NSString stringWithFormat: @"%@:%@,", product.stores.allKeys[i], [product.stores objectForKey: product.stores.allKeys[i]]]];
        }
    }
    
    BOOL insertSuccess = [dbMgr insertProductWithName: product.name
                                      withDescription: product.description
                                     withRegularPrice: product.regularPrice
                                        withSalePrice: product.salePrice
                                  withProductPhotpUrl: product.productPhotoUrl
                                     withColorsString: colorString
                                     withStoresString: storesString
                                               withId: product.id];
    
    if (insertSuccess) {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"Insert Success"
                                                            message: @"Product inserted success"
                                                           delegate: nil
                                                  cancelButtonTitle: @"OK"
                                                  otherButtonTitles: nil];
        [alertView show];
        
    } else {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"Insert Failed"
                                                            message: @"Product inserted failed"
                                                           delegate: nil
                                                  cancelButtonTitle: @"OK"
                                                  otherButtonTitles: nil];
        [alertView show];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

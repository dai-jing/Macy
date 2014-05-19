//
//  ShowProductsViewController.m
//  Macy
//
//  Created by Kobe Dai on 5/18/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import "ShowProductsViewController.h"
#import "ProductsDataProvider.h"
#import "ShowProductsCell.h"
#import "DBManager.h"
#import "Product.h"
#import "ProductDetailsViewController.h"

@interface ShowProductsViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) IBOutlet UITableView *productTableView;
@property (nonatomic) ProductsDataProvider *productsDataProvider;

@property (nonatomic) NSArray *dataArray;

@end

@implementation ShowProductsViewController

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
    
    self.navigationItem.title = @"Products";
    
    DBManager *dbMgr = [DBManager sharedInstance];
    
    self.dataArray = [dbMgr findAllProducts];
    
    if (self.dataArray == nil) self.dataArray = [NSArray new];
    
    UINib *cellNib = [UINib nibWithNibName: @"ShowProductsCell" bundle: nil];
    [self.productTableView registerNib: cellNib forCellReuseIdentifier: @"ProductCell"];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear: animated];
    
    DBManager *dbMgr = [DBManager sharedInstance];
    
    self.dataArray = [dbMgr findAllProducts];
    
    if (self.dataArray == nil) self.dataArray = [NSArray new];
    
    [self.productTableView reloadData];
}

#pragma mark - UITableView data source methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"ProductCell";
    
    UINib *cellNib = [UINib nibWithNibName: @"ShowProductsCell" bundle: nil];
    [self.productTableView registerNib: cellNib forCellReuseIdentifier: CellIdentifier];
    
    ShowProductsCell *cell = [tableView dequeueReusableCellWithIdentifier: CellIdentifier];
    
    if (cell == nil) {
        
        cell = [[ShowProductsCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier: CellIdentifier];
    }
    
    NSArray *arr = _dataArray[indexPath.row];
    
    cell.nameLabel.text = arr[1];
    cell.descriptionLabel.text = arr[2];
    cell.priceLabel.text = arr[3];
    cell.salePriceLabel.text = arr[4];
    
    // load image in background
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        NSData *imageData = [NSData dataWithContentsOfURL: [NSURL URLWithString: arr[5]]];
        UIImage *image = [UIImage imageWithData: imageData];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            cell.theImageView.image = image;
        });
    });
    
    return cell;
}

#pragma mark - UITableView delegate methods

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 200.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    ProductDetailsViewController *detailsVC = [[ProductDetailsViewController alloc] init];
    
    detailsVC.dataArray = _dataArray[indexPath.row];
    
    [self.navigationController pushViewController: detailsVC animated: YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  ProductDetailsViewController.m
//  Macy
//
//  Created by Kobe Dai on 5/18/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import "ProductDetailsViewController.h"
#import "DBManager.h"

@interface ProductDetailsViewController () <UITextFieldDelegate, UITextViewDelegate, UIAlertViewDelegate>

@end

@implementation ProductDetailsViewController

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
    
    self.nameField.text = self.dataArray[1];
    self.descriptionView.text = self.dataArray[2];
    self.priceField.text = self.dataArray[3];
    self.salesPriceField.text = self.dataArray[4];
    self.colorsField.text = self.dataArray[6];
    self.storesField.text = self.dataArray[7];
    
    self.deleteButton.layer.cornerRadius = 4.0f;
    self.deleteButton.layer.borderColor = [UIColor blueColor].CGColor;
    self.deleteButton.layer.borderWidth = 1.0f;
    
    self.saveButton.layer.cornerRadius = 4.0f;
    self.saveButton.layer.borderColor = [UIColor blueColor].CGColor;
    self.saveButton.layer.borderWidth = 1.0f;
}

#pragma mark UITextField delegate methods

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    return YES;
}

#pragma mark UITextView delegate methods

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

- (IBAction)deleteButtonPressed:(id)sender {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"Delete Product"
                                                        message: @"Are you sure to delete this product?"
                                                       delegate: self
                                              cancelButtonTitle: @"NO"
                                              otherButtonTitles: @"YES", nil];
    [alertView show];
}

- (IBAction)saveButtonPressed:(id)sender {
    
    DBManager *dbMgr = [DBManager sharedInstance];
    BOOL success = [dbMgr updateProductWithId: self.dataArray[0]
                                     withName: self.nameField.text
                              withDescription: self.descriptionView.text
                             withRegularPrice: self.priceField.text
                                withSalePrice: self.salesPriceField.text
                          withProductPhotpUrl: self.dataArray[5]
                             withColorsString: self.colorsField.text
                             withStoresString: self.storesField.text];
    
    if (success) {
        [self.navigationController popViewControllerAnimated: YES];
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle: @"Update Success"
                                                            message: @"Product updated successfully"
                                                           delegate: nil
                                                  cancelButtonTitle: @"OK"
                                                  otherButtonTitles: nil];
        [alertView show];
        
    } else {
        NSLog(@"update error");
    }
}

#pragma mark - UIAlertView delegate methods

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 1) {
        DBManager *dbMgr = [DBManager sharedInstance];
        BOOL success = [dbMgr deleteProductWithId: self.dataArray[0]];
        
        if (success) {
            [self.navigationController popViewControllerAnimated: YES];
        } else {
            NSLog(@"delete error");
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

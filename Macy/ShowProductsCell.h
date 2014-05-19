//
//  ShowProductsCell.h
//  Macy
//
//  Created by Kobe Dai on 5/18/14.
//  Copyright (c) 2014 Jing Dai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowProductsCell : UITableViewCell

@property (nonatomic) IBOutlet UIImageView *theImageView;
@property (nonatomic) IBOutlet UILabel *nameLabel;
@property (nonatomic) IBOutlet UILabel *descriptionLabel;
@property (nonatomic) IBOutlet UILabel *priceLabel;
@property (nonatomic) IBOutlet UILabel *salePriceLabel;

@end

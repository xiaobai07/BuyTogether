//
//  FeedContributionStatusTableViewCell.h
//  BuyTogether
//
//  Created by Zeng Wang on 8/23/14.
//  Copyright (c) 2014 yuebai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedContributionStatusTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *minimalContribution;
@property (weak, nonatomic) IBOutlet UITextField *contribution;
@property (weak, nonatomic) IBOutlet UILabel *contributedAmount;
@property (weak, nonatomic) IBOutlet UILabel *totalContribution;
@end

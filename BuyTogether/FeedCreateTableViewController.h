//
//  FeedCreateTableViewController.h
//  BuyTogether
//
//  Created by Zeng Wang on 8/23/14.
//  Copyright (c) 2014 yuebai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedCreateTableViewController : UITableViewController

@property (nonatomic, strong) NSString *eventName;
@property (nonatomic, strong) NSString *description;
@property (nonatomic, strong) NSString *productLink;
@property (nonatomic, strong) NSString *fundingGoal;
@property (nonatomic, strong) NSString *minimalContribution;
@property (nonatomic, strong) NSString *venmoAcount;

@end

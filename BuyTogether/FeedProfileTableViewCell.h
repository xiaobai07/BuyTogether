//
//  FeedProfileTableViewCell.h
//  BuyTogether
//
//  Created by Zeng Wang on 8/23/14.
//  Copyright (c) 2014 yuebai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedProfileTableViewCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *organizerProfile;
@property (strong, nonatomic) IBOutlet UIImageView *feedProfile;
@property (strong, nonatomic) IBOutlet UILabel *feedName;
@property (strong, nonatomic) IBOutlet UILabel *timeLabel;

@end

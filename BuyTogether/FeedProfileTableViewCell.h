//
//  FeedProfileTableViewCell.h
//  BuyTogether
//
//  Created by Zeng Wang on 8/23/14.
//  Copyright (c) 2014 yuebai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedProfileTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *organizerProfile;
@property (weak, nonatomic) IBOutlet UILabel *feedNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end

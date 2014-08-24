//
//  FeedTableViewCell.h
//  BuyTogether
//
//  Created by Zeng Wang on 8/23/14.
//  Copyright (c) 2014 yuebai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *oragnizerProfile;
@property (weak, nonatomic) IBOutlet UIImageView *contributorOneProfile;
@property (weak, nonatomic) IBOutlet UIImageView *contributorTwoProfile;
@property (weak, nonatomic) IBOutlet UIImageView *contributorThreeProfile;
@property (weak, nonatomic) IBOutlet UILabel *eventName;
@property (weak, nonatomic) IBOutlet UILabel *eventDescription;
@property (weak, nonatomic) IBOutlet UILabel *eventStatus;
@end

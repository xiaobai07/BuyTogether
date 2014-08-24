//
//  FeedContributorTableViewCell.m
//  BuyTogether
//
//  Created by Zeng Wang on 8/23/14.
//  Copyright (c) 2014 yuebai. All rights reserved.
//

#import "FeedContributorTableViewCell.h"

@implementation FeedContributorTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    self.contributorOneProfile.layer.cornerRadius = 20;
    self.contributorOneProfile.clipsToBounds = YES;
    self.contributorTwoProfile.layer.cornerRadius = 20;
    self.contributorTwoProfile.clipsToBounds = YES;
    self.contributorThreeProfile.layer.cornerRadius = 20;
    self.contributorThreeProfile.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

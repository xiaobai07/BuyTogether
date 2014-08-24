//
//  FeedTableViewCell.m
//  BuyTogether
//
//  Created by Zeng Wang on 8/23/14.
//  Copyright (c) 2014 yuebai. All rights reserved.
//

#import "FeedTableViewCell.h"

@implementation FeedTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    //    self.contributorOneProfile.hidden = YES;
    //    self.contributorTwoProfile.hidden = YES;
    //    self.contributorThreeProfile.hidden = YES;
    self.oragnizerProfile.layer.cornerRadius = 20;
    self.oragnizerProfile.clipsToBounds = YES;
    self.contributorOneProfile.layer.cornerRadius = 10;
    self.contributorOneProfile.clipsToBounds = YES;
    self.contributorTwoProfile.layer.cornerRadius = 10;
    self.contributorTwoProfile.clipsToBounds = YES;
    self.contributorThreeProfile.layer.cornerRadius = 10;
    self.contributorThreeProfile.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

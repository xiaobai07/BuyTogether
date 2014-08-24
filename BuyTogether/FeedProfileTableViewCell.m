//
//  FeedProfileTableViewCell.m
//  BuyTogether
//
//  Created by Zeng Wang on 8/23/14.
//  Copyright (c) 2014 yuebai. All rights reserved.
//

#import "FeedProfileTableViewCell.h"

@implementation FeedProfileTableViewCell

- (void)awakeFromNib
{
    // Initialization code
    self.organizerProfile.layer.cornerRadius = 10;
    self.organizerProfile.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

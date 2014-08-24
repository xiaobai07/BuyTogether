//
//  FeedDetailTableViewController.h
//  BuyTogether
//
//  Created by Zeng Wang on 8/23/14.
//  Copyright (c) 2014 yuebai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedDetailTableViewController : UITableViewController<UIAlertViewDelegate,UIWebViewDelegate>
@property (nonatomic,strong)PFObject *feedObject;
@end

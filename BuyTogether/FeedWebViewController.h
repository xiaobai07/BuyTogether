//
//  FeedWebViewController.h
//  BuyTogether
//
//  Created by Zeng Wang on 8/24/14.
//  Copyright (c) 2014 yuebai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedWebViewController : UIViewController

@property (strong, nonatomic) NSString *link;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

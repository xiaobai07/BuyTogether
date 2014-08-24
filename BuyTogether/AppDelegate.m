//
//  AppDelegate.m
//  BuyTogether
//
//  Created by xiao bai on 8/22/14.
//  Copyright (c) 2014 yuebai. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // ****************************************************************************
    // Fill in with your Parse credentials:
    // ****************************************************************************
    [Parse setApplicationId:@"HZy3BcNvHq6ioNRSkJMMC9O3klpbzGCigu7kHTgJ" clientKey:@"pCPbte6AjX5mpIXPm18X4vbJaE5sDYKw2hkAVOVk"];
    
    // ****************************************************************************
    // Your Facebook application id is configured in Info.plist.
    // ****************************************************************************
    // Configured
    
    // ****************************************************************************
    // Fill in with your Venmo credentials:
    // ****************************************************************************
    [Venmo startWithAppId:@"1914" secret:@"AFGXEU3KHee4gZCgpVskVXW9P2JY7MdY" name:@"BuyTogether"];
    
    [PFFacebookUtils initializeFacebook];
    
    // Override point for customization after application launch.
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[LoginViewController alloc] init]];
    //self.window.rootViewController = [[LoginViewController alloc] init];
    //self.window.rootViewController = [[LoginViewController alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;

    
    }

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    //NSLog(@"%@",url);
    NSString *urlString = [url absoluteString];
    if ([[urlString substringToIndex:2] isEqualToString:@"fb"]) {
        return [PFFacebookUtils handleOpenURL:url];
    }
    if ([[Venmo sharedInstance] handleOpenURL:url]) {
        return YES;
    }
    // You can add your app-specific url handling code here if needed
    return NO;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
    // Handle the user leaving the app while the Facebook login dialog is being shown
    // For example: when the user presses the iOS "home" button while the login dialog is active
    [FBAppCall handleDidBecomeActive];
}
- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

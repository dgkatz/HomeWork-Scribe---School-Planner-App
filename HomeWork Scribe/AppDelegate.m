//
//  AppDelegate.m
//  HomeWork Scribe
//
//  Created by Family on 3/14/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "AppDelegate.h"
#import "dataClass.h"
#import "SWRevealViewController.h"
#import "setUpViewController.h"
#import "GAITracker.h"
#import "GAI.h"
@interface AppDelegate ()

@end
NSArray *defaultSubjectsArray;
@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    
    // Optional: set Google Analytics dispatch interval to e.g. 20 seconds.
    [GAI sharedInstance].dispatchInterval = 20;
    
    // Optional: set Logger to VERBOSE for debug information.
    [[[GAI sharedInstance] logger] setLogLevel:kGAILogLevelVerbose];
    
    // Initialize tracker. Replace with your tracking ID.
    [[GAI sharedInstance] trackerWithTrackingId:@"UA-63188021-1"];
    // Override point for customization after application launch.
    dataClass *obj = [dataClass getInstance];
    
    UIUserNotificationType types = UIUserNotificationTypeBadge |
    UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    
    UIUserNotificationSettings *mySettings =
    [UIUserNotificationSettings settingsForTypes:types categories:nil];
    
    [[UIApplication sharedApplication] registerUserNotificationSettings:mySettings];
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [UITextField appearance].keyboardAppearance = UIKeyboardAppearanceDark;
    if ([[UINavigationBar class] respondsToSelector:@selector(appearance)])
    {
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:255/255.0 green:151/255.0 blue:0/255.0 alpha:1.0f]]; //// change'l.
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
        [[UINavigationBar appearance]setTranslucent:NO];
    }

    obj.assignmentData_Subject = [[NSMutableArray alloc]init];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
                                                            bundle: nil];
//    UINavigationController *VC = (UINavigationController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"setupnav"];
//    self.window.rootViewController = VC;
//    [self.window makeKeyAndVisible];

    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce1"])
    {
        SWRevealViewController *VC = (SWRevealViewController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"begin"];
        self.window.rootViewController = VC;
        [self.window makeKeyAndVisible];
        // app already launched
    }
    else
    {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasLaunchedOnce1"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        UINavigationController *VC = (UINavigationController *)[mainStoryboard instantiateViewControllerWithIdentifier:@"setupnav"];
        self.window.rootViewController = VC;
        [self.window makeKeyAndVisible];

        // This is the first launch ever
    }
    [[UIView appearanceWhenContainedIn:[UIAlertController class], nil] setTintColor:[UIColor orangeColor]];
    //[[UIView appearanceWhenContainedIn:[UITableView class],[UIDatePicker class], nil] setBackgroundColor:[UIColor orangeColor]];
    //if ([UIActionSheet respondsToSelector:selector])

    return YES;
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end

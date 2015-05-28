//
//  allTableViewController.h
//  HomeWork Scribe
//
//  Created by Daniel Katz on 3/15/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"
#import "SWRevealViewController.h"
#import "JFMinimalNotification.h"
#import "LCZoomTransition.h"
@interface allTableViewController : UITableViewController<JFMinimalNotificationDelegate,SWRevealViewControllerDelegate,UIToolbarDelegate>
@property (strong, nonatomic) IBOutlet UIBarButtonItem *barButton;
@property (nonatomic, strong) DBManager *dbManager;
@property (strong, nonatomic)  UIView *shadowView;
@property (nonatomic, strong) LCZoomTransition *transition;
@end

//
//  UpcomingController.h
//  HomeWork Scribe
//
//  Created by Daniel Katz on 4/23/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"

@interface UpcomingController : UITableViewController
@property (nonatomic, strong) DBManager *dbManager;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *barButton;

@end

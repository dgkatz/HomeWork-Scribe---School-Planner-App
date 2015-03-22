//
//  allTableViewController.h
//  HomeWork Scribe
//
//  Created by Daniel Katz on 3/15/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"
@interface allTableViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UIBarButtonItem *barButton;
@property (nonatomic, strong) DBManager *dbManager;

@end

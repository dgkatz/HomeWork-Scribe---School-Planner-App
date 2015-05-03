//
//  settingsTableViewController.h
//  HomeWork Scribe
//
//  Created by Daniel Katz on 4/22/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"
@interface settingsTableViewController : UITableViewController<UIAlertViewDelegate>
@property (nonatomic, strong) DBManager *dbManager;
@end

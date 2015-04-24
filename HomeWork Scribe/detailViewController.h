//
//  detailViewController.h
//  HomeWork Scribe
//
//  Created by Daniel Katz on 4/22/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"
@interface detailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *assignmentTableView;
@property (strong, nonatomic) IBOutlet UILabel *subjectLabel;
@property (strong, nonatomic) IBOutlet UILabel *duedateLabel;
@property (nonatomic, strong) DBManager *dbManager;
@property (strong, nonatomic) IBOutlet UIButton *assingmentcomButton;

@end

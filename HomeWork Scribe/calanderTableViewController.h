//
//  calanderTableViewController.h
//  HomeWork Scribe
//
//  Created by Family on 3/14/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//
#import "PDTSimpleCalendar.h"
#import "PDTSimpleCalendarViewController.h"
#import "PDTSimpleCalendarViewCell.h"
#import "PDTSimpleCalendarViewHeader.h"
#import <UIKit/UIKit.h>
@interface calanderTableViewController : UITableViewController<PDTSimpleCalendarViewDelegate,PDTSimpleCalendarViewCellDelegate>
@property(weak,nonatomic) IBOutlet UIBarButtonItem *barButton;
@end

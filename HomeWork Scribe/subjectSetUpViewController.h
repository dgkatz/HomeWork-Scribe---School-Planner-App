//
//  subjectSetUpViewController.h
//  HomeWork Scribe
//
//  Created by Daniel Katz on 5/4/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PDTSimpleCalendar.h"
#import "PDTSimpleCalendarViewController.h"
#import "PDTSimpleCalendarViewCell.h"
#import "PDTSimpleCalendarViewHeader.h"
@interface subjectSetUpViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,PDTSimpleCalendarViewCellDelegate,PDTSimpleCalendarViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *subjectTableView;
@property (copy) NSString *newdSubject;
@property (strong)NSMutableArray *subjects;
- (IBAction)doneClicked:(id)sender;
@end

//
//  detailViewController.h
//  HomeWork Scribe
//
//  Created by Daniel Katz on 4/22/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DBManager.h"
#import <MessageUI/MessageUI.h>
#import <BFPaperView/BFPaperView.h>
@interface detailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate,MFMailComposeViewControllerDelegate,UIActionSheetDelegate,MFMessageComposeViewControllerDelegate>
@property (strong, nonatomic) IBOutlet UITableView *assignmentTableView;
@property (nonatomic, strong) DBManager *dbManager;
@property (strong, nonatomic) IBOutlet UIButton *assingmentcomButton;

@end

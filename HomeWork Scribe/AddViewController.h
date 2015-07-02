//
//  AddViewController.h
//  HomeWork Scribe
//
//  Created by Family on 3/14/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XLFormViewController.h"
#import "DBManager.h"

@interface AddViewController : XLFormViewController<UIAlertViewDelegate,UITextViewDelegate,XLFormDescriptorDelegate>
@property(weak,nonatomic) IBOutlet UIBarButtonItem *barButton;
@property (nonatomic, strong) DBManager *dbManager;
extern NSString *const XLFormRowDescriptorTypeImage;
@end

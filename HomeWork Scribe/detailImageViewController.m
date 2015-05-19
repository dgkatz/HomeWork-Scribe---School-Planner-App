//
//  detailImageViewController.m
//  HomeWork Scribe
//
//  Created by Daniel Katz on 5/19/15.
//  Copyright (c) 2015 Stratton Apps. All rights reserved.
//

#import "detailImageViewController.h"
#import "dataClass.h"
#import "detailViewController.h"
@interface detailImageViewController ()

@end

@implementation detailImageViewController
-(void)viewDidAppear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    self.navigationController.navigationBar.tintColor = [UIColor orangeColor];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    dataClass *obj = [dataClass getInstance];
    /*
    [self.assignmentImageView setImage:obj.chosenAssignmentImage];
    self.assignmentImageView.frame = CGRectMake(self.assignmentImageView.frame.origin.x, self.assignmentImageView.frame.origin.y,
                                 obj.chosenAssignmentImage.size.width, obj.chosenAssignmentImage.size.height);
     */
    NSData *imageData = UIImagePNGRepresentation(obj.chosenAssignmentImage);
    NSString *base = [imageData base64EncodedStringWithOptions:kNilOptions];
    NSMutableString *HTMLString = [[NSMutableString alloc]initWithString:@"<html><body>"];
    [HTMLString appendString:[NSString stringWithFormat:@"<img src='data:image/png;base64,%@'>",base]];
    [HTMLString appendString:@"</body></html>"];
    
    NSString *htmlString = [NSString stringWithFormat:
                            @"<html>"
                            "<head>"
                            "<script type=\"text/javascript\" >"
                            "function display(img){"
                            "var imgOrigH = document.getElementById('image').offsetHeight;"
                            "var imgOrigW = document.getElementById('image').offsetWidth;"
                            "var bodyH = window.innerHeight;"
                            "var bodyW = window.innerWidth;"
                            "if((imgOrigW/imgOrigH) > (bodyW/bodyH))"
                            "{"
                            "document.getElementById('image').style.width = bodyW + 'px';"
                            "document.getElementById('image').style.top = (bodyH - document.getElementById('image').offsetHeight)/2  + 'px';"
                            "}"
                            "else"
                            "{"
                            "document.getElementById('image').style.height = bodyH + 'px';"
                            "document.getElementById('image').style.marginLeft = (bodyW - document.getElementById('image').offsetWidth)/2  + 'px';"
                            "}"
                            "}"
                            "</script>"
                            "</head>"
                            "<body style=\"margin:0;width:100%;height:100%;\" >"
                            "<img id=\"image\" src='data:image/png;base64,%@' onload=\"display()\" style=\"position:relative\" />"
                            "</body>"
                            "</html>",base
                            ];
    
    
    [self.imageWebView loadHTMLString:htmlString baseURL:[[NSBundle mainBundle] bundleURL]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)pop:(id)sender {
    detailViewController *purchaseContr = (detailViewController *)[self.storyboard instantiateViewControllerWithIdentifier:@"Expander"];

    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

//
//  RegimenDayController.h
//  Regimen
//
//  Created by Sayem Islam on 10/3/12.
//  Copyright (c) 2012 HatTrick Labs, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddGoalViewController.h"
#import "RegimenCell.h"

@interface RegimenDayController : UIViewController <UITableViewDelegate, UITableViewDataSource, AddGoalViewControllerDelegate> 

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet RegimenCell *regimenCell;

- (IBAction)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer;

@end

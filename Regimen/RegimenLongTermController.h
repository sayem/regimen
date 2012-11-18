//
//  RegimenLongTermController.h
//  Regimen
//
//  Created by Sayem Islam on 10/4/12.
//  Copyright (c) 2012 HatTrick Labs, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddGoalViewController.h"

@interface RegimenLongTermController : UIViewController <UITableViewDelegate, UITableViewDataSource, AddGoalViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

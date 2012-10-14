//
//  RegimenSecondViewController.m
//  Regimen
//
//  Created by Sayem Islam on 10/3/12.
//  Copyright (c) 2012 HatTrick Labs, LLC. All rights reserved.
//

#import "RegimenWeekController.h"

@interface RegimenWeekController ()

@end

@implementation RegimenWeekController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSDate *today = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM"];

    NSCalendar *gregorian = [[NSCalendar alloc]
                             initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:(NSDayCalendarUnit | NSWeekdayCalendarUnit) fromDate:today];
    [components setDay:([components day]-([components weekday]-1))];
    
    NSInteger week_start = [components day];
    NSInteger week_end = [components day] + 6;
    NSString *week = [NSString stringWithFormat:@"%@ %d - %d", [formatter stringFromDate:today], week_start, week_end];
    
    UINavigationItem *nav = [self navigationItem];
    [nav setTitle:week];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

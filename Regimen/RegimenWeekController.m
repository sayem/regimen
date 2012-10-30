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
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *components = [gregorian components:NSWeekdayCalendarUnit fromDate:today];
    
    NSTimeInterval minusDays = ([components weekday]-1) * 24 * 60 * 60;
    NSTimeInterval plusDays = (7-[components weekday]) * 24 * 60 * 60;
    
    NSDate *startWeek = [[NSDate alloc] initWithTimeIntervalSinceNow:-minusDays];
    NSDate *endWeek = [[NSDate alloc] initWithTimeIntervalSinceNow:plusDays];
    
    NSDateComponents *sunday = [gregorian components:(NSDayCalendarUnit | NSMonthCalendarUnit) fromDate:startWeek];
    NSDateComponents *saturday = [gregorian components:(NSDayCalendarUnit | NSMonthCalendarUnit) fromDate:endWeek];
    
    NSString *week = [NSString stringWithFormat:@"%d/%d - %d/%d", [sunday month], [sunday day],[saturday month], [saturday day]];
    
    UINavigationItem *nav = [self navigationItem];
    [nav setTitle:week];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

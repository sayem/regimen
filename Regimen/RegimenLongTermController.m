//
//  RegimenLongTermController.m
//  Regimen
//
//  Created by Sayem Islam on 10/4/12.
//  Copyright (c) 2012 HatTrick Labs, LLC. All rights reserved.
//

#import "RegimenLongTermController.h"

@interface RegimenLongTermController ()

@end

@implementation RegimenLongTermController

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UINavigationItem *nav = [self navigationItem];
    [nav setTitle:@"Long-Term"];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

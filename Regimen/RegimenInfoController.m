//
//  RegimenInfoController.m
//  Regimen
//
//  Created by Sayem Khan on 12/24/12.
//  Copyright (c) 2012 HatTrick Labs, LLC. All rights reserved.
//

#import "RegimenInfoController.h"

@implementation RegimenInfoController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *htmlFile = [[NSBundle mainBundle] pathForResource:@"RegimenInfo" ofType:@"html"];
	NSData *htmlData = [NSData dataWithContentsOfFile:htmlFile];
	NSURL *baseURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] bundlePath]];
	[self.webView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:baseURL];
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	self.webView = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close
{
	[self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}


@end

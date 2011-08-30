//
//  ImageBrightnessAppDelegate.m
//  ImageBrightness
//
//  Created by Jorge on 1/28/09.
//  Copyright __MyCompanyName__ 2009. All rights reserved.
//

#import "ImageBrightnessAppDelegate.h"
#import "MainView.h"

@implementation ImageBrightnessAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
	MainView *v=[[MainView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
	[window addSubview:v];
    // Override point for customization after application launch
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end

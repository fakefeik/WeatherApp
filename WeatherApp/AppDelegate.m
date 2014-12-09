//
//  AppDelegate.m
//  MyFirstApp
//
//  Created by Admin on 21.10.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "AppDelegate.h"
#import "Weather.h"
#import "TimeViewController.h"
#import "ForecastViewController.h"
#import "URLConnection.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    URLConnection *connection = [[[URLConnection alloc] initWithUrl:[NSURL URLWithString:@"http://api.openweathermap.org/data/2.5/forecast?q=Yekaterinburg&mode=xml"] target:self] autorelease];
    [[NSOperationQueue mainQueue] addOperation:connection];
    return YES;
}

- (void)didUrlLoadSucceed:(NSMutableData *)loadedContent {
    [self loadForecastViewControllerWithData:loadedContent];
}

- (void)didUrlLoadFail:(NSError *)error {
    NSLog(@"Load from Url failed...");
    NSLog(@"Loading data from local storage.");
    [self loadForecastViewControllerWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"forecast" ofType:@"xml"]]];
}

- (void)loadForecastViewControllerWithData:(NSData *)data {
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    ForecastViewController *ctrl = [[[ForecastViewController alloc] initWithNibName:@"ForecastView" bundle:[NSBundle mainBundle]] autorelease];
    ctrl.data = data;
    UINavigationController *naviCtrl = [[[UINavigationController alloc] initWithRootViewController:ctrl] autorelease];
    
    self.window.rootViewController = naviCtrl;
    [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}

@end

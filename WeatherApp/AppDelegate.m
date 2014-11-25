//
//  AppDelegate.m
//  MyFirstApp
//
//  Created by Admin on 21.10.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "AppDelegate.h"
#import "Weather.h"
#import "ForecastTimeViewController.h"
#import "ForecastViewController.h"
#import "URLConnection.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    URLConnection *connection = [[[URLConnection alloc] init] autorelease];
    [connection getData:[NSURL URLWithString:@"http://api.openweathermap.org/data/2.5/forecast?q=Yekaterinburg&mode=xml"] target:self];
    return YES;
}

- (void)didUrlLoadSucceed:(NSMutableData *)loadedContent {
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    ForecastViewController *ctrl = [[[ForecastViewController alloc] initWithNibName:@"ForecastView" bundle:[NSBundle mainBundle]] autorelease];
    ctrl.data = loadedContent;
    UINavigationController *naviCtrl = [[[UINavigationController alloc] initWithRootViewController:ctrl] autorelease];
    
    self.window.rootViewController = naviCtrl;
    [self.window makeKeyAndVisible];
}

- (void)didUrlLoadFail:(NSError *)error {
    NSLog(@"FAILED!");
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

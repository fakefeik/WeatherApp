//
//  AppDelegate.h
//  MyFirstApp
//
//  Created by Admin on 21.10.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "URLConnectionDelegate.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, URLConnectionDelegate>

@property (strong, nonatomic) UIWindow *window;

@end


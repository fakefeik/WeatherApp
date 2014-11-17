//
//  ForecastViewController.h
//  MyFirstApp
//
//  Created by Admin on 05.11.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherDelegate.h"

@interface ForecastViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, WeatherDelegate>

@end

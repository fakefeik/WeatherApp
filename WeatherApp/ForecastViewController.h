//
//  ForecastViewController.h
//  MyFirstApp
//
//  Created by Admin on 05.11.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherDelegate.h"
#import "URLConnectionDelegate.h"
#import "ForecastTableViewCell.h"

@interface ForecastViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, WeatherDelegate, URLConnectionDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) IBOutlet ForecastTableViewCell *tableViewCell;
@property (retain) NSData *data;

@end

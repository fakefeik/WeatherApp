//
//  ForecastTimeViewController.h
//  MyFirstApp
//
//  Created by Admin on 29.10.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherDelegate.h"

@interface ForecastTimeViewController : UIViewController {
    NSUInteger ptr;
    Weather* content;
    
    UIImageView* image;
    UIButton* button;
    
    UILabel* country;
    UILabel* city;
    UILabel* latitude;
    UILabel* longitude;
    
    UILabel* from;
    UILabel* to;
    UILabel* type;
    UILabel* windVelocity;
    UILabel* windDirection;
    UILabel* temperature;
    UILabel* pressure;
    UILabel* humidity;
}

@property (retain) Weather* content;
@property NSUInteger ptr;

@end

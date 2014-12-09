//
//  Weather.h
//  MyFirstApp
//
//  Created by Admin on 22.10.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Forecast.h"
#import "WeatherDelegate.h"

@interface Weather : NSObject {
    @private
    NSString *city;
    NSString *country;
    NSNumber *latitude;
    NSNumber *longitude;
    Forecast *forecast;
}

@property (copy) NSString *city;
@property (copy) NSString *country;
@property (retain) NSNumber *latitude;
@property (retain) NSNumber *longitude;
@property (retain) Forecast *forecast;
@property (copy) NSString *sunRise;
@property (copy) NSString *sunSet;

@end

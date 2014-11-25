//
//  WeatherDelegate.h
//  MyFirstApp
//
//  Created by Admin on 22.10.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Weather;

@protocol WeatherDelegate <NSObject>

- (void)didWeatherLoadSucceed:(Weather *)loadedContent;
- (void)didWeatherLoadFail:(NSError *)error;

@end

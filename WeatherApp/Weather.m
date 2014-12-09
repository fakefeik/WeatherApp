//
//  Weather.m
//  MyFirstApp
//
//  Created by Admin on 22.10.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "Weather.h"

@implementation Weather

- (id)init {
    if (self = [super init]) {
        self.forecast = [[Forecast alloc] init];
    }
    return self;
}

- (void)dealloc {
    [city release];
    [country release];
    [latitude release];
    [longitude release];
    [forecast release];
    [self release];
    [super dealloc];
}

- (NSString *)description {
    return [NSString stringWithFormat: @"Weather: City: %@; Country: %@; Latitude: %@; Longitude: %@.",
            self.city, self.country, self.latitude, self.longitude];
}

@synthesize city;
@synthesize country;
@synthesize latitude;
@synthesize longitude;
@synthesize forecast;
@synthesize sunRise;
@synthesize sunSet;

@end

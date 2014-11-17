//
//  Forecast.m
//  MyFirstApp
//
//  Created by Admin on 22.10.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "Forecast.h"

@implementation Forecast

- (id) init {
    if (self = [super init]) {
        self.times = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) dealloc {
    [from release];
    [to release];
    [dawn release];
    [dusk release];
    [times release];
    [self release];
    [super dealloc];
}

- (NSString*) description {
    return [NSString stringWithFormat: @"Forecast: From: %@; To: %@; Dawn: %@; Dusk: %@.",
            self.from, self.to, self.dawn, self.dusk];
}

@synthesize from;
@synthesize to;
@synthesize dawn;
@synthesize dusk;
@synthesize times;

@end

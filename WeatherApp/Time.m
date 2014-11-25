//
//  Time.m
//  MyFirstApp
//
//  Created by Admin on 22.10.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "Time.h"

@implementation Time

- (id)init {
    if (self = [super init]) {
        
    }
    return self;
}

- (void)dealloc {
    [self release];
    [self.from release];
    [self.to release];
    [self.quantity release];
    [self.windDirection release];
    [self.windVelocity release];
    [self.temperature release];
    [self.pressure release];
    [self.humidity release];
    [super dealloc];
}

- (NSString *)description {
    return @"Some time";
}

@synthesize from;
@synthesize to;
@synthesize type;
@synthesize quantity;
@synthesize windDirection;
@synthesize windVelocity;
@synthesize temperature;
@synthesize pressure;
@synthesize humidity;
@synthesize icon;

@end

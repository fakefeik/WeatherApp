//
//  Time.h
//  MyFirstApp
//
//  Created by Admin on 22.10.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Time : NSObject {
    @private
    NSString* from;
    NSString* to;
    NSString* type;
    NSNumber* quantity;
    NSNumber* windDirection;
    NSNumber* windVelocity;
    NSNumber* temperature;
    NSNumber* pressure;
    NSNumber* humidity;
    NSString* icon;
}

@property (retain) NSString* from;
@property (retain) NSString* to;
@property (copy) NSString* type;
@property (retain) NSNumber* quantity;
@property (retain) NSNumber* windDirection;
@property (retain) NSNumber* windVelocity;
@property (retain) NSNumber* temperature;
@property (retain) NSNumber* pressure;
@property (retain) NSNumber* humidity;
@property (copy) NSString* icon;

@end

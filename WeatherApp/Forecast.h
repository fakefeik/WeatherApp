//
//  Forecast.h
//  MyFirstApp
//
//  Created by Admin on 22.10.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Time.h"

@interface Forecast : NSObject {
    @private
    NSDate* from;
    NSDate* to;
    NSDate* dawn;
    NSDate* dusk;
    NSMutableArray* times;
}

@property (retain) NSDate* from;
@property (retain) NSDate* to;
@property (retain) NSDate* dawn;
@property (retain) NSDate* dusk;
@property (retain) NSMutableArray* times;

@end

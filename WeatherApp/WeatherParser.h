//
//  WeatherParser.h
//  WeatherApp
//
//  Created by Admin on 09.12.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"
#import "Time.h"

@interface WeatherParser : NSObject <NSXMLParserDelegate>

- (void)loadFromData:(NSData *)data target:(id<WeatherDelegate>)target;

@end

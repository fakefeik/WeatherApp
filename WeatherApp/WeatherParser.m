//
//  WeatherParser.m
//  WeatherApp
//
//  Created by Admin on 09.12.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "WeatherParser.h"

@implementation WeatherParser {
    NSString *currentElement;
    Time *tempTime;
    Weather *weather;
    id<WeatherDelegate> weatherDelegate;
}

- (id)init {
    if (self = [super init]) {
        weather = [[Weather alloc]init];
    }
    return self;
}

- (void)loadFromData:(NSData *)data target:(id<WeatherDelegate>)target {
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    weatherDelegate = target;
    parser.delegate = self;
    [parser parse];
    [parser release];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    [weatherDelegate didWeatherLoadFail:parseError];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    [weatherDelegate didWeatherLoadSucceed:weather];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    currentElement = elementName;
    if ([elementName isEqualToString:@"location"])
        if ([attributeDict count] > 0) {
            weather.latitude = [NSNumber numberWithDouble:[attributeDict[@"latitude"] doubleValue]];
            weather.longitude = [NSNumber numberWithDouble:[attributeDict[@"longitude"] doubleValue]];
        }
    if ([elementName isEqualToString:@"sun"]) {
        weather.sunRise = attributeDict[@"rise"];
        weather.sunSet = attributeDict[@"set"];
    }
    [self parseTime: elementName attributeDict: attributeDict];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    currentElement = nil;
    if ([elementName isEqualToString:@"time"]) {
        [weather.forecast.times addObject:tempTime];
        tempTime = nil;
    }
}

- (void)parseTime:(NSString *)elementName attributeDict:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:@"time"]) {
        tempTime = [[[Time alloc] init] autorelease];
        tempTime.from = attributeDict[@"from"];
        tempTime.to = attributeDict[@"to"];
    }
    if ([elementName isEqualToString:@"windDirection"])
        tempTime.windDirection = [NSNumber numberWithDouble:[attributeDict[@"deg"] doubleValue]];
    
    if ([elementName isEqualToString:@"windSpeed"])
        tempTime.windVelocity = [NSNumber numberWithDouble:[attributeDict[@"mps"] doubleValue]];
    
    if ([elementName isEqualToString:@"temperature"])
        tempTime.temperature = [NSNumber numberWithInteger:[attributeDict[@"value"] integerValue]];
    
    if ([elementName isEqualToString:@"pressure"])
        tempTime.pressure = [NSNumber numberWithDouble:[attributeDict[@"value"] doubleValue]];
    
    if ([elementName isEqualToString:@"humidity"])
        tempTime.humidity = [NSNumber numberWithInteger:[attributeDict[@"value"] integerValue]];
    
    if ([elementName isEqualToString:@"symbol"])
        if ([attributeDict count] > 0) {
            tempTime.type = attributeDict[@"name"];
            tempTime.icon = attributeDict[@"var"];
        }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if ([currentElement isEqualToString:@"name"])
        weather.city = string;
    if ([currentElement isEqualToString:@"country"])
        weather.country = string;
}

@end

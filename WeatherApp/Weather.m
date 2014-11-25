//
//  Weather.m
//  MyFirstApp
//
//  Created by Admin on 22.10.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "Weather.h"

@implementation Weather {
    NSString *currentElement;
    Time *tempTime;
}

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

- (void)loadFromFile:(NSString *)filename target:(id<WeatherDelegate>)target {
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@"xml"];
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:[NSData dataWithContentsOfFile:path]];
    self.weatherDelegate = target;
    parser.delegate = self;
    [parser parse];
    [parser release];
}

- (void)loadFromNet:(NSURL *)url target:(id<WeatherDelegate>)target {
    NSXMLParser *parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    self.weatherDelegate = target;
    parser.delegate = self;
    [parser parse];
    [parser release];
}

- (void)loadFromData:(NSData *)data target:(id<WeatherDelegate>)target {
    NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
    self.weatherDelegate = target;
    parser.delegate = self;
    [parser parse];
    [parser release];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    [self.weatherDelegate didWeatherLoadFail:parseError];
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    [self.weatherDelegate didWeatherLoadSucceed:self];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    currentElement = elementName;
    if ([elementName isEqualToString:@"location"])
        if ([attributeDict count] > 0) {
            self.latitude = [NSNumber numberWithDouble:[attributeDict[@"latitude"] doubleValue]];
            self.longitude = [NSNumber numberWithDouble:[attributeDict[@"longitude"] doubleValue]];
        }
    if ([elementName isEqualToString:@"sun"]) {
        self.sunRise = attributeDict[@"rise"];
        self.sunSet = attributeDict[@"set"];
    }
    [self parseTime: elementName attributeDict: attributeDict];
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    currentElement = nil;
    if ([elementName isEqualToString:@"time"]) {
        [self.forecast.times addObject:tempTime];
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
        self.city = string;
    if ([currentElement isEqualToString:@"country"])
        self.country = string;
}

@synthesize city;
@synthesize country;
@synthesize latitude;
@synthesize longitude;
@synthesize forecast;
@synthesize weatherDelegate;
@synthesize sunRise;
@synthesize sunSet;

@end

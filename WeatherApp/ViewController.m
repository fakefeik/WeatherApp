//
//  ViewController.m
//  MyFirstApp
//
//  Created by Admin on 21.10.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "ViewController.h"
#import "Weather.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //UILabel* label = [[UILabel alloc] init];
    //[label setText:@"abc"];
    
    //Weather*  weather = [Weather getWeather];
    //[weather retain];
    //NSLog(@"%@", weather);
    //[weather release];
    //Forecast* forecast = [Forecast getForecast];
    //[forecast retain];
    //NSLog(@"%@", forecast);
    //[forecast release];
    
    //NSURL* url = [NSURL URLWithString:@"http://api.openweathermap.org/data/2.5/forecast?q=Yekaterinburg&mode=xml"];
    //NSString* urlContents = [[NSString alloc] initWithContentsOfURL:url encoding:NSUTF8StringEncoding error: nil];
    //NSLog(@"%@", urlContents);
    //NSLog(@"printed");
    
    //NSXMLParser* parser = [[NSXMLParser alloc] initWithContentsOfURL:url];
    //[parser parse];
    
    //XMLParser* parser = [[XMLParser alloc] init: [NSData dataWithContentsOfURL:url]];
    //NSMutableArray* arr = [parser getParsedData];
    //for (int i = 0; i < arr.count; i++) {
    //    NSLog(@"%@", arr[i]);
    //}
    
    
    //NSString* filePath = [[NSBundle mainBundle] pathForResource:@"Resources/File" ofType:@"txt"];
    //NSString* fileString = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    //NSLog(@"%@", fileString);
    //NSFileManager* manager = [NSFileManager defaultManager];
    //NSArray* files = [manager directoryContentsAtPath:@"/"];
    //for (int i = 0; i < files.count; i++) {
    //    NSLog(@"%@", files[i]);
    //}
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

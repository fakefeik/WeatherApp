//
//  ForecastTimeViewController.m
//  MyFirstApp
//
//  Created by Admin on 29.10.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "ForecastTimeViewController.h"
#import "Forecast.h"
#import "Time.h"
#import "Weather.h"

@interface ForecastTimeViewController ()

@property (nonatomic, retain) IBOutlet UIImageView *image;
@property (nonatomic, retain) IBOutlet UIButton *button;

@property (nonatomic, retain) IBOutlet UILabel *country;
@property (nonatomic, retain) IBOutlet UILabel *city;
@property (nonatomic, retain) IBOutlet UILabel *latitude;
@property (nonatomic, retain) IBOutlet UILabel *longitude;


@property (nonatomic, retain) IBOutlet UILabel *from;
@property (nonatomic, retain) IBOutlet UILabel *to;
@property (nonatomic, retain) IBOutlet UILabel *type;
@property (nonatomic, retain) IBOutlet UILabel *windVelocity;
@property (nonatomic, retain) IBOutlet UILabel *windDirection;
@property (nonatomic, retain) IBOutlet UILabel *temperature;
@property (nonatomic, retain) IBOutlet UILabel *pressure;
@property (nonatomic, retain) IBOutlet UILabel *humidity;

@end

@implementation ForecastTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self updateView];
}

- (IBAction)onClick:(id)sender {
    if (ptr < [content.forecast.times count])
        [self updateView];
    else
        NSLog(@"No more data");
}

- (void)updateView {
    country.text = content.country;
    city.text = content.city;
    latitude.text = [NSString stringWithFormat:@"%@", content.latitude];
    longitude.text = [NSString stringWithFormat:@"%@", content.longitude];
    Time* time = [content.forecast.times objectAtIndex:ptr];
    from.text = time.from;
    to.text = time.to;
    type.text = time.type;
    windVelocity.text = [NSString stringWithFormat:@"%@ mps", time.windVelocity];
    windDirection.text = [NSString stringWithFormat:@"%@°", time.windDirection];
    temperature.text = [NSString stringWithFormat:@"%@°C", time.temperature];
    pressure.text = [NSString stringWithFormat:@"%@ hPa", time.pressure];
    humidity.text = [NSString stringWithFormat:@"%@%%", time.humidity];
    image.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png", time.icon]]]];
    ptr++;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@synthesize content;
@synthesize ptr;

@synthesize image;
@synthesize button;

@synthesize country;
@synthesize city;
@synthesize latitude;
@synthesize longitude;

@synthesize from;
@synthesize to;
@synthesize type;
@synthesize windVelocity;
@synthesize windDirection;
@synthesize temperature;
@synthesize pressure;
@synthesize humidity;

@end

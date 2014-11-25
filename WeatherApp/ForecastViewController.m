//
//  ForecastViewController.m
//  MyFirstApp
//
//  Created by Admin on 05.11.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "ForecastViewController.h"
#import "ForecastTimeViewController.h"
#import "Weather.h"
#import "URLConnection.h"

@interface ForecastViewController ()

@end

@implementation ForecastViewController {
    Weather *weather;
}

@synthesize tableView = _tableView;
@synthesize tableViewCell;
@synthesize data;

- (void)viewDidLoad {
    [super viewDidLoad];
    static NSString *identifier = @"ForecastTableCell";
    [[[[Weather alloc] init] autorelease] loadFromData:self.data target:self];
    UINib *cellNib = [UINib nibWithNibName:@"ForecastTableCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:identifier];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - WeatherDelegate

- (void)didWeatherLoadSucceed:(Weather *)loadedContent {
    weather = loadedContent;
    [weather retain];
}

- (void)didWeatherLoadFail:(NSError *)error {
    NSLog(@"FAILED!");
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ForecastTimeViewController *ctrl = [[ForecastTimeViewController alloc] initWithNibName:@"ForecastTimeView" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:ctrl animated:YES];
    ctrl.content = weather;
    ctrl.ptr = indexPath.row;
}

#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"ForecastTableCell";
    Time *time = [weather.forecast.times objectAtIndex:indexPath.row];
    ForecastTableViewCell *cell = (ForecastTableViewCell *)[tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[ForecastTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.description.text = time.type;
    cell.date.text = time.from;
    cell.temperature.text = [NSString stringWithFormat:@"%@°C", time.temperature];
    cell.image.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png", time.icon]]]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return weather.forecast.times.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 78;
}

@end

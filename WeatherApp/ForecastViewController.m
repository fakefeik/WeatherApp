//
//  ForecastViewController.m
//  MyFirstApp
//
//  Created by Admin on 05.11.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "ForecastViewController.h"
#import "TimeViewController.h"
#import "Weather.h"
#import "WeatherParser.h"
#import "URLConnection.h"

@interface ForecastViewController ()

@end

@implementation ForecastViewController {
    Weather *weather;
    UIRefreshControl *refreshControl;
    NSDate *lastUpdated;
}

@synthesize tableView = _tableView;
@synthesize tableViewCell;
@synthesize data;

- (void)viewDidLoad {
    [super viewDidLoad];
    static NSString *identifier = @"ForecastTableCell";
    [[[[WeatherParser alloc] init] autorelease] loadFromData:self.data target:self];
    UINib *cellNib = [UINib nibWithNibName:@"ForecastTableCell" bundle:[NSBundle mainBundle]];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:identifier];
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(updateTable) forControlEvents:UIControlEventValueChanged];
    [_tableView addSubview:refreshControl];
    lastUpdated = [NSDate date];
    [lastUpdated retain];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)updateTable {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d, h:mm a"];
    NSString *title = [NSString stringWithFormat:@"Last updated: %@", [formatter stringFromDate:lastUpdated]];
    NSDictionary *attrsDictionary = [NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:title attributes:attrsDictionary];
    refreshControl.attributedTitle = attributedTitle;
    URLConnection *connection = [[[URLConnection alloc] init] autorelease];
    [connection getData:[NSURL URLWithString:@"http://api.openweathermap.org/data/2.5/forecast?q=Yekaterinburg&mode=xml"] target:self];
    
    
}

#pragma mark - WeatherDelegate

- (void)didWeatherLoadSucceed:(Weather *)loadedContent {
    weather = loadedContent;
    [weather retain];
    [_tableView reloadData];
    lastUpdated = [NSDate date];
}

- (void)didWeatherLoadFail:(NSError *)error {
    NSLog(@"FAILED!");
}

#pragma mark - URLConnectionDelegate

- (void)didUrlLoadSucceed:(NSMutableData *)loadedContent {
    [refreshControl endRefreshing];
    [[[[WeatherParser alloc] init] autorelease] loadFromData:self.data target:self];
}

- (void)didUrlLoadFail:(NSError *)error {
    [refreshControl endRefreshing];
    UIAlertView *message = [[[UIAlertView alloc] initWithTitle:@"Lost with sauce" message:@"Are you even connected to the Internet?" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease];
    [message show];
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

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

@interface ForecastViewController ()

@end

@implementation ForecastViewController {
    NSArray* tableData;
    Weather* weather;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL* url = [NSURL URLWithString:@"http://api.openweathermap.org/data/2.5/forecast?q=Yekaterinburg&mode=xml"];
    Weather* weather = [[[Weather alloc] init] autorelease];
    [weather loadFromNet:url target:self];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) didWeatherLoadSucceed:(Weather *)loadedContent {
    weather = loadedContent;
    [weather retain];
    NSMutableArray* array = [[[NSMutableArray alloc] init] autorelease];
    for (int i = 0; i < loadedContent.forecast.times.count; i++) {
        Time* time = [loadedContent.forecast.times objectAtIndex:i];
        [array addObject:time.from];
    }
    tableData = array;
    [tableData retain];
}

- (void) didWeatherLoadFail:(NSError *)error {
    NSLog(@"FAILED!");
}

#pragma mark - UITableViewDelegate

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    ForecastTimeViewController* ctrl = [[ForecastTimeViewController alloc] initWithNibName:@"ForecastTimeView" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:ctrl animated:YES];
    ctrl.content = weather;
    ctrl.ptr = indexPath.row;
}


#pragma mark - UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    Time* time = [weather.forecast.times objectAtIndex:indexPath.row];
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    cell.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://openweathermap.org/img/w/%@.png", time.icon]]]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tableData count];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

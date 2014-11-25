//
//  ForecastTableViewCell.m
//  WeatherApp
//
//  Created by Admin on 19.11.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "ForecastTableViewCell.h"

@implementation ForecastTableViewCell

- (void)awakeFromNib {
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@synthesize description;
@synthesize date;
@synthesize image;
@synthesize temperature;

@end

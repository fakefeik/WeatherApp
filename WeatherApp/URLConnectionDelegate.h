//
//  URLConnectionDelegate.h
//  WeatherApp
//
//  Created by Admin on 25.11.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//


#import <Foundation/Foundation.h>

@protocol URLConnectionDelegate <NSObject>

- (void)didUrlLoadSucceed:(NSMutableData *)loadedContent;
- (void)didUrlLoadFail:(NSError *)error;

@end

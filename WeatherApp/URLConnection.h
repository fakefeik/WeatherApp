//
//  URLConnection.h
//  WeatherApp
//
//  Created by Admin on 25.11.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "URLConnectionDelegate.h"

@interface URLConnection : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

- (void)getData:(NSURL *)url target:(id<URLConnectionDelegate>)target;

@end

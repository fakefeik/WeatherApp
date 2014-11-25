//
//  URLConnection.m
//  WeatherApp
//
//  Created by Admin on 25.11.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "URLConnection.h"

@implementation URLConnection {
    NSMutableData *_data;
    NSURLConnection *_connection;
    id<URLConnectionDelegate> _urlConnectionDelegate;
}

- (id)init {
    if (self = [super init]) {

    }
    return self;
}

- (void)getData:(NSURL *)url target:(id<URLConnectionDelegate>)target {
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    _data = [[NSMutableData alloc] init];
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    _urlConnectionDelegate = target;
    if (!_connection) {
        _data = nil;
    }
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [_data appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    [_urlConnectionDelegate didUrlLoadSucceed:_data];
    _connection = nil;
    _data = nil;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [_urlConnectionDelegate didUrlLoadFail:error];
    _connection = nil;
    _data = nil;
}

- (void)dealloc {
    [self release];
    [_connection release];
    [_data release];
    [super dealloc];
}

@end

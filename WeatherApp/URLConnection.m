//
//  URLConnection.m
//  WeatherApp
//
//  Created by Admin on 25.11.14.
//  Copyright (c) 2014 Admin. All rights reserved.
//

#import "URLConnection.h"

@implementation URLConnection {
    BOOL executing;
    BOOL finished;
    NSMutableData *_data;
    NSURLConnection *_connection;
    NSURL *_url;
    id<URLConnectionDelegate> _urlConnectionDelegate;
}

- (id)initWithUrl:(NSURL *)url target:(id<URLConnectionDelegate>)target {
    if (self = [super init]) {
        executing = NO;
        finished = NO;
        _url = url;
        [_url retain];
        _urlConnectionDelegate = target;
        [_urlConnectionDelegate retain];
    }
    return self;
}

- (BOOL)isConcurrent {
    return YES;
}

- (BOOL)isExecuting {
    return executing;
}

- (BOOL)isFinished {
    return finished;
}

- (void)start {
    if ([self isCancelled]) {
        [self willChangeValueForKey:@"isFinished"];
        finished = YES;
        [self didChangeValueForKey:@"isFinished"];
        return;
    }
    
    [self willChangeValueForKey:@"isExecuting"];
    executing = YES;
    [self main];
    [self didChangeValueForKey:@"isExecuting"];
}

- (void)main {
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(main) withObject:nil waitUntilDone:NO];
        return;
    }
    
    NSURLRequest *request = [NSURLRequest requestWithURL:_url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
    _data = [[NSMutableData alloc] init];
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (!_connection) {
        _data = nil;
    }
}

- (void)completeOperation {
    [self willChangeValueForKey:@"isFinished"];
    [self willChangeValueForKey:@"isExecuting"];
    executing = NO;
    finished = YES;
    [self didChangeValueForKey:@"isFinished"];
    [self didChangeValueForKey:@"isExecuting"];
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
    [self completeOperation];
    [_urlConnectionDelegate didUrlLoadSucceed:_data];
    _connection = nil;
    _data = nil;
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    [self completeOperation];
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

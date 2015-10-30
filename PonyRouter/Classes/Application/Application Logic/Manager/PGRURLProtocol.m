//
//  PGRURLProtocol.m
//  PonyRouter
//
//  Created by 崔 明辉 on 15/10/30.
//  Copyright © 2015年 多玩事业部 iOS开发组 YY Inc. All rights reserved.
//

#import "PGRURLProtocol.h"
#import "PGRApplication.h"

@interface PGRURLProtocol ()

@end

@implementation PGRURLProtocol

+ (void)load {
    [NSURLProtocol registerClass:[PGRURLProtocol class]];
}

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    return [[PGRApplication sharedInstance] canOpenURL:request.URL];
}

+ (BOOL)canInitWithTask:(NSURLSessionTask *)task {
    return [[PGRApplication sharedInstance] canOpenURL:task.originalRequest.URL];
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

- (void)startLoading {
    id responseObject = [[PGRApplication sharedInstance] openURL:self.request.URL];
    if ([responseObject isKindOfClass:[NSString class]]) {
        NSData *data = [(NSString *)responseObject dataUsingEncoding:NSUTF8StringEncoding];
        [[self client] URLProtocol:self
                didReceiveResponse:[self PGRResponse:@"text/plain" contentLength:data.length]
                cacheStoragePolicy:NSURLCacheStorageNotAllowed];
        [[self client] URLProtocol:self
                       didLoadData:data];
        [[self client] URLProtocolDidFinishLoading:self];
    }
    else if ([responseObject isKindOfClass:[NSData class]]) {
        [[self client] URLProtocol:self
                didReceiveResponse:[self PGRResponse:@"application/octet-stream" contentLength:[responseObject length]]
                cacheStoragePolicy:NSURLCacheStorageNotAllowed];
        [[self client] URLProtocol:self
                       didLoadData:responseObject];
        [[self client] URLProtocolDidFinishLoading:self];
    }
    else {
        [[self client] URLProtocol:self didFailWithError:[NSError errorWithDomain:@"PonyRouter"
                                                                             code:500
                                                                         userInfo:@{}]];
    }
}

- (void)stopLoading {
    return;
}

- (NSURLResponse *)PGRResponse:(NSString *)MIMEType contentLength:(NSInteger)contentLength {
    NSURLResponse *response = [[NSURLResponse alloc] initWithURL:self.request.URL MIMEType:MIMEType expectedContentLength:contentLength textEncodingName:nil];
    return response;
}

@end

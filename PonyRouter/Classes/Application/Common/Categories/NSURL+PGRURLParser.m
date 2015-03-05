//
//  NSURL+PGRURLParser.m
//  PonyRouter
//
//  Created by 崔 明辉 on 15-3-5.
//  Copyright (c) 2015年 多玩事业部 iOS开发组 YY Inc. All rights reserved.
//

#import "NSURL+PGRURLParser.h"

NSString * NSStringByURLDecoding(NSString *string){
    return [string stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

@implementation NSURL (PGRURLParser)

- (NSDictionary *)pgr_parseAsPathInfo {
    if ([self path].length) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        __block NSString *keyString;
        __block NSString *valueString;
        NSArray *components = [[[self path] substringFromIndex:1] componentsSeparatedByString:@"/"];
        [components enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if (idx % 2 == 0) {
                keyString = obj;
            }
            else if (idx % 2 == 1) {
                valueString = obj;
            }
            if (keyString != nil && valueString != nil) {
                [result setObject:NSStringByURLDecoding(valueString)
                           forKey:NSStringByURLDecoding(keyString)];
                keyString = valueString = nil;
            }
        }];
        return [result copy];
    }
    return nil;
}

- (NSDictionary *)pgr_parseAsQueryString {
    if ([self query].length) {
        NSMutableDictionary *result = [NSMutableDictionary dictionary];
        NSString *pattern = @"([^=]+)=(.*?)&";
        NSRegularExpression *expression = [[NSRegularExpression alloc] initWithPattern:pattern
                                                                               options:kNilOptions
                                                                                 error:nil];
        NSString *query = [[self query] stringByAppendingString:@"&"];
        NSArray *matches = [expression matchesInString:query
                                               options:NSMatchingReportCompletion
                                                 range:NSMakeRange(0, [query length])];
        [matches enumerateObjectsUsingBlock:^(NSTextCheckingResult *obj, NSUInteger idx, BOOL *stop) {
            if ([obj numberOfRanges] >= 3) {
                [result setObject:NSStringByURLDecoding([query substringWithRange:[obj rangeAtIndex:2]])
                           forKey:NSStringByURLDecoding([query substringWithRange:[obj rangeAtIndex:1]])];
            }
        }];
        return result;
    }
    return nil;
}

@end

//
//  PGRNodeManager.m
//  PonyRouter
//
//  Created by 崔 明辉 on 15/3/5.
//  Copyright (c) 2015年 多玩事业部 iOS开发组 YY Inc. All rights reserved.
//

#import "PGRNodeManager.h"
#import "PGRNode.h"

@interface PGRNodeManager ()

@property (nonatomic, copy) NSArray *nodes;

@end

@implementation PGRNodeManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.nodes = @[];
    }
    return self;
}

- (void)addNode:(PGRNode *)node {
    NSMutableArray *nodes = [self.nodes mutableCopy];
    [nodes addObject:node];
    self.nodes = nodes;
}

- (PGRNode *)nodeForURL:(NSURL *)URL {
    __block PGRNode *node;
    [self.nodes enumerateObjectsUsingBlock:^(PGRNode *obj, NSUInteger idx, BOOL *stop) {
        if (!obj.usePattern) {
            if (obj.scheme == nil ||
                [[obj.scheme lowercaseString] isEqualToString:[URL.scheme lowercaseString]]) {
                if ([[obj.identifier lowercaseString] isEqualToString:[URL.host lowercaseString]]) {
                    node = obj;
                    *stop = YES;
                }
            }
        }
        else {
            BOOL schemeMatch = NO;
            BOOL identifierMatch = NO;
            
            if (obj.scheme != nil) {
                NSRegularExpression *schemeExpression = [[NSRegularExpression alloc]
                                                         initWithPattern:obj.scheme
                                                                 options:NSRegularExpressionCaseInsensitive
                                                                   error:nil];
                schemeMatch = [schemeExpression numberOfMatchesInString:URL.scheme
                                                                options:NSMatchingReportCompletion
                                                                  range:NSMakeRange(0, URL.scheme.length)];
            }
            else {
                schemeMatch = YES;
            }
            if (obj.identifier != nil) {
                NSRegularExpression *identifierExpression = [[NSRegularExpression alloc]
                                                             initWithPattern:obj.identifier
                                                             options:NSRegularExpressionCaseInsensitive
                                                             error:nil];
                identifierMatch = [identifierExpression numberOfMatchesInString:URL.host
                                                                        options:NSMatchingReportCompletion
                                                                          range:NSMakeRange(0, URL.host.length)];
            }
            if (schemeMatch && identifierMatch) {
                node = obj;
                *stop = YES;
            }
        }
    }];
    return node;
}

@end

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

@property (nonatomic, copy) NSDictionary *nodes;

@end

@implementation PGRNodeManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.nodes = @{};
    }
    return self;
}

- (void)addNode:(PGRNode *)node {
    NSMutableDictionary *nodes = [self.nodes mutableCopy];
    [nodes setObject:node forKey:node.identifier.lowercaseString];
    self.nodes = nodes;
}

- (PGRNode *)nodeForURL:(NSURL *)URL {
    return self.nodes[URL.host.lowercaseString];
}

@end

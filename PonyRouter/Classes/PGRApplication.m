//
//  PGRApplication.m
//  PonyRouter
//
//  Created by 崔 明辉 on 15/3/5.
//  Copyright (c) 2015年 多玩事业部 iOS开发组 YY Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PGRApplication.h"
#import "PGRCore.h"
#import "PGRCore+PGRPrivate.h"
#import "PGRNode.h"

@interface PGRApplication ()

@property (nonatomic, strong) PGRCore *core;

@end

@implementation PGRApplication

+ (PGRApplication *)sharedInstance {
    static PGRApplication *application;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        application = [[PGRApplication alloc] init];
    });
    return application;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.core = [[PGRCore alloc] init];
    }
    return self;
}

- (void)setConfigure:(PGRConfiguration *)configure {
    [self.core.configurationManager setConfigure:configure];
}

- (PGRConfiguration *)configure {
    return self.core.configurationManager.configure;
}

- (void)addNode:(PGRNode *)node {
    [self.core.nodeManager addNode:node];
}

- (BOOL)canOpenURL:(NSURL *)URL {
    return [self.core.nodeManager nodeForURL:URL] != nil;
}

- (void)openURL:(NSURL *)URL {
    PGRNode *node = [self.core.nodeManager nodeForURL:URL];
    if (node == nil) {
        [[UIApplication sharedApplication] openURL:URL];
    }
    else {
        node.executingBlock();
    }
}

@end

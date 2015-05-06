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
#import "PGRConfiguration.h"
#import "NSURL+PGRURLParser.h"

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
    return
    [self.core.nodeManager nodeForURL:URL] != nil &&
    (self.core.configurationManager.configure.schemes == nil ||
    [self.core.configurationManager.configure.schemes containsObject:URL.scheme]);
}

- (id)openURL:(NSURL *)URL {
    return [self openURL:URL sourceObject:nil];
}

- (id)openURL:(NSURL *)URL sourceObject:(NSObject *)sourceObject {
    PGRNode *node = [self.core.nodeManager nodeForURL:URL];
    if (node == nil) {
        [[UIApplication sharedApplication] openURL:URL];
        return nil;
    }
    else {
        if (self.core.configurationManager.configure.URLStyle == PGRURLStylePathInfo) {
            if (node.executingBlock != nil) {
                node.executingBlock(URL, [URL pgr_parseAsPathInfo], sourceObject);
            }
            if (node.returnableBlock != nil) {
                return node.returnableBlock(URL, [URL pgr_parseAsPathInfo], sourceObject);
            }
            else {
                return nil;
            }
        }
        else if (self.core.configurationManager.configure.URLStyle == PGRURLStyleQueryString) {
            if (node.executingBlock != nil) {
                node.executingBlock(URL, [URL pgr_parseAsQueryString], sourceObject);
            }
            if (node.returnableBlock != nil) {
                return node.returnableBlock(URL, [URL pgr_parseAsQueryString], sourceObject);
            }
            else {
                return nil;
            }
        }
        else {
            return nil;
        }
    }
}

@end

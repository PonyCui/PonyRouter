//
//  PGRCore.m
//  PonyRouter
//
//  Created by 崔 明辉 on 15/3/5.
//  Copyright (c) 2015年 多玩事业部 iOS开发组 YY Inc. All rights reserved.
//

#import "PGRCore.h"
#import "PGRNodeManager.h"
#import "PGRConfigurationManager.h"

@interface PGRCore ()

@property (nonatomic, strong) PGRNodeManager *nodeManager;

@property (nonatomic, strong) PGRConfigurationManager *configurationManager;

@end

@implementation PGRCore

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.nodeManager = [[PGRNodeManager alloc] init];
        self.configurationManager = [[PGRConfigurationManager alloc] init];
    }
    return self;
}

@end

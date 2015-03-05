//
//  PGRNode.m
//  PonyRouter
//
//  Created by 崔 明辉 on 15/3/5.
//  Copyright (c) 2015年 多玩事业部 iOS开发组 YY Inc. All rights reserved.
//

#import "PGRNode.h"

@implementation PGRNode

- (instancetype)initWithIdentifier:(NSString *)identifier executingBlock:(PGRNodeExecutingBlock)executingBlock {
    self = [super init];
    if (self) {
        self.identifier = identifier;
        self.executingBlock = executingBlock;
    }
    return self;
}

@end

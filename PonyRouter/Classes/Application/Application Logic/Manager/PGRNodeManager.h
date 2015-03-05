//
//  PGRNodeManager.h
//  PonyRouter
//
//  Created by 崔 明辉 on 15/3/5.
//  Copyright (c) 2015年 多玩事业部 iOS开发组 YY Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PGRNode;

@interface PGRNodeManager : NSObject

- (void)addNode:(PGRNode *)node;

- (PGRNode *)nodeForURL:(NSURL *)URL;

@end

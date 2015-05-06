//
//  PGRApplication.h
//  PonyRouter
//
//  Created by 崔 明辉 on 15/3/5.
//  Copyright (c) 2015年 多玩事业部 iOS开发组 YY Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIApplication+PGRSwizzle.h"
#import "PGRNode.h"
#import "PGRConfiguration.h"

#ifndef PGR
    #define PGR 1
#endif

@class PGRConfiguration, PGRNode;

/**
 *  PGR means 'Pony Global Router'
 *  PGR accepts PathInfo style URL (eg. wechat://sayhello/key1/value1/key2/value2....)
 *  PGR also accepts QueryString style URL (eg. wechat://sayhello/?key1=value1&key2=value2...)
 *  Default style = QueryString
 */
@interface PGRApplication : NSObject

@property (nonatomic, readwrite) PGRConfiguration *configure;

+ (PGRApplication *)sharedInstance;

- (void)addNode:(PGRNode *)node;

- (BOOL)canOpenURL:(NSURL *)URL;

- (id)openURL:(NSURL *)URL;

- (id)openURL:(NSURL *)URL sourceObject:(NSObject *)sourceObject;

@end

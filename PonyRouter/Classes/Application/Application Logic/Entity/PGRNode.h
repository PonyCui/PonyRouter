//
//  PGRNode.h
//  PonyRouter
//
//  Created by 崔 明辉 on 15/3/5.
//  Copyright (c) 2015年 多玩事业部 iOS开发组 YY Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^PGRNodeExecutingBlock)(NSURL *sourceURL, NSDictionary *params, NSObject *sourceObject);

@interface PGRNode : NSObject

/**
 *  私有接口
 *  外部应用不能通过URL进行调用，只有应用内部可以调用
 */
@property (nonatomic, assign) BOOL isPrivate;

/**
 *  标识，唯一
 */
@property (nonatomic, copy) NSString *identifier;

/**
 *  路由被触发后，将执行此Block
 */
@property (nonatomic, copy) PGRNodeExecutingBlock executingBlock;

- (void)setExecutingBlock:(PGRNodeExecutingBlock)executingBlock;

@end

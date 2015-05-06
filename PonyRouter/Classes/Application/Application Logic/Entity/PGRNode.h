//
//  PGRNode.h
//  PonyRouter
//
//  Created by 崔 明辉 on 15/3/5.
//  Copyright (c) 2015年 多玩事业部 iOS开发组 YY Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^PGRNodeExecutingBlock)(NSURL *sourceURL, NSDictionary *params, NSObject *sourceObject);

typedef id(^PGRNodeReturnableBlock)(NSURL *sourceURL, NSDictionary *params, NSObject *sourceObject);

@interface PGRNode : NSObject

/**
 *  私有接口
 *  外部应用不能通过URL进行调用，只有应用内部可以调用
 */
@property (nonatomic, assign) BOOL isPrivate;

/**
 *  使用正则匹配
 */
@property (nonatomic, assign) BOOL usePattern;

/**
 *  xxx://yyy/ <-- xxx
 */
@property (nonatomic, copy) NSString *scheme;

/**
 *  xxx://yyy/ <-- yyy
 */
@property (nonatomic, copy) NSString *identifier;

/**
 *  路由被触发后，将执行此Block
 */
@property (nonatomic, copy) PGRNodeExecutingBlock executingBlock;

/**
 *  路由被触发后，将执行此Block，同时返回Block返回的对象
 */
@property (nonatomic, copy) PGRNodeReturnableBlock returnableBlock;

- (void)setExecutingBlock:(PGRNodeExecutingBlock)executingBlock;

- (void)setReturnableBlock:(PGRNodeReturnableBlock)returnableBlock;

- (instancetype)initWithIdentifier:(NSString *)identifier
                    executingBlock:(PGRNodeExecutingBlock)executingBlock;

- (instancetype)initWithIdentifier:(NSString *)identifier
                         scheme:(NSString *)scheme
                     usePattern:(BOOL)usePattern
                 executingBlock:(PGRNodeExecutingBlock)executingBlock;

- (instancetype)initWithIdentifier:(NSString *)identifier
                   returnableBlock:(PGRNodeReturnableBlock)returnableBlock;

- (instancetype)initWithIdentifier:(NSString *)identifier
                            scheme:(NSString *)scheme
                        usePattern:(BOOL)usePattern
                    returnableBlock:(PGRNodeReturnableBlock)returnableBlock;


@end

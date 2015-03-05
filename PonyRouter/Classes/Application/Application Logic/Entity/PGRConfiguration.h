//
//  PGRConfiguration.h
//  PonyRouter
//
//  Created by 崔 明辉 on 15/3/5.
//  Copyright (c) 2015年 多玩事业部 iOS开发组 YY Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PGRURLStyle) {
    PGRURLStylePathInfo,
    PGRURLStyleQueryString
};

@interface PGRConfiguration : NSObject

@property (nonatomic, copy) NSArray *schemes;

@property (nonatomic, assign) PGRURLStyle URLStyle;

+ (PGRConfiguration *)defaultConfiguration;

@end

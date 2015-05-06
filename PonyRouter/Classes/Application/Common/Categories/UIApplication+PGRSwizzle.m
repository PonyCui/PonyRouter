//
//  UIApplication+PGRSwizzle.m
//  PonyRouter
//
//  Created by 崔 明辉 on 15-3-5.
//  Copyright (c) 2015年 多玩事业部 iOS开发组 YY Inc. All rights reserved.
//

#import <objc/runtime.h>
#import "UIApplication+PGRSwizzle.h"
#import "PGRApplication.h"

@implementation UIApplication (PGRSwizzle)

+ (void)pgr_swizzleUIApplicationMethod {
    Method origMethod = class_getInstanceMethod([UIApplication class],
                                                @selector(openURL:));
    Method replacingMethod = class_getInstanceMethod([UIApplication class],
                                                     @selector(swizzle_PGRopenURL:));
    method_exchangeImplementations(origMethod, replacingMethod);
}

- (BOOL)swizzle_PGRopenURL:(NSURL *)URL {
    if ([[PGRApplication sharedInstance] canOpenURL:URL]) {
        [[PGRApplication sharedInstance] openURL:URL];
        return YES;
    }
    else {
        return [self swizzle_PGRopenURL:URL];
    }
}

@end

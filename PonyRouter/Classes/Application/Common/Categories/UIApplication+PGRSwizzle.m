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

static const void *kPGRRouterEnabled = &kPGRRouterEnabled;

@implementation UIApplication (PGRSwizzle)
@dynamic routerEnabled;

+ (void)swizzleMethod:(SEL)origSel withMethod:(SEL)altSel{
  IMP originalIMP = class_getMethodImplementation([self class], origSel);
  IMP alterIMP = class_getMethodImplementation([self class], altSel);
  Method originalMethod = class_getInstanceMethod([self class],origSel);
  Method alterMethod = class_getInstanceMethod([self class], altSel);
  method_setImplementation(alterMethod, originalIMP);
  method_setImplementation(originalMethod, alterIMP);
}

#pragma mark - handle method swizzle
+ (void)load
{
  [self swizzleMethod:@selector(openURL:) withMethod:@selector(pgr_openURL:)];
}

- (void)setRouterEnabled:(BOOL)routerEnabled
{
  objc_setAssociatedObject(self, kPGRRouterEnabled, @(routerEnabled), OBJC_ASSOCIATION_RETAIN);
}

- (BOOL)routerEnabled
{
  return [objc_getAssociatedObject(self, kPGRRouterEnabled) boolValue];
}

- (BOOL)pgr_openURL:(NSURL *)URL {
  if ([[PGRApplication sharedInstance] canOpenURL:URL] && self.routerEnabled) {
    [[PGRApplication sharedInstance] openURL:URL];
    return YES;
  }
  else {
    return [self pgr_openURL:URL];
  }
}

@end

# PonyRouter

There's a better way lets you handle the whole application data transferring.
We faced lots of application lack of beautiful code, the modules dependency really! really! pity.

Think about this, if you wonder call a class method, you must import the class, and then alloc or use the class singleton, and call it's member or method. You don't event know that, if the class changes sometime. And you imported the class, you also imported the class dependencies. That's not good!

PonyRouter try to solve this problem.

Let's make a guess, if the class > class calling change to class > url > class calling, is it simpler?

The common style

```objective-c
//File ClassA.m
@implementation ClassA

- (NSString *)sayHello {
    return @"Hello";
}

@end
```

```objective-c
//File ClassB.m
#import "ClassA.h"

@implementation ClassB

- (void)main {
    ClassA *a = [[ClassA alloc] init];
    NSLog(@"%@", a.sayHello);
}

@end
```

The PonyRouter style
```objective-c
//File ClassA.m
@implementation ClassA

+ (void)load {
    PGRNode *node = [[PGRNode alloc] initWithIdentifier:@"wechat://sayhello/" returnableBlock:^id(NSURL *sourceURL, NSDictionary *params, NSObject *sourceObject) {
        ClassA *a = [[ClassA alloc] init];
        return a.sayHello;
    }];
    [[PGRApplication sharedInstance] addNode:node];
}

- (NSString *)sayHello {
    return @"Hello";
}

@end
```

```objective-c
//File ClassB.m
//No need to import ClassA.h now!

- (void)main {
    NSLog(@"%@", [[PGRApplication sharedInstance] openURL:[NSURL URLWithString:@"wechat://sayhello/"]]);
}

```

### Features

#### Query Params support

PGR accepts PathInfo style URL (eg. wechat://sayhello/key1/value1/key2/value2....)
PGR also accepts QueryString style URL (eg. wechat://sayhello/?key1=value1&key2=value2...)

for example
```objective-c
NSURL *URL = [NSURL URLWithString:@"demoApp://sayhello/?k1=v1&k2=v2"];
[[UIApplication sharedApplication] openURL:URL];
```
```
[node setExecutingBlock:^(NSURL *sourceURL, NSDictionary *params, NSObject *sourceObject) {
    NSLog(@"%@",params);
}];
/*
 Conlose loged:
    2015-10-30 11:19:52.216 PonyRouter[76507:948438] {
        k1 = v1;
        k2 = v2;
    }
 */
```

#### Pattern URL support

PGR accepts pattern url.

```objective-c
PGRNode *node = [[PGRNode alloc] initWithIdentifier:@".*?" scheme:@"test" usePattern:YES executingBlock:^(NSURL *sourceURL, NSDictionary *params, NSObject *sourceObject) {
}];
```

Define as below, the URL contains ```test://.*?``` will be accepted.

#### Returnable

You may return object synchronize, and you could use it as you want.

```objective-c
PGRNode *node = [[PGRNode alloc] initWithIdentifier:@"kissme" returnableBlock:^id(NSURL *sourceURL, NSDictionary *params, NSObject *sourceObject) {
    return [NSString stringWithFormat:@"%@ kissed me.", params[@"someone"]];
}];
NSURL *URL = [NSURL URLWithString:@"demoApp://kissme/?someone=Pony"];
NSString *whoKissMe = [[PGRApplication sharedInstance] openURL:URL];
[[[UIAlertView alloc] initWithTitle:nil message:whoKissMe delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
```

#### URL Protocol support

PonyRouter add a hook to URL Protocol, so, you could send request via NSURLConnect or webView AJAX(jQuery), the return value will receive as response data.

It's a simple way to deliver message from webView to Application.

Do not worry about the main thread blocking, it will call as a GCD async thread.

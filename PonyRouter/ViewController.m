//
//  ViewController.m
//  PonyRouter
//
//  Created by 崔 明辉 on 15/3/5.
//  Copyright (c) 2015年 多玩事业部 iOS开发组 YY Inc. All rights reserved.
//

#import "ViewController.h"
#import "PGRApplication.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //NSURLConnection
    [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"demoApp://kissme/?someone=Pony"]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
    }];
    
    //WebView
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"demoApp://kissme/?someone=Pony"]]];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.webView loadHTMLString:@"Now, start an AJAX Request. <script src='https://lib.sinaapp.com/js/jquery/2.0.3/jquery-2.0.3.min.js'></script><script>$.get('demoApp://kissme/?someone=Pony', function(result){alert('Message From WebView : '+result)})</script>" baseURL:nil];
    });
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleButtonTapped:(id)sender {
    NSURL *URL = [NSURL URLWithString:@"demoApp://sayhello/?k1=v1&k2=v2"];
    [[UIApplication sharedApplication] openURL:URL];
//    [[PGRApplication sharedInstance] openURL:URL];
}

- (IBAction)handleSecondButtonTapped:(id)sender {
    NSURL *URL = [NSURL URLWithString:@"test://ios.duowan.com"];
    [[UIApplication sharedApplication] openURL:URL];
}

- (IBAction)handleKissmeButtonTapped:(id)sender {
    NSURL *URL = [NSURL URLWithString:@"demoApp://kissme/?someone=Pony"];
    NSString *whoKissMe = [[PGRApplication sharedInstance] openURL:URL];
    [[[UIAlertView alloc] initWithTitle:nil message:whoKissMe delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
}


@end


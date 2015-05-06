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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
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

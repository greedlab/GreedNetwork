//
//  ViewController.m
//  Example
//
//  Created by Bell on 15/10/22.
//  Copyright © 2015年 GreedLab. All rights reserved.
//

#import "ViewController.h"
#import "GreedNetwork.h"
#import "GRTestForm.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self testRequest];
    [self testQueue];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)testRequest
{
    GRTestForm *form = [[GRTestForm alloc] init];
    form.q = @"GreedNetwork";
    [self requestWithNetworkForm:form success:^(GRNetworkResponse *responseObject) {
        NSLog(@"request:%@",responseObject.responseDictionary);
    } failure:^(NSError *error) {
        NSLog(@"request:%@",[error userInfo]);
    }];
}

- (void)testQueue
{
    for (NSInteger index = 0; index < 2; index ++) {
        GRTestForm *form = [[GRTestForm alloc] init];
        form.q = @"GreedNetwork";
        form.successBlock = ^(GRNetworkResponse *responseObject) {
            NSLog(@"queue_%@:%@",@(index),responseObject.responseDictionary);
        };
        form.failureBlock = ^(NSError *error) {
            NSLog(@"queue_%@:%@",@(index),[error userInfo]);
        };
        
        [[GRNetworkQueue getInstance] addForm:form];
    }
}

@end

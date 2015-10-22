//
//  GRNetworkQueue.m
//  Pods
//
//  Created by Bell on 15/10/22.
//  Copyright © 2015年 GreedLab. All rights reserved.
//

#import "GRNetworkQueue.h"
#import "NSObject+GreedNetwork.h"

@implementation GRNetworkQueue

- (instancetype)init
{
    self = [super init];
    if (self) {
        _forms = [[NSMutableArray alloc] init];
        _requesting = NO;
    }
    return self;
}

+ (GRNetworkQueue*)getInstance
{
    static GRNetworkQueue *__networkQueue = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        __networkQueue = [[GRNetworkQueue alloc] init];
    });
    return __networkQueue;
}

- (void)addForm:(GRNetworkForm*)form
{
    if ([_forms indexOfObject:form] != NSNotFound) {
        return;
    }
    [_forms addObject:form];
    if (!_requesting) {
        [self requestNext];
    }
}

- (void)requestForm:(GRNetworkForm*)form
{
    [self requestWithNetworkForm:form];
}

- (void)cancelAll
{
    [_forms removeAllObjects];
}

#pragma mark - private

- (void)requestNext
{
    if (_forms.count) {
        _requesting = YES;
        [self realRequestForm:[_forms firstObject]];
    } else {
        _requesting = NO;
    }
}

- (void)realRequestForm:(GRNetworkForm*)form
{
    __weak __typeof(&*self)weakSelf = self;
    [self requestWithNetworkForm:form success:^(GRNetworkResponse *responseObject) {
        [weakSelf.forms removeObject:form];
        [weakSelf requestNext];
    } failure:^(NSError *error) {
        [weakSelf.forms removeObject:form];
        [weakSelf requestNext];
    }];
}

@end

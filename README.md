# GreedNetwork [![Join the chat at https://gitter.im/greedlab/GreedNetwork](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/greedlab/GreedNetwork?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge) [![Build Status](https://travis-ci.org/greedlab/GreedNetwork.svg?branch=master)](https://travis-ci.org/greedlab/GreedNetwork)

network request for iOS, based on [AFNetworking](https://github.com/AFNetworking/AFNetworking) and  [GreedJSON](https://github.com/greedlab/GreedJSON)
# Installation
pod 'GreedNetwork'
# Usage
## [NSObject+GreedNetwork](https://github.com/greedlab/GreedNetwork/blob/master/GreedNetwork/NSObject%2BGreedNetwork.h)
``` objc
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
```
## [GRNetworkQueue](https://github.com/greedlab/GreedNetwork/blob/master/GreedNetwork/GRNetworkQueue.h)
``` objc
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
```
# Release Notes
* 0.0.1 first version
* 0.0.2 replace MJExtension to GreedJSON

# LICENSE
MIT

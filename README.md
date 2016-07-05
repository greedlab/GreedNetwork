# GreedNetwork [![Join the chat at https://gitter.im/greedlab/GreedNetwork](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/greedlab/GreedNetwork?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge) [![Build Status](https://travis-ci.org/greedlab/GreedNetwork.svg?branch=master)](https://travis-ci.org/greedlab/GreedNetwork)

 a network request util for iOS 7+, based on [AFNetworking](https://github.com/AFNetworking/AFNetworking) and  [GreedJSON](https://github.com/greedlab/GreedJSON)

## Installation

pod 'GreedNetwork'

## Usage

###
[GRNetworkForm](https://github.com/greedlab/GreedNetwork/blob/master/GreedNetwork/GRNetworkForm.h)

decalre your network parameters as properties in GRNetworkForm instance's interface file;

``` objc
@interface GRTestFrom : GRNetworkForm

@property (nonatomic, strong) NSString *password;

@property (nonatomic, strong) NSString *username;

@property (nonatomic, strong) NSString *q;

@end

```

you could customize default parameters value in the implementation file;

```objc
@implementation GRTestFrom

- (instancetype)init {
    self = [super init];
    if (self) {
        self.username = @"foo";
        self.password = @"foo1";
        self.q = @"test";
    }
    return self;
}

@end
```

### [NSObject+GreedNetwork](https://github.com/greedlab/GreedNetwork/blob/master/GreedNetwork/NSObject%2BGreedNetwork.h)

initialize your GreedNetwork instance and start your network connection with
``` objc
    - (void)gr_requestWithNetworkForm:(GRNetworkForm *)form
                          success:(void (^)(GRNetworkResponse *responseObject))success
                          failure:(void (^)(GRNetworkResponse *responseObject))failure
```
that is it!

``` objc
- (void)testRequest
{
    GRTestForm *form = [[GRTestForm alloc] init];
    form.q = @"GreedNetwork";
    form.password = self.passTextField.text;
    form.username = self.userTextField.text;
    NSLog(@"form:%@",[form gr_dictionary]);
    [self gr_requestWithNetworkForm:form success:^(GRNetworkResponse *responseObject) {
        NSLog(@"request:%@",responseObject.responseDictionary);
    } failure:^(GRNetworkResponse *responseObject) {
        NSLog(@"request:%@",[responseObject.error userInfo]);
    }];
}
```

### [GRNetworkQueue](https://github.com/greedlab/GreedNetwork/blob/master/GreedNetwork/GRNetworkQueue.h)

``` objc
- (void)testQueue
{
    for (NSInteger index = 0; index < 2; index ++) {
        GRTestForm *form = [[GRTestForm alloc] init];
        form.q = @"GreedNetwork";
        form.successBlock = ^(GRNetworkResponse *responseObject) {
            NSLog(@"queue_%@:%@",@(index),responseObject.responseDictionary);
        };
        form.failureBlock = ^(GRNetworkResponse *responseObject) {
            NSLog(@"queue_%@:%@",@(index),[responseObject.error userInfo]);
        };

        NSLog(@"form:%@",[form gr_dictionary]);
        [[GRNetworkQueue getInstance] addForm:form];
    }
}
```

## Advantage

Compared with the other network util based on [AFNetworking](https://github.com/AFNetworking/AFNetworking) ,GreedNetwork has these advantages as follows:

1.if you are going to migrate [AFNetworking](https://github.com/AFNetworking/AFNetworking) from 2.x to 3.x,we give you GreedNetwork as candidate.

2.when you have decalred the properties in your GRNetworkForm instance, your network request header,request parameters and HTTP body is generated automatically.

3.GreedNetwork is highly customizable to be adopted to your own project;

## CHANGELOG

[CHANGELOG.md](CHANGELOG.md)

## LICENSE

[MIT](LICENSE.md)

//
//  GRNetworkForm.m
//  Pods
//
//  Created by Bell on 15/10/22.
//  Copyright © 2015年 GreedLab. All rights reserved.
//

#import "GRNetworkForm.h"
#import "GReedJSON.h"

@implementation GRNetworkForm

- (id)init {
    self = [super init];
    if (self) {
        _url = nil;
        _networkAction = GRNetworkActionGet;
        _timeout = 0;
        _isUpload = NO;
        _aliseEmoji = NO;
    }
    return self;
}

/**
 *  if your form is inherit from this class, following methods will be valid
 */

#pragma mark - getter

- (NSDictionary *)requestParameters {
    if (!_requestParameters) {
        _requestParameters = [self gr_dictionary];
    }
    return _requestParameters;
}

#pragma mark - MJExtension

+ (NSArray *)gr_ignoredPropertyNames {
    return @[ @"requestHeader", @"requestParameters", @"url", @"networkAction", @"timeout", @"isUpload", @"aliseEmoji", @"uploadData", @"successBlock", @"failureBlock" ];
}

@end

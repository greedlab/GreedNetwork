//
//  NSObject+GreedNetwork.h
//  Example
//
//  Created by Bell on 15/10/22.
//  Copyright © 2015年 GreedLab. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"
#import "GRNetworkForm.h"
#import "GRNetworkResponse.h"

@interface NSObject (GreedNetwork)

- (void)gr_requestWithNetworkForm:(GRNetworkForm *)form;

- (void)gr_requestWithNetworkForm:(GRNetworkForm *)form
                          success:(void (^)(GRNetworkResponse *responseObject))success
                          failure:(void (^)(GRNetworkResponse *responseObject))failure;

- (void)gr_requestWithNetworkForm:(GRNetworkForm *)form
               responseSerializer:(AFHTTPResponseSerializer<AFURLResponseSerialization> *)responseSerializer
                          success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                          failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

#pragma mark - deprecated

- (void)requestWithNetworkForm:(GRNetworkForm *)form __deprecated_msg("Method deprecated. Use `gr_requestWithNetworkForm:form`");

- (void)requestWithNetworkForm:(GRNetworkForm *)form
            responseSerializer:(AFHTTPResponseSerializer<AFURLResponseSerialization> *)responseSerializer
                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure __deprecated_msg("Method deprecated. Use `gr_requestWithNetworkForm:form:responseSerializer:success:failure`");

@end

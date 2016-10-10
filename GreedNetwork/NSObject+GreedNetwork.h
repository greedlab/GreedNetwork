//
//  NSObject+GreedNetwork.h
//  Example
//
//  Created by Bell on 15/10/22.
//  Copyright © 2015年 GreedLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "GRNetworkForm.h"
#import "GRNetworkResponse.h"

@interface NSObject (GreedNetwork)

@property (nonatomic, strong, readonly) AFHTTPSessionManager *gr_sessionManager;

#pragma mark - request

- (void)gr_requestWithNetworkForm:(GRNetworkForm *)form;

- (void)gr_requestWithNetworkForm:(GRNetworkForm *)form
                          success:(void (^)(GRNetworkResponse *responseObject))success
                          failure:(void (^)(GRNetworkResponse *responseObject))failure;

- (void)gr_requestWithNetworkForm:(GRNetworkForm *)form
               responseSerializer:(AFHTTPResponseSerializer<AFURLResponseSerialization> *)responseSerializer
                          success:(void (^)(NSURLResponse *URLResponse, id responseObject))success
                          failure:(void (^)(NSURLResponse *URLResponse,NSError *error))failure;

#pragma mark - deprecated

- (void)requestWithNetworkForm:(GRNetworkForm *)form __deprecated_msg("Method deprecated. Use `gr_requestWithNetworkForm:form`");

- (void)requestWithNetworkForm:(GRNetworkForm *)form
            responseSerializer:(AFHTTPResponseSerializer<AFURLResponseSerialization> *)responseSerializer
                       success:(void (^)(NSURLResponse *URLResponse, id responseObject))success
                       failure:(void (^)(NSURLResponse * URLResponse,NSError * error))failure  __deprecated_msg("Method deprecated. Use `gr_requestWithNetworkForm:form:responseSerializer:success:failure`");

@end

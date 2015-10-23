//
//  NSObject+GreedNetwork.m
//  Example
//
//  Created by Bell on 15/10/22.
//  Copyright © 2015年 GreedLab. All rights reserved.
//

#import "NSObject+GreedNetwork.h"

@implementation NSObject (GreedNetwork)

- (void)requestWithNetworkForm:(GRNetworkForm *)form;
{
    [self requestWithNetworkForm:form success:nil failure:nil];
}

- (void)requestWithNetworkForm:(GRNetworkForm *)form
                       success:(void (^)(GRNetworkResponse *responseObject))success
                       failure:(void (^)(NSError *error))failure
{
    [self requestWithNetworkForm:form responseSerializer:[AFJSONResponseSerializer serializer] success:^(AFHTTPRequestOperation *operation, id responseObject) {
        GRNetworkResponse *response = [[GRNetworkResponse alloc] init];
        [response setResponseObject:responseObject];
        response.responseCode = operation.response.statusCode;
        if (form.successBlock) {
            form.successBlock(response);
        }
        if (success) {
            success(response);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"*** GreedNetwork *** request eror with status code:%ld",(long)operation.response.statusCode);
        if (form.failureBlock) {
            form.failureBlock(error);
        }
        if (failure) {
            failure(error);
        }
    }];
}

- (void)requestWithNetworkForm:(GRNetworkForm *)form
            responseSerializer:(AFHTTPResponseSerializer <AFURLResponseSerialization> *) responseSerializer
                       success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                       failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if (!form) {
        NSLog(@"*** GreedNetwork *** form is nill");
        failure(nil,nil);
        return;
    }
    if (form.url.length == 0) {
        NSLog(@"*** GreedNetwork *** the length of url is 0");
        failure(nil,nil);
        return;
    }
    if (!form.requestParameters) {
        NSLog(@"*** GreedNetwork *** requestParameters is nill");
        failure(nil,nil);
        return;
    }
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    
    NSMutableURLRequest *mutableRequest;
    if (form.isUpload) {
        NSSet *set = [requestSerializer HTTPMethodsEncodingParametersInURI];
        NSMutableSet *mutableSet = [set mutableCopy];
        [mutableSet addObject:@"POST"];
        [requestSerializer setHTTPMethodsEncodingParametersInURI:mutableSet];
        
        mutableRequest = [requestSerializer requestWithMethod:@"POST" URLString:form.url parameters:form.requestParameters error:nil];
        mutableRequest.HTTPBody = form.uploadData;
    } else {
        if (form.networkAction == GRNetworkActionPost) {
            mutableRequest = [requestSerializer requestWithMethod:@"POST" URLString:form.url parameters:form.requestParameters error:nil];
        } else if (form.networkAction == GRNetworkActionPut) {
            mutableRequest = [requestSerializer requestWithMethod:@"PUT" URLString:form.url parameters:form.requestParameters error:nil];
        } else if (form.networkAction == GRNetworkActionDelete) {
            mutableRequest = [requestSerializer requestWithMethod:@"DELETE" URLString:form.url parameters:form.requestParameters error:nil];
        } else {
            mutableRequest = [requestSerializer requestWithMethod:@"GET" URLString:form.url parameters:form.requestParameters error:nil];
        }
    }
    
    if (form.timeout) {
        [mutableRequest setTimeoutInterval: form.timeout];
    }
    if (form.requestHeader) {
        [mutableRequest setAllHTTPHeaderFields:form.requestHeader];
    }
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:mutableRequest];
    operation.responseSerializer = responseSerializer ? responseSerializer : [AFJSONResponseSerializer serializer];
    [operation setCompletionBlockWithSuccess:success failure:failure];
    [operation start];
}

@end

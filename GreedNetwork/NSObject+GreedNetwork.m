//
//  NSObject+GreedNetwork.m
//  Example
//
//  Created by Bell on 15/10/22.
//  Copyright © 2015年 GreedLab. All rights reserved.
//

#import "NSArray+GreedJSON.h"
#import "NSDictionary+GreedJSON.h"
#import "NSObject+GreedNetwork.h"
#import "NSString+GreedEmoji.h"

@implementation NSObject (GreedNetwork)

- (void)gr_requestWithNetworkForm:(GRNetworkForm *)form;
{
    [self gr_requestWithNetworkForm:form success:nil failure:nil];
}

- (void)gr_requestWithNetworkForm:(GRNetworkForm *)form
                          success:(void (^)(GRNetworkResponse *responseObject))success
                          failure:(void (^)(GRNetworkResponse *responseObject))failure {
    [self gr_requestWithNetworkForm:form responseSerializer:[AFHTTPResponseSerializer serializer] success:^(NSURLResponse *_Nonnull URLResponse, id _Nullable responseObject) {
        GRNetworkResponse *response = [[GRNetworkResponse alloc] init];
        if (form.aliseEmoji) { // convert alise to emoji
            NSString *retString; // response JSON string
            if ([responseObject isKindOfClass:[NSData class]]) {
                retString = [[NSString alloc] initWithData:(NSData *) responseObject encoding:NSUTF8StringEncoding];
            } else if ([responseObject isKindOfClass:[NSString class]]) {
                retString = (NSString *) responseObject;
            } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
                retString = [(NSDictionary *) responseObject gr_JSONString];
            } else if ([responseObject isKindOfClass:[NSArray class]]) {
                retString = [(NSArray *) responseObject gr_JSONString];
            }
            retString = [retString emojizedString];
            [response setResponseObject:retString];
        } else {
            [response setResponseObject:responseObject];
        }
        if ([URLResponse isKindOfClass:[NSHTTPURLResponse class]]) {
            NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) URLResponse;
            response.responseCode = httpResponse.statusCode; // response status code
        }
        if (form.successBlock) {
            form.successBlock(response);
        }
        if (success) {
            success(response);
        }
    }
        failure:^(NSURLResponse *_Nonnull URLResponse, NSError *_Nullable error) {
            NSString *responseObject = [[NSString alloc] initWithData:(NSData *) error.userInfo[AFNetworkingOperationFailingURLResponseDataErrorKey] encoding:NSUTF8StringEncoding];
            GRNetworkResponse *response = [[GRNetworkResponse alloc] init];
            if (form.aliseEmoji) {
                NSString *retString;
                if ([responseObject isKindOfClass:[NSData class]]) {
                    retString = [[NSString alloc] initWithData:(NSData *) responseObject encoding:NSUTF8StringEncoding];
                } else if ([responseObject isKindOfClass:[NSString class]]) {
                    retString = (NSString *) responseObject;
                } else if ([responseObject isKindOfClass:[NSDictionary class]]) {
                    retString = [(NSDictionary *) responseObject gr_JSONString];
                } else if ([responseObject isKindOfClass:[NSArray class]]) {
                    retString = [(NSArray *) responseObject gr_JSONString];
                }
                retString = [retString emojizedString];
                [response setResponseObject:retString];
            } else {
                [response setResponseObject:responseObject];
            }
            if ([URLResponse isKindOfClass:[NSHTTPURLResponse class]]) {
                NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) URLResponse;
                response.responseCode = httpResponse.statusCode;
                NSLog(@"*** GreedNetwork *** request eror with status code:%ld", (long) httpResponse.statusCode);
            }
            response.error = error;
            if (form.failureBlock) {
                form.failureBlock(response);
            }
            if (failure) {
                failure(response);
            }
        }];
}

- (void)gr_requestWithNetworkForm:(GRNetworkForm *)form
               responseSerializer:(AFHTTPResponseSerializer<AFURLResponseSerialization> *)responseSerializer
                          success:(void (^)(NSURLResponse *_Nonnull URLResponse, id _Nullable responseObject))success
                          failure:(void (^)(NSURLResponse *_Nonnull URLResponse, NSError *_Nullable error))failure {
    if (!form) {
        NSLog(@"*** GreedNetwork *** form is nill");
        failure(nil, nil);
        return;
    }
    if (form.url.length == 0) {
        NSLog(@"*** GreedNetwork *** the length of url is 0");
        failure(nil, nil);
        return;
    }
    if (!form.requestParameters) {
        NSLog(@"*** GreedNetwork *** requestParameters is nill");
        failure(nil, nil);
        return;
    }
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.requestSerializer = requestSerializer;
    manager.responseSerializer = responseSerializer ? responseSerializer : [AFHTTPResponseSerializer serializer];
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
        [mutableRequest setTimeoutInterval:form.timeout];
    }
    if (form.requestHeader) {
        [mutableRequest setAllHTTPHeaderFields:form.requestHeader];
    }
    [[manager dataTaskWithRequest:mutableRequest completionHandler:^(NSURLResponse *_Nonnull response, id _Nullable responseObject, NSError *_Nullable error) {
        if (error) {
            failure(response, error);
        } else {
            success(response, responseObject);
        }
    }] resume];
}

#pragma mark - deprecated

- (void)requestWithNetworkForm:(GRNetworkForm *)form {
    [self gr_requestWithNetworkForm:form];
}

- (void)requestWithNetworkForm:(GRNetworkForm *)form
            responseSerializer:(AFHTTPResponseSerializer<AFURLResponseSerialization> *)responseSerializer
                       success:(void (^)(NSURLResponse *_Nonnull URLResponse, id _Nullable responseObject))success
                       failure:(void (^)(NSURLResponse *_Nonnull URLResponse, NSError *_Nullable error))failure {
    [self gr_requestWithNetworkForm:form responseSerializer:responseSerializer success:success failure:failure];
}

@end

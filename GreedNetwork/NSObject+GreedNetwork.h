//
//  NSObject+GreedNetwork.h
//  Example
//
//  Created by Bell on 15/10/22.
//  Copyright © 2015年 GreedLab. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"
#import "GRNetworkResponse.h"
#import "GRNetworkForm.h"

@interface NSObject (GreedNetwork)

- (void)requestWithNetworkForm:(GRNetworkForm *)form;

- (void)requestWithNetworkForm:(GRNetworkForm *)form
                       success:(void (^)(GRNetworkResponse *responseObject))success
                       failure:(void (^)(NSError *error))failure;

- (void)baseRequestWithNetworkForm:(GRNetworkForm *)form
                           success:(void (^)(NSHTTPURLResponse *response,GRNetworkResponse *grresponse))success
                           failure:(void (^)(NSHTTPURLResponse *response,NSError *error))failure;

- (void)baseRequestWithNetworkForm:(GRNetworkForm *)form
                responseSerializer:(AFHTTPResponseSerializer <AFURLResponseSerialization> *) responseSerializer
                           success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                           failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

@end

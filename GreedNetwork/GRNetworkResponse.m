//
//  GRNetworkResponse.m
//  Pods
//
//  Created by Bell on 15/10/22.
//  Copyright © 2015年 GreedLab. All rights reserved.
//

#import "GRNetworkResponse.h"
#import "MJExtension.h"

@interface GRNetworkResponse(private)

@property(nonatomic,strong)NSDictionary *responseDictionary;
@property(nonatomic,strong)NSArray *responseArray;
@property(nonatomic,strong)NSString *responseString;

@end

@implementation GRNetworkResponse

#pragma mark - setter

- (void)setResponseObject:(id)responseObject
{
    _responseObject = responseObject;
    if ([_responseObject isKindOfClass:[NSData class]]) {
        self.responseString = [[NSString alloc] initWithData:(NSData *)_responseObject encoding:NSUTF8StringEncoding];
    } else if ([_responseObject isKindOfClass:[NSString class]]) {
        self.responseString = (NSString*)_responseObject;
    } else if ([_responseObject isKindOfClass:[NSDictionary class]]) {
        self.responseDictionary = (NSDictionary*)_responseObject;
    } else if ([_responseObject isKindOfClass:[NSArray class]]) {
        self.responseArray = (NSArray *)_responseObject;
    }
}

- (void)setResponseString:(NSString *)responseString
{
    _responseString = responseString;
    
    id object = [_responseString JSONObject];
    if ([object isKindOfClass:[NSDictionary class]]) {
        _responseDictionary = (NSDictionary*)object;
    } else if ([object isKindOfClass:[NSArray class]]) {
        _responseArray = (NSArray *)object;
    }
}

- (void)setResponseDictionary:(NSDictionary *)responseDictionary
{
    _responseDictionary = responseDictionary;
    
    _responseString = [_responseDictionary JSONString];
}

- (void)setResponseArray:(NSArray *)responseArray
{
    _responseArray = responseArray;
    
    _responseString = [_responseArray JSONString];
}

@end

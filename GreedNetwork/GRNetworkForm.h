//
//  GRNetworkForm.h
//  Pods
//
//  Created by Bell on 15/10/22.
//  Copyright © 2015年 GreedLab. All rights reserved.
//

#import "GRNetworkResponse.h"
#import <Foundation/Foundation.h>

/**
 * request method
 */
typedef NS_ENUM(NSUInteger, GRNetworkAction) {
    GRNetworkActionGet = 0,
    GRNetworkActionPost = 1,
    GRNetworkActionPut = 2,
    GRNetworkActionDelete = 3,
};

/**
 *  the response block for request
 */
typedef void (^GRNetworkBlock)(GRNetworkResponse *responseObject);

/**
 *  request form
 */
@interface GRNetworkForm : NSObject {
    NSDictionary *_requestHeader;
    NSDictionary *_requestParameters;
}

/**
 *  request header
 */
@property (nonatomic, strong) NSDictionary *requestHeader;

/**
 *  request parameters
 */
@property (nonatomic, strong) NSDictionary *requestParameters;

/**
 *  request url
 */
@property (nonatomic, strong) NSString *url;

/**
 *  request method
 */
@property (nonatomic, assign) GRNetworkAction networkAction;

/**
 *  timeout
 *  if = 0 use default from AFNetwork
 */
@property (nonatomic, assign) NSInteger timeout;

/**
 *  whether convert alised string to emoji in response
 *  default YES
 */
@property (nonatomic, assign) BOOL aliseEmoji;

/**
 *  whether upload file
 */
@property (nonatomic, assign) BOOL isUpload;

/**
 *  the data of file
 */
@property (nonatomic, strong) NSData *uploadData;

/**
 *  success call back
 */
@property (nonatomic, copy) GRNetworkBlock successBlock;

/**
 *  failure call back
 */
@property (nonatomic, copy) GRNetworkBlock failureBlock;

@end

//
//  GRNetworkForm.h
//  Pods
//
//  Created by Bell on 15/10/22.
//  Copyright © 2015年 GreedLab. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * request method
 */
typedef NS_ENUM(NSUInteger,GRNetworkAction)
{
    GRNetworkActionGet = 0,
    GRNetworkActionPost = 1,
    GRNetworkActionPut = 2,
    GRNetworkActionDelete = 3,
};

/**
 *  the response block for request success
 */
typedef void(^GRNetworkSuccess)(GRNetworkResponse *responseObject);

/**
 *  the response block for request failure
 */
typedef void(^GRNetworkFailure)(NSError *error);

/**
 *  request form
 */
@interface GRNetworkForm : NSObject

/**
 * request header
 */
@property(nonatomic,strong)NSDictionary *requestHeader;

/**
 * request parameters
 */
@property(nonatomic,strong)NSDictionary *requestParameters;

/**
 * request url
 */
@property(nonatomic,strong)NSString *url;

/**
 * request method
 */
@property(nonatomic,assign)GRNetworkAction networkAction;

/**
 * timeout
 * if = 0 use default from AFNetwork
 */
@property(nonatomic,assign)NSInteger timeout;

/**
 * whether upload file
 */
@property(nonatomic,assign)BOOL isUpload;

/**
 * the data of file
 */
@property(nonatomic,strong)NSData *uploadData;

@property(nonatomic,copy)GRNetworkSuccess successBlock;
@property(nonatomic,copy)GRNetworkFailure failureBlock;

@end

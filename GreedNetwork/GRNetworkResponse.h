//
//  GRNetworkResponse.h
//  Pods
//
//  Created by Bell on 15/10/22.
//  Copyright © 2015年 GreedLab. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  network response
 */
@interface GRNetworkResponse : NSObject

/**
 *  set response object. eg: NSString,NSData,NSDictionary or NSArray
 */
@property (nonatomic, strong) id responseObject;

/**
 *  response status code
 */
@property (nonatomic, assign) NSInteger responseCode;

@property (nonatomic, strong) NSError *error;

/**
 *  response NSDictionary
 */
@property (nonatomic, strong, readonly) NSDictionary *responseDictionary;

/**
 *  response NSArray
 */
@property (nonatomic, strong, readonly) NSArray *responseArray;

/**
 *  response NSString
 */
@property (nonatomic, strong, readonly) NSString *responseString;


@end

//
//  GRNetworkQueue.h
//  Pods
//
//  Created by Bell on 15/10/22.
//  Copyright © 2015年 GreedLab. All rights reserved.
//

#import "GRNetworkForm.h"
#import <Foundation/Foundation.h>

/**
 *  request the form one by one
 */
@interface GRNetworkQueue : NSObject {
    /**
     *  whether requesting network
     */
    BOOL _requesting;
}

//@property (nonatomic, assign) BOOL
@property (nonatomic, strong, readonly) NSMutableArray<__kindof GRNetworkForm *> *forms;

+ (GRNetworkQueue *)getInstance;

/**
 *  add form to queue,and it will requeue one by one
 *
 */
- (void)addForm:(GRNetworkForm *)form;

- (void)addForm:(GRNetworkForm *)form
        success:(GRNetworkBlock)success
        failure:(GRNetworkBlock)failure;

/**
 *  request directly,no add to queue
 *
 */
- (void)requestForm:(GRNetworkForm *)form;

- (void)requestForm:(GRNetworkForm *)form
            success:(GRNetworkBlock)success
            failure:(GRNetworkBlock)failure;

/**
 *  cancel all the requests which have not begin
 */
- (void)cancelAll;

@end

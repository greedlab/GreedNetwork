//
//  GRNetworkQueue.h
//  Pods
//
//  Created by Bell on 15/10/22.
//  Copyright © 2015年 GreedLab. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GRNetworkForm.h"

/**
 *  request the form one by one
 */
@interface GRNetworkQueue : NSObject
{
    /**
     *  whether requesting network
     */
    BOOL _requesting;
}

@property(nonatomic,strong,readonly)NSMutableArray<__kindof GRNetworkForm*> *forms;

+ (GRNetworkQueue*)getInstance;

/**
 *  add form to queue,and it will requeue one by one
 *
 */
- (void)addForm:(GRNetworkForm*)form;

/**
 *  request directly,no add to queue
 *
 */
- (void)requestForm:(GRNetworkForm*)form;

/**
 *  cancel all the requests which have not begin
 */
- (void)cancelAll;

@end

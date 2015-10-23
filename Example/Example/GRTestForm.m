//
//  GRTestForm.m
//  Example
//
//  Created by Bell on 15/10/23.
//  Copyright © 2015年 GreedLab. All rights reserved.
//

#import "GRTestForm.h"

@implementation GRTestForm

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.url = @"https://api.github.com/search/repositories";
    }
    return self;
}

@end

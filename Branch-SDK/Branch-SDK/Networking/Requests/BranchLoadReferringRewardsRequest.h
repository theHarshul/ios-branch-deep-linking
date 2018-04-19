//
//  BranchLoadReferringRewardsRequest.h
//  BranchSDK
//
//  Created by Harshul Mulchandani on 4/19/18.
//  Copyright © 2018 Branch, Inc. All rights reserved.
//
#import "BNCServerRequest.h"
#import "Branch.h"

@interface BranchLoadReferringRewardsRequest: BNCServerRequest

- (id)initWithIdentityId:(NSString *)identityId callback:(callbackWithParams)callback;

@end

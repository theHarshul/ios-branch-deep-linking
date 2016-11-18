//
//  BranchLoadRewardsRequest.m
//  Branch-TestBed
//
//  Created by Graham Mueller on 5/22/15.
//  Copyright (c) 2015 Branch Metrics. All rights reserved.
//

#import "BranchLoadReferringRewardsRequest.h"
#import "BNCPreferenceHelper.h"
#import "BranchConstants.h"

@interface BranchLoadReferringRewardsRequest ()

@property (copy, nonatomic) NSString *identityId;
@property (strong, nonatomic) callbackWithParams callback;

@end

@implementation BranchLoadReferringRewardsRequest

- (id)initWithIdentityId:(NSString *)identityId callback:(callbackWithParams)callback {
    if (self = [super init]) {
        _identityId = identityId;
        _callback = callback;
    }
    
    return self;
}

- (void)makeRequest:(BNCServerInterface *)serverInterface key:(NSString *)key callback:(BNCServerCallback)callback {
    BNCPreferenceHelper *preferenceHelper = [BNCPreferenceHelper preferenceHelper];
    NSString *endpoint = [BRANCH_REQUEST_ENDPOINT_LOAD_REWARDS stringByAppendingPathComponent:self.identityId];
    [serverInterface getRequest:nil url:[preferenceHelper getAPIURL:endpoint] key:key callback:callback];
}

- (void)processResponse:(BNCServerResponse *)response error:(NSError *)error {
    if (error) {
        if (self.callback) {
            self.callback(@{}, error);
        }
        return;
    }

    NSMutableDictionary *callbackResponse = [[NSMutableDictionary alloc] init];
    NSArray *responseKeys = [response.data allKeys];
    
    if ([responseKeys count] && ([response.data isKindOfClass:[NSDictionary class]] || [response.data isKindOfClass:[NSMutableDictionary class]])) {
        
        for (NSString *key in response.data) {
            if (![key isKindOfClass:[NSString class]]) { continue; }
            
            if ([key isEqualToString:@"default"]) {
                callbackResponse[key] = @([response.data[key] integerValue]);
            }
        }
    }
    
    if (self.callback) {
        self.callback(callbackResponse, nil);
    }
}

@end

//
//  ANFollowUserRequest.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANFollowUserRequest.h"

@implementation ANFollowUserRequest

- (NSURL *)URL {
    return [NSURL URLWithString:[self pathWithFormat:@"users/%@/follow" userID:self.userID] relativeToURL:[self.session URLForStreamAPIVersion:ANStreamAPIVersion0]];
}

- (NSDictionary *)parameters {
    return nil;
}

- (ANRequestMethod)method {
    return ANRequestMethodPost;
}

- (void)sendRequestWithCompletion:(ANUserRequestCompletion)completion {
    [self sendRequestWithRepresentationCompletion:^(id rep, NSError *error) {
        [self.session completeUserRequest:completion withRepresentation:rep error:error];
    }];
}

@end

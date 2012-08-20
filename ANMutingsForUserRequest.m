//
//  ANMutingsForUserRequest.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANMutingsForUserRequest.h"

@implementation ANMutingsForUserRequest

- (NSURL *)URL {
    return [NSURL URLWithString:@"users/me/muted" relativeToURL:[self.session URLForStreamAPIVersion:ANStreamAPIVersion0]];
}

- (NSDictionary *)parameters {
    return nil;
}

- (ANRequestMethod)method {
    return ANRequestMethodGet;
}

- (void)sendRequestWithCompletion:(ANUserListRequestCompletion)completion {
    [self sendRequestWithRepresentationCompletion:^(id rep, NSError *error) {
        [self.session completeUserListRequest:completion withRepresentation:rep error:error];
    }];
}

@end

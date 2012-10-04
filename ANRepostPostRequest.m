//
//  ANRepostPostRequest.m
//  Aleph
//
//  Created by Brent Royal-Gordon on 9/28/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANRepostPostRequest.h"

@implementation ANRepostPostRequest

- (NSURL *)URL {
    return [NSURL URLWithString:[NSString stringWithFormat:@"posts/%lld/repost", self.postID] relativeToURL:[self.session URLForStreamAPIVersion:ANStreamAPIVersion0]];
}

- (NSDictionary *)parameters {
    return nil;
}

- (ANRequestMethod)method {
    return ANRequestMethodPost;
}

- (void)sendRequestWithCompletion:(ANPostRequestCompletion)completion {
    [self sendRequestWithRepresentationCompletion:^(ANResponse * response, id rep, NSError *error) {
        [self.session completePostRequest:^(ANResponse *response, ANPost *post, NSError *error) {
            // We touch the reposted post to make sure its updates are seen.
            [post repostOf];
            completion(response, post, error);
        } withResponse:response representation:rep error:error];
    }];
}

@end

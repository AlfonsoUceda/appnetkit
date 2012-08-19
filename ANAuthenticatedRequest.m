//
//  ANRequest.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/18/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANAuthenticatedRequest.h"
#import "AppNetKit.h"

@implementation ANAuthenticatedRequest

- (NSMutableURLRequest *)URLRequest {
    NSAssert(self.session.accessToken, @"Session's access token has not been set");
    
    NSMutableURLRequest * req = super.URLRequest;
    
    [req setValue:[NSString stringWithFormat:@"Bearer %@", self.session.accessToken] forHTTPHeaderField:@"Authorization"];
    
    return req;
}

@end

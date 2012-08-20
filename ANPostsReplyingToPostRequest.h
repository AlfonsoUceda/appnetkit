//
//  ANRepliesToPostRequest.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANRequestReturningPostList.h"
#import "AppNetKit.h"

@interface ANPostsReplyingToPostRequest : ANRequestReturningPostList

@property (assign) ANResourceID postID;

@end

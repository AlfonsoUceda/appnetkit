//
//  ANPost.h
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/19/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANResource.h"
#import "ANSession.h"

@interface ANPost : ANResource <ANTextualResource>

@property (readonly) ANResourceID ID;

// Editable:
@property (readwrite,copy) NSString * text;
//@property (copy) NSArray * links;
@property (assign) ANResourceID replyToID;
@property (copy) NSDictionary * annotations;

@property (readonly) ANUser * user;
@property (readonly) NSDictionary * userRepresentation;
@property (readonly) NSDate * createdAt;

//@property (readonly) ANSource * source;

- (void)postRepliedToWithCompletion:(ANPostRequestCompletion)completion;
- (void)replyPostsWithCompletion:(ANPostListRequestCompletion)completion;

@property (readonly) ANResourceID threadID;
@property (readonly) NSUInteger numberOfReplies;
- (void)postAtThreadRootWithCompletion:(ANPostRequestCompletion)completion;

@property (readonly,getter=isDeleted) BOOL deleted;

- (void)createWithCompletion:(ANPostRequestCompletion)completion;
- (void)deleteWithCompletion:(ANPostRequestCompletion)completion;

@end

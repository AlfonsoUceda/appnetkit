//
//  ANDraft.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/23/12.
//  Copyright (c) 2012 Architechies. See README.md for licensing information.
//

#import "ANDraft.h"
#import "ANResource.h"

@implementation ANDraft

- (id)init {
    if((self = [super init])) {
        _annotations = [NSMutableArray new];
    }
    return self;
}

- (NSDictionary *)representation {
    NSMutableDictionary * dict = [NSMutableDictionary new];
    
    if(self.machineOnly) {
        [dict setObject:@"1" forKey:@"machine_only"];
    }
    else {
        [dict setObject:self.text forKey:@"text"];
    }
    
    if(self.replyTo) {
        [dict setObject:[NSString stringWithFormat:@"%llu", self.replyTo] forKey:@"reply_to"];
    }
    if(self.annotations.count) {
        [dict setObject:[self.annotations valueForKey:@"representation"] forKey:@"annotations"];
    }
    
    return dict.copy;
}

- (void)setRepresentation:(NSDictionary *)dict {
    self.text = [dict objectForKey:@"text"];
    
    self.replyTo = ANUnspecifiedPostID;
    if([dict objectForKey:@"reply_to"]) {
        self.replyTo = [ANResource.IDFormatter numberFromString:[dict objectForKey:@"reply_to"]].unsignedLongLongValue;
    }
    
    [_annotations removeAllObjects];
    if([dict objectForKey:@"annotations"]) {
        for(NSDictionary * annotationRep in [dict objectForKey:@"annotations"]) {
            ANDraftAnnotation * annotation = [ANDraftAnnotation new];
            annotation.representation = annotationRep;
            [_annotations addObject:	annotation];
        }
    }
}

- (void)createPostViaSession:(ANSession*)session completion:(ANPostRequestCompletion)completion {
    [session createPostFromDraft:self completion:completion];
}

@end

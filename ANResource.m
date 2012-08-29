//
//  ANRepresentation.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/18/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANResource.h"
#import "ISO8601DateFormatter.h"
#import "ANSession.h"
#import "ANSession+ANResource_Private.h"

#import <objc/runtime.h>

NSString * const ANResourceDidUpdateNotification = @"ANResourceDidUpdate";

@implementation ANResource

+ (ISO8601DateFormatter *)dateFormatter {
    static ISO8601DateFormatter * singleton;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        singleton = [ISO8601DateFormatter new];
    });
    
    return singleton;
}

+ (NSNumberFormatter *)IDFormatter {
    static NSNumberFormatter * singleton;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        singleton = [NSNumberFormatter new];
    });
    
    return singleton;
}

- (id)initWithRepresentation:(NSDictionary *)rep session:(ANSession *)session {
    NSParameterAssert(session);
    
    if(!rep) {
        self = nil;
    }
    
    if((self = [super init])) {
        _session = session;
        _representation = rep.copy;
        
        self = [session uniqueResource:self];
    }
    return self;
}

- (void)setRepresentation:(NSDictionary *)representation {
    if([representation isEqualToDictionary:_representation]) {
        return;
    }
    
    [self willChangeValueForKey:@"representation"];
    
    _representation = representation;
    objc_removeAssociatedObjects(self);
    
    [NSNotificationCenter.defaultCenter postNotificationName:ANResourceDidUpdateNotification object:self];
    [self didChangeValueForKey:@"representation"];
}

+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
    if([key isEqualToString:@"representation"]) {
        return NO;
    }
    return [super automaticallyNotifiesObserversForKey:key];
}

- (NSUInteger)hash {
    return (NSUInteger)self.representation.hash ^ (NSUInteger)self.class;
}

- (BOOL)isEqual:(ANResource*)object {
    if(self.class != object.class) {
        return NO;
    }
    
    return [self.representation isEqual:object.representation];
}

@end

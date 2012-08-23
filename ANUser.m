//
//  ANUser.m
//  AppNetKit
//
//  Created by Brent Royal-Gordon on 8/18/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANUser.h"
#import "AppNetKit.h"

NSString * ANUserTypeToString(ANUserType type) {
    static NSDictionary * table;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        table = [NSDictionary dictionaryWithObjectsAndKeys:
                 @"human", [NSNumber numberWithInteger:ANUserTypeHuman],
                 @"bot", [NSNumber numberWithInteger:ANUserTypeBot],
                 @"corporate", [NSNumber numberWithInteger:ANUserTypeCorporate],
                 @"feed", [NSNumber numberWithInteger:ANUserTypeFeed],
                 nil];
    });
    
    return [table objectForKey:[NSNumber numberWithInteger:type]];
}

ANUserType ANUserTypeFromString(NSString * string) {
    static NSDictionary * table;
    static dispatch_once_t once;
    
    dispatch_once(&once, ^{
        table = [NSDictionary dictionaryWithObjectsAndKeys:
                 [NSNumber numberWithInteger:ANUserTypeHuman], @"human",
                 [NSNumber numberWithInteger:ANUserTypeBot], @"bot",
                 [NSNumber numberWithInteger:ANUserTypeCorporate], @"corporate",
                 [NSNumber numberWithInteger:ANUserTypeFeed], @"feed", 
                 nil];
    });
    
    return [[table objectForKey:string] integerValue];

}

@implementation ANUser

@dynamic ID;
@dynamic username;
@dynamic name;
@dynamic userDescription;
@dynamic timezoneString;
@dynamic localeString;
@dynamic typeString;
@dynamic avatarImageRepresentation;
@dynamic coverImageRepresentation;
@dynamic createdAt;
@dynamic countsRepresentation;
@dynamic followsYou;
@dynamic youFollow;
@dynamic youMuted;

- (ANUserType)type {
    return ANUserTypeFromString(self.typeString);
}

//- (void)setType:(ANUserType)type {
//    self.typeString = ANUserTypeToString(type);
//}

- (ANUserDescription *)userDescription {
    return [[ANUserDescription alloc] initWithRepresentation:self.userDescriptionRepresentation session:self.session];
}

- (ANImage *)avatarImage {
    return [[ANImage alloc] initWithRepresentation:self.avatarImageRepresentation session:self.session];
}

- (ANImage *)coverImage {
    return [[ANImage alloc] initWithRepresentation:self.coverImageRepresentation session:self.session];
}

- (ANUserCounts *)counts {
    return [[ANUserCounts alloc] initWithRepresentation:self.countsRepresentation session:self.session];
}

- (NSUInteger)hash {
    return (NSUInteger)self.ID ^ (NSUInteger)self.class;
}

- (BOOL)isEqual:(ANUser*)object {
    if(self.class != object.class) {
        return NO;
    }
    
    return self.ID == object.ID;
}

- (void)reloadWithCompletion:(ANUserRequestCompletion)completion {
    [self.session userWithID:self.ID completion:completion];
}

- (void)followWithCompletion:(ANUserRequestCompletion)completion {
    [self.session followUserWithID:self.ID completion:completion];
}

- (void)unfollowWithCompletion:(ANUserRequestCompletion)completion {
    [self.session unfollowUserWithID:self.ID completion:completion];
}

- (void)followingsWithCompletion:(ANUserListRequestCompletion)completion {
    [self.session followingsForUserWithID:self.ID completion:completion];
}

- (void)followersWithCompletion:(ANUserListRequestCompletion)completion {
    [self.session followersForUserWithID:self.ID completion:completion];
}

- (void)muteWithCompletion:(ANUserRequestCompletion)completion {
    [self.session muteUserWithID:self.ID completion:completion];
}

- (void)unmuteWithCompletion:(ANUserRequestCompletion)completion {
    [self.session unmuteUserWithID:self.ID completion:completion];
}

- (void)postsWithCompletion:(ANPostListRequestCompletion)completion {
    [self postsBetweenID:ANUnspecifiedPostID andID:ANUnspecifiedPostID completion:completion];
}

- (void)postsBetweenID:(ANResourceID)sinceID andID:(ANResourceID)beforeID completion:(ANPostListRequestCompletion)completion {
    [self.session postsForUserWithID:self.ID betweenID:sinceID andID:beforeID completion:completion];
}

- (void)postsMentioningUserWithCompletion:(ANPostListRequestCompletion)completion {
    [self postsMentioningUserBetweenID:ANUnspecifiedPostID andID:ANUnspecifiedPostID completion:completion];
}

- (void)postsMentioningUserBetweenID:(ANResourceID)sinceID andID:(ANResourceID)beforeID completion:(ANPostListRequestCompletion)completion {
    [self.session postsMentioningUserWithID:self.ID betweenID:sinceID andID:beforeID completion:completion];
}

@end

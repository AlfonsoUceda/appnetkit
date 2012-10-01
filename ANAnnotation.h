//
//  ANAnnotation.h
//  Appdate
//
//  Created by Brent Royal-Gordon on 9/1/12.
//  Copyright (c) 2012 Architechies. All rights reserved.
//

#import "ANResource.h"

@class ANDraftAnnotation;
extern NSString * const ANAnnotationTypeGeolocation;

@interface ANAnnotationSet : NSObject

- (id)initWithRepresentation:(id)rep session:(ANSession *)session;

@property (readonly) ANSession * session;
@property (readonly) NSArray * representation;

@property (readonly) NSArray * all;
@property (readonly) NSArray * types;

- (NSArray*)annotationsOfType:(NSString*)type;

@end

@interface ANAnnotation : ANResource

@property (readonly) NSString * type;
@property (readonly) id value;

- (ANDraftAnnotation*)draftAnnotation;

@end

#import "ANDefines.h"

#if APPNETKIT_USE_CORE_LOCATION
#import <CoreLocation/CoreLocation.h>

@interface ANAnnotation (CLLocation)

@property (readonly) CLLocation * geolocationValue;

@end
#endif

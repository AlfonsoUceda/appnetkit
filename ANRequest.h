//
//  ANRequest.h
//  
//
//  Created by Brent Royal-Gordon on 8/19/12.
//
//

#import <Foundation/Foundation.h>

@class ANSession;

typedef enum {
    ANRequestMethodGet,
    ANRequestMethodPost,
    ANRequestMethodDelete
} ANRequestMethod;

@interface ANRequest : NSObject

- (id)initWithSession:(ANSession*)session;

@property (readonly,weak) ANSession * session;

@property (readonly) NSURL * URL;
@property (readonly) NSDictionary * parameters;
@property (readonly) ANRequestMethod method;

@property (readonly) NSMutableURLRequest * URLRequest;

- (void)sendRequestWithRepresentationCompletion:(void (^)(id rep, NSError * error))completion;

@end

//
//  OMCSyncGlobals.h
//  OMCSynchronization
//
//  Copyright (c) 2015, Oracle Corp. All rights reserved. 
//

#import <Foundation/Foundation.h>

@class OMCMobileFile;

// mobileResource param could be OMCMobileObject, or custom mobile object, OMCMobileObjectCollection or OMCMobileFile.
typedef void(^OMCMobileResourceSuccess) (id mobileResource);

// mobileObject param could be OMCMobileObject, or custom mobile object
typedef void(^OMCObjectSuccess) (id mobileObject);

typedef void(^OMCFileSuccess) (OMCMobileFile * mobileFile);

typedef void(^OMCSyncErrorBlock) (NSError* error);

typedef void(^OMCSyncSuccessBlock) (NSData* data, NSHTTPURLResponse* response);

/**
 * An enumeration of the different resource types.
 *
 * Default is file (ResourceKindFile).
 */
typedef NS_ENUM(int, SyncResourceKind) {
    /** Denotes a file resource. */
    ResourceKindFile = 0,

    /** Denotes an object resource. */
    ResourceKindObject = 1,

     /** Denotes a collection resource. */
    ResourceKindCollection = 2,
    
    /** Denotes an unknown type. */
    ResourceKindUnknown = -1,
};

/**
 * An enumeration of the different HTTP request method types.
 *
 * Default is "Get".
 */
typedef NS_ENUM(int, SyncRequestMethod) {
    /** HTTP method GET */
    RequestMethodGet = 0,
    
    /** HTTP method PUT */
    RequestMethodPut = 1,
    
    /** HTTP method POST */
    RequestMethodPost = 2,
    
    /** HTTP method DELETE */
    RequestMethodDelete = 3,
    
    /** HTTP method PATCH */
    RequestMethodPatch = 4,
};

/**
 * This interface defines global constants to be used by the client.
 */
@interface OMCSyncGlobals : NSObject

@end

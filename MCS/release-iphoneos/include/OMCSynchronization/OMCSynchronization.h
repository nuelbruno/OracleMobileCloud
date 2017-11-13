//
//  OMCSynchronization.h
//  OMCSynchronization
//
//  Copyright (c) 2015, Oracle Corp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OMCCore/OMCServiceProxy.h"
#import "OMCSyncPolicy.h"
#import "OMCSyncGlobals.h"
#import "OMCMobileEndpoint.h"

@class OMCSyncSettings;

/**
 The main class for the Synchronization Service implementation. Contains methods to make requests and manipulate the cache.
 */
@interface OMCSynchronization : OMCServiceProxy


/**
 Initializes an `OMCSynchronization` object with the default settings.
 */
- (void) initialize;

/**
 Initializes an `OMCSynchronization` object with the default settings and creates database entities for your business model or mobile objects using provided custom classes.
 @param customEntities (optional) Array of custom classes that derived from OMCMobileObject class, use class properties for entity attributes to query on.
    Example array: [NSArray arrayWithObjects:[MyClass1 class], [MyClass2 class], ... , nil]
 */
- (void) initializeWithMobileObjectEntities:(NSArray *) customEntities;


/**
 Returns an object that provides access to an endpoint in a custom code API.
 @param mobileClass (optional) The custom mobile object (entity) class, that the custom code API exposes.
 ( custom mobile object class must have been registered through initializeWithMobileObjectEntities: method. Or pass nil. )
 @param apiName The name of the custom code API.
 @param endpointPath The endpoint in the custom code API.
 @return An MobileEndpoint object for accessing custom code.
 */
- (OMCMobileEndpoint *) openEndpoint:(Class) mobileClass
                             apiName:(NSString *) apiName
                        endpointPath:(NSString *) endpointPath;

/**
 * Request for any method, could go to server or cache based on policy settings.
 @param uri The URI to send the request to.
 @param method RequestMethod value.
 @param policy (optional) SyncPolicy object which has all policy settings.
 @param headers (optional) NSDictionary for extra headers to support request.
 @param data (optional) NSData for http body data, can set `nil` for GET method.
 @param success (optional) The block will be invoked on success of the request.
 @param error (optional) The block will be invoked on error of the request.
 */
- (void) requestWithUri:(NSString *) uri
                 method:(SyncRequestMethod) method
             syncPolicy:(OMCSyncPolicy *) policy
                headers:(NSDictionary *) headers
                   data:(NSData *) data
              onSuccess:(OMCSyncSuccessBlock) success
                onError:(OMCSyncErrorBlock) error;


/**
 * Synchronize all pinned resources.
 @param background boolean to specify for background mode sync.
 */
-(void) synchronizePinnedResources:(BOOL) background;


/**
 * Evict ( delete ) the resource from the local cache.
 @param uri The URI of the resource.
 @param error (optional) The block will be invoked on error of the request.
 */
- (void) evictResource:(NSString *) uri
               onError:(OMCSyncErrorBlock) error;

/**
 * Returns the number of cache hits.
 * @return The number of cache hits.
 */
- (int) cacheHitCount;

/**
 * Returns the number of cache misses.
 * @return The number of cache misses.
 */
- (int) cacheMissCount;

/**
* Purge entire store with all files.
*/
- (void) purge;

/**
 * Sets device to offline mode. Useful for testing
 * If the device is actually offline, than this setting will be ignored.
 @param offlineMode boolean to set offline mode
 */
- (void) setOfflineMode:(BOOL) offlineMode;

@end


extern NSString* const OMCSynchronizationVersion;

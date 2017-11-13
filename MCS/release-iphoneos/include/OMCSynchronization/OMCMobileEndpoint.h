//
//  OMCMobileEndpoint.h
//  OMCSynchronization
//
//  Copyright (c) 2015 Oracle. All rights reserved.
//

#import <Foundation/Foundation.h>

@class OMCMobileObject;
@class OMCMobileFile;
@class OMCFetchObjectCollectionBuilder;
@class OMCFetchFileBuilder;
@class OMCFetchObjectBuilder;
@class OMCSynchronization;

/**
 * Represents an endpoint in a custom code API
 */
@interface OMCMobileEndpoint : NSObject

/**
 *  The name of the custom code API.
 */
@property( nonatomic, readonly ) NSString* apiName;

/**
 * The endpoint in the API.
 */
@property( nonatomic, readonly ) NSString* endpointPath;

/**
 * Creates a new MobileObject. The object is not uploaded to the service until Save is invoked.
 * @return The new OMCMobileObject object or if custom mobile object entity specified, it will return custom mobile object.
 */
-(id) createObject;

/**
 * Creates a new MobileFile. The file is not uploaded to the service until Save is invoked.
 * @return The new MobileFile.
 */
-(OMCMobileFile *) createFile;

/**
 * Returns synchronization object from which current mobile endpoint created
 @return synchronization OMCSynchronization object
 */
-(OMCSynchronization *) getSynchronization;


/**
 * Method to fetch a builder to fetch a collection of objects from the endpoint. If the collection exists in the cache, as policy is set to get from cache, the cached copy is returned otherwise it is downloaded from the service.
 * @return The object of OMCFetchObjectCollectionBuilder
 */
-(OMCFetchObjectCollectionBuilder *) fetchObjectCollectionBuilder;

/**
 * Method to fetch a builder to fetch a object from the endpoint. If the object exists in the cache, and policy is set to get from cache, the cached copy is returned otherwise it is downloaded from the service.
 * @return The object of OMCFetchObjectBuilder
 */
-(OMCFetchObjectBuilder *) fetchObjectBuilder;

/**
 * Method to fetch a builder to fetch a file from the endpoint. If the file exists in the cache, and policy is set to get from cache, the cached copy is returned otherwise it is downloaded from the service.
 * @return The object of OMCFetchFileBuilder
 */
-(OMCFetchFileBuilder *) fetchFileBuilder;

/**
 * Returns absolute url for the current mobile endpoint
 * @return absolute url string
 */
- (NSString *) absoluteUrl;

@end

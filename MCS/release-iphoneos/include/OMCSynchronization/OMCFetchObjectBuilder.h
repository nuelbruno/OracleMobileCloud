//
//  OMCFetchObjectBuilder.h
//  OMCSynchronization
//
//  Copyright (c) 2015 Oracle. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OMCSyncGlobals.h"
#import "OMCSyncStoreState.h"
#import "OMCSyncPolicy.h"

@class OMCMobileObject;
@class OMCMobileEndpoint;

/**
 * Fetch object builder to get OMCMobileObject
 */
@interface OMCFetchObjectBuilder : NSObject

/**
 * Gets currently set SyncPolicy
 @return OMCSyncPolicy object, if not set will return default SyncPolicy.
 */
- (OMCSyncPolicy *) getSyncPolicy;

/**
 * Sets SyncPolicy
 @param syncPolicy will set the passed policy as current SyncPolicy
 */
- (void) setSyncPolicy:(OMCSyncPolicy *) syncPolicy;

/**
 * Sets Fetch policy in SyncPolicy as FetchFromServer, other policy in SyncPolicy will remain same.
 */
- (void) setSyncPolicyFetchFromServer;

/**
 * Sets extra request headers.
 * No need of Headers for authorization, content-type, as they will be added by default.
 * @param headers Extra request headers
 */
- (void) setRequestHeaders:(NSDictionary *) headers;

/**
 * Execute the Get request, based on Policy set, it will goto Server to Local cache or both.
 @param successBlk block that will be called after request successfully finished with the mobile resource.
 @param errorBlk block that will be called after request finished with error.
 */
- (void) executeFetchOnSuccess:(OMCObjectSuccess) successBlk
                       OnError:(OMCSyncErrorBlock) errorBlk;

@end

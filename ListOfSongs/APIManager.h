//
//  APIManager.h
//  ListOfSongs
//
//  Created by Vladimir Goncharov on 15/10/2016.
//  Copyright © 2016 FlatStack. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFNetworking.h"

@class APISearchRequest;

@interface APIManager : NSObject

@property (strong, readonly, nonnull) NSURL *baseURL;
@property (assign) NSUInteger version;

@property (strong, readonly, nonnull) AFHTTPSessionManager *manager;

+ (_Nonnull instancetype)sharedInstance;

@end

#pragma mark - APIRequestProtocol

@protocol APIRequestProtocol <NSObject>

@property (strong, readonly, nonnull) NSString *endpoint;

- (nonnull NSDictionary *)toParams;

@end

#pragma mark - iTunesAPI

@interface APIManager (iTunes)

/**
 *  Initializes and returns a data task.
 *
 *  @param searchRequest            The text string you want to search for.
 *
 *  @return An initialized `NSURLSessionDataTask`.
 *
 */

- (nullable NSURLSessionDataTask *)searchWithRequest:( nonnull APISearchRequest * )searchRequest;

@end


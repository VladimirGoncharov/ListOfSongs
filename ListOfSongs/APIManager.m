//
//  APIManager.m
//  ListOfSongs
//
//  Created by Vladimir Goncharov on 15/10/2016.
//  Copyright © 2016 FlatStack. All rights reserved.
//

#import "APIManager.h"
#import "iTunesAPI.h"
#import "ManagedMappingProvider.h"
#import "CoreDataManager.h"

static APIManager *SINGLETON = nil;

@implementation APIManager

@synthesize baseURL = _baseURL;
@synthesize manager = _manager;

#pragma mark - Init of the Singleton

+ (instancetype)sharedInstance {
    @synchronized(SINGLETON) {
        if (!SINGLETON) {
            SINGLETON = [[self alloc] init];
        }
    }
    return SINGLETON;
}

- (id)init {
    static dispatch_once_t onceTokenAPIManager;
    dispatch_once(&onceTokenAPIManager, ^{
        SINGLETON = [super init];
        if (SINGLETON) {
            SINGLETON.version = 2;
        }
    });
    
    return SINGLETON;
}

#pragma mark - Life Cycle

- (id)copy {
    return self;
}

- (id)mutableCopy {
    return self;
}

#pragma mark - Properties

- (NSURL *)baseURL {
    if (_baseURL == nil) {
        NSString *urlString = @"https://itunes.apple.com/";
        _baseURL = [[NSURL alloc] initWithString:urlString];
    }
    return _baseURL;
}

- (AFHTTPSessionManager *)manager {
    if (_manager == nil) {
        AFHTTPSessionManager *manager = [[AFHTTPSessionManager alloc] initWithBaseURL:self.baseURL];
        AFJSONRequestSerializer *requestSerializer =  [AFJSONRequestSerializer serializerWithWritingOptions:NSJSONWritingPrettyPrinted];
        manager.requestSerializer = requestSerializer;
        
        AFJSONResponseSerializer *responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingAllowFragments];
        responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/javascript", nil];
        manager.responseSerializer = responseSerializer;
        
        manager.securityPolicy.validatesDomainName = NO;
        manager.securityPolicy.allowInvalidCertificates = true;
        
        _manager = manager;
    }
    return _manager;
}

@end


#pragma mark - iTunes API

@implementation APIManager (iTunes)

- (NSURLSessionDataTask *)searchWithRequest:(APISearchRequest *)searchRequest {
    return
    [self.manager GET:searchRequest.endpoint
           parameters:searchRequest.toParams
             progress:searchRequest.progress
              success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                  APISearchResponseObject *response =
                  [ManagedMappingProvider mapWithObject:responseObject
                                                 mapper:[SearchMappingObject new]
                                              inContext:[CoreDataManager sharedInstance].managedObjectContext];
                  [[CoreDataManager sharedInstance] saveMainContext];
                  [response setValue:searchRequest forKey:@"request"];
                  [searchRequest setValue:response forKey:@"response"];
                  searchRequest.success(task, response);
              } failure:searchRequest.failure];
}

@end

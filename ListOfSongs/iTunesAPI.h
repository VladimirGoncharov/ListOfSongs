//
//  APIRequest.h
//  ListOfSongs
//
//  Created by Vladimir Goncharov on 15/10/2016.
//  Copyright © 2016 FlatStack. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Song, APISearchResponseObject;

#pragma mark - APISearchRequest

typedef NS_OPTIONS(NSUInteger, APISearchRequestMediaType) {
    APISearchRequestMediaTypeMovie = (1UL << 0),
    APISearchRequestMediaTypePodcast = (1UL << 1),
    APISearchRequestMediaTypeMusic = (1UL << 2),
    APISearchRequestMediaTypeMusicVideo = (1UL << 3),
    APISearchRequestMediaTypeAudiobook = (1UL << 4),
    APISearchRequestMediaTypeShortFilm = (1UL << 5),
    APISearchRequestMediaTypeTVShow = (1UL << 6),
    APISearchRequestMediaTypeSoftware = (1UL << 7),
    APISearchRequestMediaTypeEbook = (1UL << 8),
    APISearchRequestMediaTypeAll = (1UL << 9)
};

extern NSString * _Nonnull const APISearchRequestMediaType_toString[];


@interface APISearchRequest : NSObject <APIRequestProtocol>

@property (strong, readonly, nonnull) NSString *endpoint;

@property (nonatomic, strong, readonly, nonnull) NSString *searchString;
@property (nonatomic, strong, readonly, nonnull) NSString *country;
@property (nonatomic, assign, readonly) APISearchRequestMediaType mediaType;
@property (nonatomic, assign, readonly) NSUInteger limit;
@property (nonatomic, strong, readonly, nonnull) NSString *lang;
@property (nonatomic, assign, readonly) NSUInteger version;

@property (nonatomic, strong, readonly, nullable) APISearchResponseObject *response;

@property (nonatomic, copy, nullable) void (^success)(NSURLSessionDataTask * _Nonnull, APISearchResponseObject * _Nullable);
@property (nonatomic, copy, nullable) void (^failure)(NSURLSessionDataTask * _Nullable, NSError * _Nonnull);
@property (nonatomic, copy, nullable) void (^progress)(NSProgress * _Nonnull);

- (nonnull instancetype)init __attribute__((unavailable("init not available")));

- (nonnull instancetype)initWithSearchString:( nonnull NSString * )searchString;

/**
 *  Initializes and returns a `APISearchRequest` instance.
 *
 *  @param searchString             The URL-encoded text string you want to search for. For example: jack+johnson.
 *  @param country                  The two-letter country code for the store you want to search. The search uses the default store front for the specified country. See http://en.wikipedia.org/wiki/ ISO_3166-1_alpha-2 for a list of ISO Country Codes. By default use [[NSLocale currentLocale] countryCode].
 *  @param mediaType                The media type you want to search for via APIManagerMediaType. By default use APIManagerMediaTypeAll.
 *  @param limit                    The number of search results you want the iTunes Store to return. For example: 25.The default is 50.
 *  @param lang                     The language, English or Japanese, you want to use when returning search results. Specify the language using the five-letter codename. For example: en_us.The default is en_us (English). By default use [[NSLocale currentLocale] languageCode].
 *
 *  @return An initialized `APISearchRequest`.
 *
 */

- (nonnull instancetype)initWithSearchString:( nonnull NSString * )searchString
                                     country:( nullable NSString * )country
                                       media:(APISearchRequestMediaType)mediaType
                                       limit:(NSUInteger)limit
                                        lang:( nullable NSString * )lang
                                     version:(NSUInteger)version NS_DESIGNATED_INITIALIZER;

@end

#pragma mark - APISearchResponseObject
@interface APISearchResponseObject : NSObject

@property (nonatomic, assign, readonly) NSUInteger resultCount;
@property (nonatomic, strong, readonly, nonnull) NSArray<Song *> *songs;

@property (nonatomic, weak, readonly, nullable) APISearchRequest *request;

- (nonnull instancetype)init __attribute__((unavailable("init not available")));

@end

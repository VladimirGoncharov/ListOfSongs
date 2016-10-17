//
//  APIRequest.m
//  ListOfSongs
//
//  Created by Vladimir Goncharov on 15/10/2016.
//  Copyright © 2016 FlatStack. All rights reserved.
//

#import "iTunesAPI.h"
#import "Song.h"

#pragma mark - APISearchRequest

NSString * const APISearchRequestMediaType_toString[] = {
    [APISearchRequestMediaTypeMovie] = @"movie",
    [APISearchRequestMediaTypePodcast] = @"podcast",
    [APISearchRequestMediaTypeMusic] = @"music",
    [APISearchRequestMediaTypeMusicVideo] = @"musicVideo",
    [APISearchRequestMediaTypeAudiobook] = @"audiobook",
    [APISearchRequestMediaTypeShortFilm] = @"shortFilm",
    [APISearchRequestMediaTypeTVShow] = @"tvShow",
    [APISearchRequestMediaTypeSoftware] = @"software",
    [APISearchRequestMediaTypeEbook] = @"ebook",
    [APISearchRequestMediaTypeAll] = @"all"
};

@interface APISearchRequest()

@property (nonatomic, strong) APISearchResponseObject *response;

@end

@implementation APISearchRequest

- (instancetype)initWithSearchString:(NSString *)searchString {
    NSLocale *currentLocale = [NSLocale currentLocale];
    
    return [self initWithSearchString:searchString
                              country:[currentLocale countryCode]
                                media:APISearchRequestMediaTypeAll
                                limit:50
                                 lang:[currentLocale languageCode]
                              version:[[APIManager sharedInstance] version]];
}

- (instancetype)initWithSearchString:(NSString *)searchString
                             country:(NSString *)country
                               media:(APISearchRequestMediaType)mediaType
                               limit:(NSUInteger)limit
                                lang:(NSString *)lang
                             version:(NSUInteger)version {
    NSParameterAssert(searchString);
    
    if (self = [super init]) {
        _searchString = searchString;
        _country = country;
        _mediaType = mediaType;
        _limit = limit;
        _lang = lang;
        _version = version;
    }
    return self;
}

- (BOOL)isEqual:(id)object {
    if ([object isKindOfClass:[self class]]) {
        typeof(self) anotherSameObject = object;
        return self.hash == anotherSameObject.hash;
    }
    return [super isEqual:object];
}

- (NSUInteger)hash {
    return self.searchString.hash ^ self.country.hash ^ @(self.mediaType).hash ^ @(self.limit).hash ^ self.lang.hash ^ @(self.version).hash;
}

#pragma mark - APIRequestProtocol

- (NSString *)endpoint {
    return @"search";
}

- (NSDictionary *)toParams {
    return @{
             @"term" : self.searchString,
             @"country" : self.country,
             @"media" : APISearchRequestMediaType_toString[self.mediaType],
             @"limit" : @(self.limit),
             @"lang" : self.lang,
             @"version" : @(self.version)
             };
}

@end


#pragma mark - APISearchResponseObject

@interface APISearchResponseObject()

@property (nonatomic, weak) APISearchRequest *request;

@end

@implementation APISearchResponseObject

@end




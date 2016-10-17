// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Song.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

#import "Base.h"

NS_ASSUME_NONNULL_BEGIN

@class NSURL;

@class NSURL;

@interface SongID : BaseID {}
@end

@interface _Song : Base
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) SongID *objectID;

@property (nonatomic, strong) NSString* artistName;

@property (nonatomic, strong, nullable) NSURL* artworkUrl100;

@property (nonatomic, strong, nullable) NSURL* artworkUrl60;

@property (nonatomic, strong, nullable) NSString* collectionName;

@property (nonatomic, strong) NSNumber* id;

@property (atomic) int64_t idValue;
- (int64_t)idValue;
- (void)setIdValue:(int64_t)value_;

@property (nonatomic, strong, nullable) NSString* primaryGenreName;

@property (nonatomic, strong, nullable) NSDate* releaseDate;

@property (nonatomic, strong) NSString* trackName;

@end

@interface _Song (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveArtistName;
- (void)setPrimitiveArtistName:(NSString*)value;

- (nullable NSURL*)primitiveArtworkUrl100;
- (void)setPrimitiveArtworkUrl100:(nullable NSURL*)value;

- (nullable NSURL*)primitiveArtworkUrl60;
- (void)setPrimitiveArtworkUrl60:(nullable NSURL*)value;

- (nullable NSString*)primitiveCollectionName;
- (void)setPrimitiveCollectionName:(nullable NSString*)value;

- (NSNumber*)primitiveId;
- (void)setPrimitiveId:(NSNumber*)value;

- (int64_t)primitiveIdValue;
- (void)setPrimitiveIdValue:(int64_t)value_;

- (nullable NSString*)primitivePrimaryGenreName;
- (void)setPrimitivePrimaryGenreName:(nullable NSString*)value;

- (nullable NSDate*)primitiveReleaseDate;
- (void)setPrimitiveReleaseDate:(nullable NSDate*)value;

- (NSString*)primitiveTrackName;
- (void)setPrimitiveTrackName:(NSString*)value;

@end

@interface SongAttributes: NSObject 
+ (NSString *)artistName;
+ (NSString *)artworkUrl100;
+ (NSString *)artworkUrl60;
+ (NSString *)collectionName;
+ (NSString *)id;
+ (NSString *)primaryGenreName;
+ (NSString *)releaseDate;
+ (NSString *)trackName;
@end

NS_ASSUME_NONNULL_END

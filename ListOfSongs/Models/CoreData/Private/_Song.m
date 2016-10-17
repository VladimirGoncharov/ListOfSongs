// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Song.m instead.

#import "_Song.h"

@implementation SongID
@end

@implementation _Song

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Song" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Song";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Song" inManagedObjectContext:moc_];
}

- (SongID*)objectID {
	return (SongID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"idValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"id"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic artistName;

@dynamic artworkUrl100;

@dynamic artworkUrl60;

@dynamic collectionName;

@dynamic id;

- (int64_t)idValue {
	NSNumber *result = [self id];
	return [result longLongValue];
}

- (void)setIdValue:(int64_t)value_ {
	[self setId:@(value_)];
}

- (int64_t)primitiveIdValue {
	NSNumber *result = [self primitiveId];
	return [result longLongValue];
}

- (void)setPrimitiveIdValue:(int64_t)value_ {
	[self setPrimitiveId:@(value_)];
}

@dynamic primaryGenreName;

@dynamic releaseDate;

@dynamic trackName;

@end

@implementation SongAttributes 
+ (NSString *)artistName {
	return @"artistName";
}
+ (NSString *)artworkUrl100 {
	return @"artworkUrl100";
}
+ (NSString *)artworkUrl60 {
	return @"artworkUrl60";
}
+ (NSString *)collectionName {
	return @"collectionName";
}
+ (NSString *)id {
	return @"id";
}
+ (NSString *)primaryGenreName {
	return @"primaryGenreName";
}
+ (NSString *)releaseDate {
	return @"releaseDate";
}
+ (NSString *)trackName {
	return @"trackName";
}
@end


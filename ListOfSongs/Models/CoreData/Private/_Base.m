// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Base.m instead.

#import "_Base.h"

@implementation BaseID
@end

@implementation _Base

+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Base" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Base";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Base" inManagedObjectContext:moc_];
}

- (BaseID*)objectID {
	return (BaseID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@end


//
//  ManagedMappingProvider.h
//  ListOfSongs
//
//  Created by Vladimir Goncharov on 16/10/2016.
//  Copyright © 2016 FlatStack. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SongMappingObject, SearchMappingObject;

#pragma mark - Mapping models


@protocol MappingObject <NSObject>

- (nonnull Class)mapClass;
- (nonnull NSDictionary <NSString *, NSString *>*)attributeMappingKeys;

- (nonnull NSDictionary <NSString *, Class>*)attributeClasses;

@end


#pragma mark - Mapper

@interface ManagedMappingProvider : NSObject

+ (nullable id)mapWithObject:(nonnull id)object mapper:(nonnull id <MappingObject>)mapper inContext:(nullable NSManagedObjectContext *)context;
+ (nullable id)mapWithObjects:(nonnull NSArray *)object mapper:(nonnull id <MappingObject>)mapper inContext:(nullable NSManagedObjectContext *)context;

@end


#pragma mark - 

@interface SearchMappingObject : NSObject <MappingObject>

@end

@interface SongMappingObject : NSObject <MappingObject>

@end

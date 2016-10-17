//
//  ManagedMappingProvider.m
//  ListOfSongs
//
//  Created by Vladimir Goncharov on 16/10/2016.
//  Copyright © 2016 FlatStack. All rights reserved.
//

#import "ManagedMappingProvider.h"
#import "iTunesAPI.h"
#import "CoreDataManager.h"
#import "ModelIncludes.h"

@implementation ManagedMappingProvider

+ (NSDateFormatter *)dateFormatter
{
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"YYYY-MM-DD'T'HH:mm:ss'Z'"];
    });
    return dateFormatter;
}

+ (id)mapWithObject:(id)object mapper:(id <MappingObject>)mapper inContext:(NSManagedObjectContext *)context {
    
    id result = [self existingCoreDataObjectWithObject:object
                                                mapper:mapper
                                             inContext:context];
    if (result == nil) {
        Protocol *coreDataObjectProtocol = @protocol(CoreDataObject);
        Class mapClass = [mapper mapClass];
        if ([mapClass conformsToProtocol:coreDataObjectProtocol]) {
            result = [mapClass insertInManagedObjectContext:context];
        } else {
            result = [[mapClass alloc] init];
        }
    }
    
    NSDictionary *keys = [mapper attributeMappingKeys];
    
    for (NSString* classkey in keys) {
        id apikey = [keys objectForKey:classkey];
        
        Class attributeMapper = [[mapper attributeClasses] objectForKey:classkey];
        if (attributeMapper != nil && [attributeMapper conformsToProtocol:@protocol(MappingObject)]) {
            id attributetObject = [object objectForKey:apikey];
            if ([attributetObject isKindOfClass:[NSArray class]]) {
                [result setValue:[self mapWithObjects:attributetObject
                                               mapper:[attributeMapper new]
                                            inContext:context] forKey:classkey];
            } else {
                [result setValue:[self mapWithObject:attributetObject
                                              mapper:[attributeMapper new]
                                           inContext:context] forKey:classkey];
            }
        } else {
            id apivalue = [object objectForKey:apikey];
            
            Protocol *coreDataObjectProtocol = @protocol(CoreDataObject);
            Class mapClass = [mapper mapClass];
            if ([mapClass conformsToProtocol:coreDataObjectProtocol]) {
                NSEntityDescription *description = [[mapper mapClass] entityInManagedObjectContext:context];
                NSDictionary *attributes = [description attributesByName];
                
                NSAttributeDescription *attributeByKey = attributes[classkey];
                if (attributeByKey.attributeType == NSTransformableAttributeType) {
                    Class classOfAttribute = NSClassFromString([attributeByKey userInfo][@"attributeValueClassName"]);
                    if ([classOfAttribute isSubclassOfClass:[NSURL class]]) {
                        [result setValue:[NSURL URLWithString:apivalue]
                                  forKey:classkey];
                    } else {
                        NSLog(@"Missing \'attributeValueClassName\' for %@", attributeByKey);
                    }
                } else if (attributeByKey.attributeType == NSDateAttributeType) {
                    [result setValue:[[self dateFormatter] dateFromString:apivalue]
                              forKey:classkey];
                } else {
                    [result setValue:apivalue
                              forKey:classkey];
                }
            } else {
                [result setValue:apivalue
                          forKey:classkey];
            }
        }
    }
    return result;
}

+ (id)mapWithObjects:(NSArray *)object mapper:(id <MappingObject>)mapper inContext:(NSManagedObjectContext *)context {
    
    NSMutableArray *dataObjects = [NSMutableArray array];
    
    [object enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop)
     {
         NSDictionary *objectData = (NSDictionary *)obj;
         
         id dataObject = [self mapWithObject:objectData
                                      mapper:mapper
                                   inContext:context];
         
         [dataObjects addObject:dataObject];
     }];
    
    return dataObjects;
}

#pragma mark - Core Data helper

+ (NSPredicate *)primaryPredicateWithObject:(id)object
                                     mapper:(id <MappingObject>)mapper
                                  inContext:(NSManagedObjectContext *)context {

    NSMutableString *predicateFormat = [NSMutableString string];
    NSMutableArray *arguments = [NSMutableArray array];
    
    Protocol *coreDataObjectProtocol = @protocol(CoreDataObject);
    Class mapClass = [mapper mapClass];
    if ([mapClass conformsToProtocol:coreDataObjectProtocol]) {
        NSArray <NSString *>*primaryKeys = [mapClass primaryKeys].allObjects;
        NSDictionary <NSString *, NSString *> *attributeMappingKeys = [mapper attributeMappingKeys];
        
        NSEntityDescription *description = [mapClass entityInManagedObjectContext:context];
        NSDictionary *attributes = [description attributesByName];
        
        for (NSUInteger indexOfKey = 0; indexOfKey < [primaryKeys count]; indexOfKey++) {
            NSString *currentKey = primaryKeys[indexOfKey];
            NSAttributeDescription *currentAttribute = attributes[currentKey];
            if (currentAttribute != nil) {
                NSString *apiKey = attributeMappingKeys[currentKey];
                NSString *value = [object objectForKey:apiKey];
                if (value != nil) {
                    [predicateFormat appendString:@"%K == %@"];
                    if ([primaryKeys count] - 1 != indexOfKey) {
                        [predicateFormat appendString:@" AND "];
                    }
                    [arguments addObject:currentKey];
                    [arguments addObject:value];
                } else {
                    NSLog(@"Value not found by key %@", apiKey);
                    return nil;
                }
            } else {
                NSLog(@"Attribute description of %@ not found by key %@", mapClass, currentKey);
                return nil;
            }
        }

    } else {
        NSLog(@"Class %@ not support %@", mapClass, coreDataObjectProtocol);
        return nil;
    }
    
    return [NSPredicate predicateWithFormat:predicateFormat argumentArray:arguments];
}

+ (NSManagedObject *)existingCoreDataObjectWithObject:(id)object
                                               mapper:(id <MappingObject>)mapper
                                            inContext:(NSManagedObjectContext *)context {
    
    NSPredicate *primaryPredicate =
    [ManagedMappingProvider primaryPredicateWithObject:object
                                                mapper:mapper
                                             inContext:context];
    
    if (primaryPredicate != nil) {
        NSFetchRequest *request = [[NSFetchRequest alloc] init];
        [request setEntity:[[mapper mapClass] entity]];
        [request setPredicate:primaryPredicate];
        [request setFetchLimit:1];
        
        __block NSArray *results = nil;
        [context performBlockAndWait:^{
            
            NSError *error = nil;
            
            results = [context executeFetchRequest:request error:&error];
            
            if (error != nil)
            {
                NSLog(@"Object not found by predicate %@ with error %@", primaryPredicate, error);
            }
            
        }];
        return [results firstObject];
    } else {
        return nil;
    }
}

@end


#pragma mark -

@implementation SearchMappingObject

- (nonnull Class)mapClass {
    return [APISearchResponseObject class];
}

- (nonnull NSDictionary <NSString *, NSString *>*)attributeMappingKeys {
    return @{
             @"resultCount" : @"resultCount",
             @"songs" : @"results"
             };
}
    
- (NSDictionary<NSString *, Class> *)attributeClasses {
    return @{
             @"songs" : [SongMappingObject class]
             };
}

@end


#pragma mark -

@implementation SongMappingObject

- (nonnull Class)mapClass {
    return [Song class];
}

- (nonnull NSDictionary <NSString *, NSString *>*)attributeMappingKeys {
    return @{
             [SongAttributes artistName] : @"artistName",
             [SongAttributes artworkUrl100] : @"artworkUrl100",
             [SongAttributes artworkUrl60] : @"artworkUrl60",
             [SongAttributes collectionName] : @"collectionName",
             [SongAttributes id] : @"trackId",
             [SongAttributes trackName] : @"trackName",
             [SongAttributes primaryGenreName] : @"primaryGenreName",
             [SongAttributes releaseDate] : @"releaseDate"
             };
}

- (nonnull NSDictionary <NSString *, Class> *)attributeClasses {
    return @{};
}

@end

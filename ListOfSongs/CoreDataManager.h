//
//  CoreDataManager.h
//  ListOfSongs
//
//  Created by Vladimir Goncharov on 15/10/2016.
//  Copyright © 2016 FlatStack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

#pragma mark -

@protocol CoreDataObject <NSObject>

+ (nonnull instancetype)insertInManagedObjectContext:(nonnull NSManagedObjectContext *)moc_;
+ (nonnull NSString *)entityName;
+ (nullable NSEntityDescription *)entityInManagedObjectContext:(nonnull NSManagedObjectContext *)moc_;

+ (nonnull NSSet <NSString *>*)primaryKeys;

@end


#pragma mark -

@interface CoreDataManager : NSObject

@property (readonly, strong, nonatomic, nonnull) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic, nonnull) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic, nonnull) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (nonnull instancetype)sharedInstance;

- (void)saveMainContext;

+ (void)cleanupDatabase;
- (void)deleteAllObjectsInCoreData;

@end

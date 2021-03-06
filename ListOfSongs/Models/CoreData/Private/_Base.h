// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Base.h instead.

#if __has_feature(modules)
    @import Foundation;
    @import CoreData;
#else
    #import <Foundation/Foundation.h>
    #import <CoreData/CoreData.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface BaseID : NSManagedObjectID {}
@end

@interface _Base : NSManagedObject
+ (instancetype)insertInManagedObjectContext:(NSManagedObjectContext *)moc_;
+ (NSString*)entityName;
+ (nullable NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) BaseID *objectID;

@end

@interface _Base (CoreDataGeneratedPrimitiveAccessors)

@end

NS_ASSUME_NONNULL_END

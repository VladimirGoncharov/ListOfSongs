#import "Base.h"

@interface Base ()

// Private interface goes here.

@end

@implementation Base

#pragma  mark - CoreDataObject

+ (NSSet<NSString *> *)primaryKeys {
    return [NSSet set];
}

@end

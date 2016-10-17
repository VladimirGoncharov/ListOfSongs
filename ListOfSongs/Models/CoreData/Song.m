#import "Song.h"

@interface Song ()

@end

@implementation Song

+ (NSSet<NSString *> *)primaryKeys {
    NSMutableSet *set = [[super primaryKeys] mutableCopy];
    [set addObjectsFromArray:@[[SongAttributes id]]];
    return [set copy];
}

@end

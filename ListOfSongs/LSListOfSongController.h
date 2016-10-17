//
//  LSListOfSongController.h
//  ListOfSongs
//
//  Created by Vladimir Goncharov on 15/10/2016.
//  Copyright © 2016 FlatStack. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, LSListOfSongControllerCell) {
    LSListOfSongControllerCellTrack = (1UL << 0)
};

extern NSString * _Nonnull const LSListOfSongControllerCell_toString[];


typedef NS_OPTIONS(NSUInteger, LSListOfSongControllerSegue) {
    LSListOfSongControllerSegueDetail = (1UL << 0)
};

extern NSString * _Nonnull const LSListOfSongControllerSegue_toString[];


@interface LSListOfSongController : UIViewController

@property (weak, nonatomic, readonly) MBProgressHUD *progress;

@end


//
//  LSDetailSongController.h
//  ListOfSongs
//
//  Created by Vladimir Goncharov on 15/10/2016.
//  Copyright © 2016 FlatStack. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Song;

@interface LSDetailSongController : UIViewController

@property (strong, nonatomic) Song *song;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *genreLabel;
@property (weak, nonatomic) IBOutlet UILabel *artistLabel;
@property (weak, nonatomic) IBOutlet UILabel *collectionLabel;
@property (weak, nonatomic) IBOutlet UILabel *trackLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end


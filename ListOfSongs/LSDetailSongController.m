//
//  LSDetailSongController.m
//  ListOfSongs
//
//  Created by Vladimir Goncharov on 15/10/2016.
//  Copyright © 2016 FlatStack. All rights reserved.
//

#import "LSDetailSongController.h"
#import "Song.h"
#import "UIImageView+WebCache.h"


#define DEGREES_TO_RADIANS(x) (M_PI * (x) / 180.0)


#pragma mark -

@interface LSDetailSongController ()

@end

@implementation LSDetailSongController

+ (NSDateFormatter *)dateFormatter {
    static NSDateFormatter *dateFormatter;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateStyle = NSDateFormatterLongStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
    });
    return dateFormatter;
}

#pragma mark - life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.genreLabel.transform = CGAffineTransformMakeRotation(DEGREES_TO_RADIANS(315));
    [self configureView];
}

- (void)dealloc {
    [self.imageView sd_cancelCurrentImageLoad];
}

- (void)configureView {
    if (self.song && self.viewLoaded) {
        self.trackLabel.text = self.song.trackName;
        self.artistLabel.text = self.song.artistName;
        self.collectionLabel.text = self.song.collectionName;
        self.genreLabel.text = self.song.primaryGenreName;
        self.dateLabel.text = [[[self class] dateFormatter] stringFromDate:self.song.releaseDate];
        [self.imageView sd_setImageWithURL:self.song.artworkUrl100];
        self.navigationItem.title = [NSString stringWithFormat:@"%@", self.song.id];
    }
}

#pragma mark - Managing the detail item

- (void)setSong:(Song *)song {
    if (_song != song) {
        _song = song;
        
        // Update the view.
        [self configureView];
    }
}

@end

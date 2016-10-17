//
//  LSiTunesSongCell.m
//  ListOfSongs
//
//  Created by Vladimir Goncharov on 15/10/2016.
//  Copyright © 2016 FlatStack. All rights reserved.
//

#import "LSiTunesSongCell.h"

@implementation LSiTunesSongCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.trackImageView.layer.cornerRadius = 6.0f;
}

- (void)prepareForReuse {
    [self.trackImageView sd_cancelCurrentImageLoad];
    
    self.artistLabel.text = nil;
    self.collectionLabel.text = nil;
    self.trackLabel.text = nil;
    
    [super prepareForReuse];
}
@end

//
//  LSListOfSongController.m
//  ListOfSongs
//
//  Created by Vladimir Goncharov on 15/10/2016.
//  Copyright © 2016 FlatStack. All rights reserved.
//

#import "LSListOfSongController.h"
#import "LSDetailSongController.h"

#import "iTunesAPI.h"
#import "Song.h"
#import "LSiTunesSongCell.h"

NSString * const LSListOfSongControllerCell_toString[] = {
    [LSListOfSongControllerCellTrack] = @"Cell"
};

NSString * _Nonnull const LSListOfSongControllerSegue_toString[] = {
    [LSListOfSongControllerSegueDetail] = @"detail"
};


@interface LSListOfSongController ()

@property (strong, nonatomic) APISearchRequest *lastRequest;
@property (weak, nonatomic) NSURLSessionDataTask *currentSearchTask;

@end

@implementation LSListOfSongController

@synthesize progress = _progress;

- (MBProgressHUD *)progress {
    if (_progress == nil) {
        MBProgressHUD *progressView = [[MBProgressHUD alloc] initWithView:self.view];
        [self.view addSubview:progressView];
        _progress = progressView;
        
    }
    return _progress;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UITableView *tableView = self.searchDisplayController.searchResultsTableView;
    UINib *cellNib = [UINib nibWithNibName:@"LSiTunesSongCell" bundle:nil];
    if (cellNib != nil) {
        [tableView registerNib:cellNib
        forCellReuseIdentifier:LSListOfSongControllerCell_toString[LSListOfSongControllerCellTrack]];
    } else {
        assert(@"LSiTunesSongCell nib not found");
    }
    
    tableView.rowHeight = UITableViewAutomaticDimension;
    tableView.estimatedRowHeight = 100.0;
}

#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:LSListOfSongControllerSegue_toString[LSListOfSongControllerSegueDetail]]) {
        NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
        Song *song = self.lastRequest.response.songs[indexPath.row];
        LSDetailSongController *controller = (LSDetailSongController *)[segue destinationViewController];
        controller.song = song;
    }
}

@end


#pragma mark -
@interface LSListOfSongController(UITableViewDataSource) <UITableViewDataSource>

@end

@implementation LSListOfSongController(UITableViewDataSource)

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.lastRequest.response.songs.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LSiTunesSongCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Song *song = self.lastRequest.response.songs[indexPath.row];
    [self configureCell:cell withSong:song];
    return cell;
}

- (void)configureCell:(LSiTunesSongCell *)cell withSong:(Song *)song {
    [cell.trackImageView sd_setImageWithURL:song.artworkUrl60];
    cell.trackLabel.text = song.trackName;
    cell.artistLabel.text = song.artistName;
    cell.collectionLabel.text = song.collectionName;
}

@end

#pragma mark -
@interface LSListOfSongController(Search)

@end

@implementation LSListOfSongController(Search)

- (void)setLastRequest:(APISearchRequest *)lastRequest {
    if (![_lastRequest isEqual:lastRequest]) {
        if (lastRequest != nil) {
            self.currentSearchTask = [[APIManager sharedInstance] searchWithRequest:lastRequest];
        } else {
            self.currentSearchTask = nil;
        }
        _lastRequest = lastRequest;
    }
}

- (void)setCurrentSearchTask:(NSURLSessionDataTask *)currentSearchTask {
    if (_currentSearchTask != nil) {
        [_currentSearchTask cancel];
    }
    _currentSearchTask = currentSearchTask;
}

- (void)performSearch {
    NSString *text = self.searchDisplayController.searchBar.text;
    if (text.length > 0) {
        [self.progress showAnimated:true];
        APISearchRequest *request = [[APISearchRequest alloc] initWithSearchString:text];
        __weak typeof(request) wRequest = request;
        request.progress = ^(NSProgress * progress) {
            if ([wRequest isEqual:self.lastRequest]) {
                self.progress.progressObject = progress;
            }
        };
        request.success = ^(NSURLSessionDataTask * dataTask, APISearchResponseObject *response) {
            if ([wRequest isEqual:self.lastRequest]) {
                [self.searchDisplayController.searchResultsTableView reloadData];
                [self.progress hideAnimated:true];
            }
        };
        request.failure = ^(NSURLSessionDataTask * dataTask, NSError * error) {
            if ([wRequest isEqual:self.lastRequest]) {
                [self.searchDisplayController.searchResultsTableView reloadData];
                [self.progress hideAnimated:true];
            }
        };
        self.lastRequest = request;
    } else {
        [self cancelSearch];
    }
}

- (void)cancelSearch {
    [self.progress hideAnimated:true];
    self.lastRequest = nil;
}

@end


#pragma mark -
@interface LSListOfSongController(UISearchDisplayDelegate) <UISearchDisplayDelegate>

@end

@implementation LSListOfSongController(UISearchDisplayDelegate)

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString {
    [self performSearch];
    return true;
}

@end


#pragma mark -
@interface LSListOfSongController(UITableViewDelegate) <UITableViewDelegate>

@end

@implementation LSListOfSongController(UITableViewDelegate)

- (void)tableView:(UITableView *)tableView
didEndDisplayingCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath {
    LSiTunesSongCell *songCell = (LSiTunesSongCell *)cell;
    [songCell.trackImageView sd_cancelCurrentImageLoad];
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:LSListOfSongControllerSegue_toString[LSListOfSongControllerSegueDetail]
                              sender:nil];
}

@end




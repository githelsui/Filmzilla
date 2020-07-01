//
//  MoviesViewController.m
//  Filmzilla
//
//  Created by Githel Lynn Suico on 6/24/20.
//  Copyright © 2020 Githel Lynn Suico. All rights reserved.
//

#import "MoviesViewController.h"
#import "MovieCell.h"
#import "DetailsViewController.h"
#import "Movie.h"
#import "MovieApiManager.h"
#import "UIImageView+AFNetworking.h"
#import "CellDelegate.h"

@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSMutableArray *movies;
@property (nonatomic, strong) NSMutableArray *watchList;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) id<CellDelegate>delegate;
@property (assign, nonatomic) NSInteger cellIndex;

@end

@implementation MoviesViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadFavList];
    [[NSUserDefaults standardUserDefaults] setPersistentDomain:[NSDictionary dictionary] forName:[[NSBundle mainBundle] bundleIdentifier]]; //resets userdefaults
    [self.activityIndicator startAnimating];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self fetchMovies];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
}

- (void)fetchMovies {
    MovieApiManager *manager = [MovieApiManager new];
    [manager fetchNowPlaying:^(NSArray *movies, NSError *error) {
        if (error != nil) { //error
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Network Failure"
                                                                           message:@"Cannot Load Movies"
                                                                    preferredStyle:(UIAlertControllerStyleAlert)];
            UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * _Nonnull action) {}];
            [alert addAction:okAction];
            [self presentViewController:alert animated:YES completion:nil];
            NSLog(@"%@", [error localizedDescription]);
        } else { //run if request is successful
            self.movies = [movies copy];
            [self.tableView reloadData];
        }
        [self.tableView reloadData];
        [self.refreshControl endRefreshing];
        [self.activityIndicator stopAnimating];
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    cell.index = (long)indexPath.row;
    cell.cellIndex = indexPath.row;
    cell.movie = self.movies[indexPath.row];
    return cell;
}

-(void)favBtnClicked:(UIButton*)sender {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Movie Added to Watchlist"
                                                                   message:nil
                                                            preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {}];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
    [self loadFavList];
    [self didClickOnCellAtIndex:self.cellIndex withData:@"any other cell data/property"];
}

- (void)didClickOnCellAtIndex:(NSInteger)cellIndex withData:(id)data{
    NSDictionary *movie = self.movies[self.cellIndex];
    [self.watchList addObject:movie];
    [[NSUserDefaults standardUserDefaults] setObject:self.watchList forKey:@"Watchlist"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)loadFavList{
    self.watchList = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"Watchlist"]];
    if(self.watchList == nil) self.watchList = [[NSMutableArray alloc] init];
}

#pragma mark - Navigation

//In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"InfoSegue"]) {
        
    }
    else if([segue.identifier isEqualToString:@"DetailSegue"]){
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        Movie *movie = self.movies[indexPath.row];
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.movie = movie;
        detailsViewController.watchList = self.watchList;
    }
}


@end

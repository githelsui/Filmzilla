//
//  WatchlistController.m
//  Filmzilla
//
//  Created by Githel Lynn Suico on 6/24/20.
//  Copyright © 2020 Githel Lynn Suico. All rights reserved.
//

#import "WatchlistController.h"
#import "MovieCell.h"
#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface WatchlistController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *movies;
@property (nonatomic, strong) NSMutableArray *watchList;
@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *emptyListMsg;

@end

@implementation WatchlistController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.activityIndicator startAnimating];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self fetchMovies];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
}

- (void)fetchMovies {
    self.movies = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"Watchlist"]];
    if(self.movies.count != 0) self.emptyListMsg.alpha = 0;
    else self.emptyListMsg.alpha = 1;
    [self.tableView reloadData];
    [self.refreshControl endRefreshing];
    [self.activityIndicator stopAnimating];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    NSDictionary *movie = self.movies[indexPath.row];
    cell.index = (long)indexPath.row;
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    cell.posterView.alpha = 0;
    cell.titleLabel.alpha = 0;
    cell.synopsisLabel.alpha = 0;
    cell.posterView.layer.cornerRadius = 35;
    cell.posterView.layer.masksToBounds = true;
    cell.descView.layer.cornerRadius = 35;
    cell.descView.layer.masksToBounds = true;
    [UIView animateWithDuration:0.5 animations:^{
        [cell.posterView setImageWithURL:posterURL];
        cell.posterView.alpha = 1;
        cell.titleLabel.alpha = 1;
        cell.synopsisLabel.alpha = 1;
        cell.titleLabel.text = movie[@"title"];
        cell.synopsisLabel.text = movie[@"overview"];
    }];
    //    cell.favBtn.tag = indexPath.row;
    //    [cell.favBtn addTarget:self action:@selector(favBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = UIColor.whiteColor;
    cell.selectedBackgroundView = backgroundView;
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
}

#pragma mark - Navigation

//In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"InfoSegue"]) {
        
    }
    else if([segue.identifier isEqualToString:@"DetailSegue"]){
        UITableViewCell *tappedCell = sender;
        NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
        NSDictionary *movie = self.movies[indexPath.row];
        DetailsViewController *detailsViewController = [segue destinationViewController];
        detailsViewController.movie = movie;
        detailsViewController.watchList = self.watchList;
    }
    
}


@end

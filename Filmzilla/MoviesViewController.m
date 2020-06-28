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
#import "UIImageView+AFNetworking.h"
#import "CellDelegate.h"

@interface MoviesViewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *movies;
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
    [self.activityIndicator startAnimating];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self fetchMovies];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchMovies) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
}

- (void)fetchMovies {
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/now_playing?api_key=37b02cea57828b7f45f8799e5aa0d345"];
       
       NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
       
       NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
       
       NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
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
              }
              else { //run if request is successful
                  NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                  self.movies = dataDictionary[@"results"];
                  
                  for (NSDictionary *movie in self.movies){
                      NSLog(@"%@", movie[@"title"]);
                  }
                  [self.tableView reloadData];
              }
           [self.refreshControl endRefreshing];
           [self.activityIndicator stopAnimating];
          }];
       [task resume];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.movies.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MovieCell"];
    NSDictionary *movie = self.movies[indexPath.row];
    cell.index = (long)indexPath.row;
    NSLog(@"%li", (long)indexPath.row);
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
    cell.delegate = self.delegate;
    cell.cellIndex = indexPath.row;
    [UIView animateWithDuration:0.5 animations:^{
        [cell.posterView setImageWithURL:posterURL];
        cell.posterView.alpha = 1;
        cell.titleLabel.alpha = 1;
        cell.synopsisLabel.alpha = 1;
        cell.titleLabel.text = movie[@"title"];
        cell.synopsisLabel.text = movie[@"overview"];
    }];
    cell.favBtn.tag = indexPath.row;
    [cell.favBtn addTarget:self action:@selector(favBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
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
    // Get the new view controller using [segue destinationViewController].
     //Pass the selected object to the new view controller.
    UITableViewCell *tappedCell = sender;
    NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
    NSDictionary *movie = self.movies[indexPath.row];
    DetailsViewController *detailsViewController = [segue destinationViewController];
    detailsViewController.movie = movie;
    detailsViewController.watchList = self.watchList;
}


@end

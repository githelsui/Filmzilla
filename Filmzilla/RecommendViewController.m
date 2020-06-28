//
//  RecommendViewController.m
//  Filmzilla
//
//  Created by Githel Lynn Suico on 6/28/20.
//  Copyright © 2020 Githel Lynn Suico. All rights reserved.
//

#import "RecommendViewController.h"
#import "MovieCell.h"
#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface RecommendViewController () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSArray *movies;
@property (weak, nonatomic) IBOutlet UILabel *headerLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation RecommendViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = self.movie[@"title"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    [self.activityIndicator startAnimating];
    [self fetchMovies];
}

- (void)fetchMovies {
    NSURL *url = [NSURL URLWithString:self.movieURL];
    NSLog(@"Movie ID: %@", self.movie[@"id"]);
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
//                  for (NSDictionary *movie in self.movies){
//                      NSLog(@"%@", movie[@"title"]);
//                  }
                  NSLog(@"%@", self.movies);
                    if(self.movies.count == 0)  self.headerLabel.text = @"No Recommendations";
                  [self.tableView reloadData];
              }
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
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = UIColor.whiteColor;
    cell.selectedBackgroundView = backgroundView;
    return cell;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
   if ([segue.identifier isEqualToString:@"InfoSegue"]) {
          
    }
    else if([segue.identifier isEqualToString:@"DetailSegue"]){
         UITableViewCell *tappedCell = sender;
         NSIndexPath *indexPath = [self.tableView indexPathForCell:tappedCell];
         NSDictionary *movie = self.movies[indexPath.row];
         DetailsViewController *detailsViewController = [segue destinationViewController];
         detailsViewController.movie = movie;
    }
}

@end

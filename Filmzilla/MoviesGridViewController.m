//
//  MoviesGridViewController.m
//  Filmzilla
//
//  Created by Githel Lynn Suico on 6/24/20.
//  Copyright © 2020 Githel Lynn Suico. All rights reserved.
//

#import "MoviesGridViewController.h"
#import "MovieCollectionCell.h"
#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface MoviesGridViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UISearchBarDelegate>

@property (nonatomic, strong) NSArray *movies;
@property (nonatomic, strong) NSArray *filteredMovies;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIView *searchView;

@end

@implementation MoviesGridViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchMovies];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.searchBar.delegate = self;
    self.filteredMovies = self.movies;
    
    UICollectionViewFlowLayout *layout = (UICollectionViewFlowLayout *)self.collectionView.collectionViewLayout;
    
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    
    
    CGFloat postersPerLine = 2;
    CGFloat itemWidth = self.collectionView.frame.size.width / postersPerLine;
    CGFloat itemHeight = 1.5 * itemWidth;
    layout.itemSize = CGSizeMake(itemWidth, itemHeight);
    
    self.searchView.layer.cornerRadius = 25;
}

- (void)fetchMovies {
    NSURL *url = [NSURL URLWithString:@"https://api.themoviedb.org/3/movie/popular?api_key=37b02cea57828b7f45f8799e5aa0d345&language=en-US"];
       
       NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
       
       NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
       
       NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
              if (error != nil) { //error
                  NSLog(@"%@", [error localizedDescription]);
              }
              else { //run if request is successful
                  NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

                  NSLog(@"%@", dataDictionary);
                  self.movies = dataDictionary[@"results"];
                  [self.collectionView reloadData];
              }
          
          }];
       [task resume];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.movies.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MovieCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"MovieCollectionCell" forIndexPath:indexPath];
    
    NSDictionary *movie = self.movies[indexPath.item];
     NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
     NSString *posterURLString = movie[@"poster_path"];
     NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
     NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
     [cell.posterView setImageWithURL:posterURL];
    cell.layer.borderColor = UIColor.whiteColor.CGColor;
    cell.layer.borderWidth = 3;
    return cell;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {

    NSLog(@"%s", "search edited");
//TODO: fix search bar (issue: how to search for the title within the array of movies)
//                    for (NSDictionary *movie in self.movies){
//                        NSLog(@"%@", movie[@"title"]);
//                    }
    
     if (searchText.length != 0) {
           //movies = array of all movies (must get @title within one movie)
           NSPredicate *predicate = [NSPredicate predicateWithBlock:^BOOL(NSString *evaluatedObject, NSDictionary *bindings) {
               return [evaluatedObject containsString:searchText];
           }];
         self.filteredMovies = [self.movies filteredArrayUsingPredicate:predicate];
           
           NSLog(@"%@", self.filteredMovies);
           
       }
       else {
           self.filteredMovies = self.movies;
       }
       [self.collectionView reloadData];
}




#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    UICollectionViewCell *tappedCell = sender;
       NSIndexPath *indexPath = [self.collectionView indexPathForCell:tappedCell];
       
       NSDictionary *movie = self.movies[indexPath.row];
       
       
       DetailsViewController *detailsViewController = [segue destinationViewController];
       detailsViewController.movie = movie;
       NSLog(@"Tapping on a movie!");
}


@end

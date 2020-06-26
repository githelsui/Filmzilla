//
//  DetailsViewController.m
//  Filmzilla
//
//  Created by Githel Lynn Suico on 6/24/20.
//  Copyright © 2020 Githel Lynn Suico. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "ReviewController.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backdropView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UIView *detailsView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UILabel *releaseLabel;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     self.backdropView.alpha = 0;
    self.posterView.alpha = 0;
    [self loadInfo];
    [self loadBackDrop];
    [self loadPoster];
}

- (void) loadBackDrop {
     [self.activityIndicator startAnimating];
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *fullBackDropURLString;
    
    if(self.movie[@"backdrop_path"]){
        NSString *backdropURLString = self.movie[@"backdrop_path"];
        fullBackDropURLString = [baseURLString stringByAppendingString:backdropURLString];
        NSLog(@"%s", "backdrop");
    }
    else{
        NSString *posterURLString = self.movie[@"poster_path"];
        fullBackDropURLString = [baseURLString stringByAppendingString:posterURLString];
        NSLog(@"%s", "poster");
    }
    NSURL *backdropURL = [NSURL URLWithString:fullBackDropURLString];
    [UIView animateWithDuration:0.5 animations:^{
                [self.backdropView setImageWithURL:backdropURL];
                self.backdropView.alpha = 1;
       }];
    [self.activityIndicator stopAnimating];
}

- (void) loadPoster {
    [self.activityIndicator startAnimating];
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = self.movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    [UIView animateWithDuration:0.5 animations:^{
                [self.posterView setImageWithURL:posterURL];
                self.posterView.alpha = 1;
       }];
    [self.activityIndicator stopAnimating];
}

- (void) loadInfo {
    
    self.posterView.layer.cornerRadius = 25;
    self.posterView.layer.masksToBounds = true;
    self.detailsView.layer.cornerRadius = 40;
    self.detailsView.layer.masksToBounds = true;
    double rating = [self.movie[@"vote_average"] doubleValue];
    [UIView animateWithDuration:0.5 animations:^{
        self.titleLabel.text = self.movie[@"title"];
        self.synopsisLabel.text = self.movie[@"overview"];
        self.rateLabel.text = [NSString stringWithFormat:@"%.1f/10", rating];
        self.releaseLabel.text = self.movie[@"release_date"];
    }];
}



#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    NSString *movieId = self.movie[@"id"];
    ReviewController *reviewController = [segue destinationViewController];
    reviewController.movie = self.movie;
    reviewController.movieId = movieId;
}


@end

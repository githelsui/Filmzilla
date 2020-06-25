//
//  DetailsViewController.m
//  Filmzilla
//
//  Created by Githel Lynn Suico on 6/24/20.
//  Copyright © 2020 Githel Lynn Suico. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *backdropView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UIView *detailsView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.activityIndicator startAnimating];
    [self loadBackDrop];
    [self loadPoster];
    [self.activityIndicator stopAnimating];
    self.titleLabel.text = self.movie[@"title"];
    self.synopsisLabel.text = self.movie[@"overview"];
    [self.synopsisLabel sizeToFit];
    self.posterView.layer.cornerRadius = 25;
    self.posterView.layer.masksToBounds = true;
    self.detailsView.layer.cornerRadius = 40;
    self.detailsView.layer.masksToBounds = true;
    
    
}

- (void) loadBackDrop {
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *backdropURLString = self.movie[@"backdrop_path"];
    NSString *fullBackDropURLString = [baseURLString stringByAppendingString:backdropURLString];
    NSURL *backdropURL = [NSURL URLWithString:fullBackDropURLString];
    [self.backdropView setImageWithURL:backdropURL];
}

- (void) loadPoster {
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = self.movie[@"poster_path"];
    NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
    NSURL *posterURL = [NSURL URLWithString:fullPosterURLString];
    [self.posterView setImageWithURL:posterURL];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

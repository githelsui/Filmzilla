//
//  AboutViewController.m
//  Filmzilla
//
//  Created by Githel Lynn Suico on 6/27/20.
//  Copyright © 2020 Githel Lynn Suico. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()
@property (weak, nonatomic) IBOutlet UILabel *aboutLabel;

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.aboutLabel.text = [NSString stringWithFormat:@"%s\n\n%s\n\n%s","Filmzilla lets you find movies currently playing in theaters near you.", "Add a movie you're interested in to your Watchlist by clicking the heart.", "Search for more movies, read up on reviews, and check out the movie recommendations."];
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

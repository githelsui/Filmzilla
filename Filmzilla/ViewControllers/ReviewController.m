//
//  ReviewController.m
//  Filmzilla
//
//  Created by Githel Lynn Suico on 6/25/20.
//  Copyright © 2020 Githel Lynn Suico. All rights reserved.
//

#import "ReviewController.h"
#import "ReviewCell.h"

@interface ReviewController () <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSArray *reviews;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *reviewIntro;
@property (weak, nonatomic) IBOutlet UINavigationItem *navigationItem;

@end

@implementation ReviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchReviews];
    self.navigationItem.title = self.movie.title;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}

- (void)fetchReviews {
    NSURL *url = [NSURL URLWithString:self.movieURL];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        if (error != nil) { //error
            NSLog(@"%@", [error localizedDescription]);
        }
        else { //run if request is successful
            NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            self.reviews = dataDictionary[@"results"];
            if(self.reviews.count == 0)  self.reviewIntro.text = @"No Reviews";
            [self.tableView reloadData];
        }
    }];
    [task resume];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.reviews.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ReviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReviewCell"];
    NSDictionary *review = self.reviews[indexPath.row];
    cell.authorLabel.text = review[@"author"];
    cell.reviewLabel.text = review[@"content"];
    return cell;
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

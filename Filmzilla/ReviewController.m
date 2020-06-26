//
//  ReviewController.m
//  Filmzilla
//
//  Created by Githel Lynn Suico on 6/25/20.
//  Copyright © 2020 Githel Lynn Suico. All rights reserved.
//

#import "ReviewController.h"

@interface ReviewController ()

@property (nonatomic, strong) NSArray *reviews;

@end

@implementation ReviewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchReviews];
}

- (void)fetchReviews {
    NSLog(@"%@", self.movieId);
    NSString *baseURLString = @"https://api.themoviedb.org/3/movie/";
    
    NSString *movieIdString = [NSString stringWithFormat:@"%@", self.movieId];
    NSString *firstHalf = [baseURLString stringByAppendingString:movieIdString];
    
    NSString *secondHalf = @"/reviews?api_key=37b02cea57828b7f45f8799e5aa0d345&language=en-US";
    NSString *combinedString = [firstHalf stringByAppendingString:secondHalf];
    NSURL *url = [NSURL URLWithString:combinedString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    
       NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
    
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
           if (error != nil) { //error
               NSLog(@"%@", [error localizedDescription]);
           }
           else { //run if request is successful
               NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];

               NSLog(@"%@", dataDictionary);
               self.reviews = dataDictionary[@"results"];
               for (NSDictionary *review in self.reviews){
                   NSLog(@"%@", review[@"author"]);
               }
               
           }
        
       }];
    [task resume];

    
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

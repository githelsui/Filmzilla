//
//  TrailerViewController.m
//  Filmzilla
//
//  Created by Githel Lynn Suico on 6/27/20.
//  Copyright © 2020 Githel Lynn Suico. All rights reserved.
//

#import "TrailerViewController.h"
#import <WebKit/WebKit.h>

@interface TrailerViewController ()
@property (weak, nonatomic) IBOutlet WKWebView *webkitView;
@property (nonatomic, strong) NSArray *videos;
@end

@implementation TrailerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self fetchReviews];
    // Do any additional setup after loading the view.
}

- (void)fetchReviews {
     NSLog(@"%s", "segue");
   NSURL *url = [NSURL URLWithString:self.movieURL];
   NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
   NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:nil delegateQueue:[NSOperationQueue mainQueue]];
   NSURLSessionDataTask *task = [session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
             if (error != nil) { //error
                 NSLog(@"%@", [error localizedDescription]);
             }
             else { //run if request is successful
                 NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                 self.videos = dataDictionary[@"results"];
                 if(self.videos.count == 0)  NSLog(@"%s", "No Videos");
                 else NSLog(@"%s", "Videos!");
             }
          
         }];
      [task resume];
}

- (void)showVideo{
    
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

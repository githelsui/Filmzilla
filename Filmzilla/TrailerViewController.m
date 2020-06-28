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
                 UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Network Failure"
                        message:@"Cannot Load Movies"
                 preferredStyle:(UIAlertControllerStyleAlert)];
                 UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                                    style:UIAlertActionStyleDefault
                                                                  handler:^(UIAlertAction * _Nonnull action) {}];
                 [alert addAction:okAction];
                 [self presentViewController:alert animated:YES completion:nil];
             }
             else { //run if request is successful
                 NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
                 self.videos = dataDictionary[@"results"];
                 
                 if(self.videos.count == 0)  [self noMovie];
                 else {
                     NSLog(@"%s", "Videos!");
                     // Convert the url String to a NSURL object.
                     NSURL *videoURL = [NSURL URLWithString:[self showVideo]];

                     // Place the URL in a URL Request.
                     NSURLRequest *request = [NSURLRequest requestWithURL:videoURL
                                                              cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                                          timeoutInterval:10.0];
                     // Load Request into WebView.
                     [self.webkitView loadRequest:request];
                 }
                 
                
             }
          
         }];
      [task resume];
}

- (NSString *)showVideo{
    NSDictionary *firstVid = self.videos[0];
    NSString *website = @"https://www.youtube.com/watch?v=";
    NSString *key = [NSString stringWithFormat:@"%@", firstVid[@"key"]];
    NSString *finalURL = [website stringByAppendingString:key];
    NSLog(@"%@", finalURL);
    return finalURL;
}

- (void) noMovie{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"No Trailer Available"
           message:nil
    preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {}];
    [alert addAction:okAction];
    [self presentViewController:alert animated:YES completion:nil];
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

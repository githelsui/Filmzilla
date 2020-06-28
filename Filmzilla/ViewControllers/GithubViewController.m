//
//  GithubViewController.m
//  Filmzilla
//
//  Created by Githel Lynn Suico on 6/27/20.
//  Copyright © 2020 Githel Lynn Suico. All rights reserved.
//

#import "GithubViewController.h"
#import <WebKit/WebKit.h>

@interface GithubViewController ()
@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation GithubViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.activityIndicator startAnimating];
    NSURL *videoURL = [NSURL URLWithString:@"https://github.com/githelsui/Filmzilla"];
    NSURLRequest *request = [NSURLRequest requestWithURL:videoURL
                                             cachePolicy:NSURLRequestReloadIgnoringLocalCacheData
                                         timeoutInterval:10.0];
   [self.webView loadRequest:request];
     [self.activityIndicator stopAnimating];
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

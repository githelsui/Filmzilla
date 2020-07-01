
//
//  Movie.m
//  Filmzilla
//
//  Created by Githel Lynn Suico on 7/1/20.
//  Copyright © 2020 Githel Lynn Suico. All rights reserved.
//

#import "Movie.h"

@implementation Movie

- (id)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    self.title = dictionary[@"title"];
    NSString *posterURLString = dictionary[@"poster_path"];
    if (posterURLString != nil) {
        NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
        NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
        self.posterUrl = [NSURL URLWithString:fullPosterURLString];
    }
    return self;
}

@end

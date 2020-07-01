
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
    NSString *baseURLString = @"https://image.tmdb.org/t/p/w500";
    NSString *posterURLString = dictionary[@"poster_path"];
    if (posterURLString != nil) {
        NSString *fullPosterURLString = [baseURLString stringByAppendingString:posterURLString];
        self.posterUrl = [NSURL URLWithString:fullPosterURLString];
    }
    NSString *fullBackDropURLString;
    if(dictionary[@"backdrop_path"] != nil){
        NSString *backdropURLString = dictionary[@"backdrop_path"];
        fullBackDropURLString = [baseURLString stringByAppendingString:backdropURLString];
    }
    else{
        NSString *posterURLString = dictionary[@"backdrop_path"];
        fullBackDropURLString = [baseURLString stringByAppendingString:posterURLString];
    }
    self.backdropUrl = [NSURL URLWithString:fullBackDropURLString];
    self.overview = dictionary[@"overview"];
    self.movieId = dictionary[@"id"];
    self.rating = [dictionary[@"vote_average"] doubleValue];
    self.release_date = dictionary[@"release_date"];
    return self;
}

+ (NSArray *)moviesWithDictionaries:(NSArray *)dictionaries {
   NSMutableArray *movies;
   for (NSDictionary *dictionary in dictionaries) {
       Movie *movie = [[self alloc] initWithDictionary:dictionary];
       [movies addObject:movie];
   }
    return movies;
}

@end

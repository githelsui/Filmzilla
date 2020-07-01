//
//  Movie.h
//  Filmzilla
//
//  Created by Githel Lynn Suico on 7/1/20.
//  Copyright © 2020 Githel Lynn Suico. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Movie : NSObject
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSURL *posterUrl;
 - (id)initWithDictionary:(NSDictionary *)dictionary;
@end

NS_ASSUME_NONNULL_END

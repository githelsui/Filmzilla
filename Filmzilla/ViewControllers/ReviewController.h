//
//  ReviewController.h
//  Filmzilla
//
//  Created by Githel Lynn Suico on 6/25/20.
//  Copyright © 2020 Githel Lynn Suico. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

NS_ASSUME_NONNULL_BEGIN

@interface ReviewController : UIViewController

@property (nonatomic,strong) Movie *movie;
@property (nonatomic,strong) NSString *movieURL;

@end

NS_ASSUME_NONNULL_END

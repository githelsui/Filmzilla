//
//  RecommendViewController.h
//  Filmzilla
//
//  Created by Githel Lynn Suico on 6/28/20.
//  Copyright © 2020 Githel Lynn Suico. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecommendViewController : UIViewController
@property (nonatomic,strong) NSString *movieURL;
@property (nonatomic,strong) Movie *movie;
@end

NS_ASSUME_NONNULL_END

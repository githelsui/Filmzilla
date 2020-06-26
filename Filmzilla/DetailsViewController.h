//
//  DetailsViewController.h
//  Filmzilla
//
//  Created by Githel Lynn Suico on 6/24/20.
//  Copyright © 2020 Githel Lynn Suico. All rights reserved.
//

#import <UIKit/UIKit.h>


NS_ASSUME_NONNULL_BEGIN

@interface DetailsViewController : UIViewController

@property (nonatomic,strong) NSDictionary *movie;
@property (nonatomic, strong) NSMutableArray *watchList;

@end

NS_ASSUME_NONNULL_END

//
//  MovieCell.h
//  Filmzilla
//
//  Created by Githel Lynn Suico on 6/24/20.
//  Copyright © 2020 Githel Lynn Suico. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CellDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *synopsisLabel;
@property (weak, nonatomic) IBOutlet UIImageView *posterView;
@property (weak, nonatomic) IBOutlet UIView *descView;
@property (weak, nonatomic) IBOutlet UIButton *favBtn;
@property long index;
@property (weak, nonatomic) id<CellDelegate>delegate;
@property (assign, nonatomic) NSInteger cellIndex;
@end

NS_ASSUME_NONNULL_END

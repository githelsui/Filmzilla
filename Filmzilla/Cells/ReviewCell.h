//
//  ReviewCell.h
//  Filmzilla
//
//  Created by Githel Lynn Suico on 6/25/20.
//  Copyright © 2020 Githel Lynn Suico. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ReviewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *authorLabel;
@property (weak, nonatomic) IBOutlet UILabel *reviewLabel;

@end

NS_ASSUME_NONNULL_END

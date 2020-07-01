//
//  MovieCell.m
//  Filmzilla
//
//  Created by Githel Lynn Suico on 6/24/20.
//  Copyright © 2020 Githel Lynn Suico. All rights reserved.
//

#import "MovieCell.h"
#import "UIImageView+AFNetworking.h"

@implementation MovieCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)setMovie:(Movie *)movie {
    // Since we're replacing the default setter, we have to set the underlying private storage _movie ourselves.
    // _movie was an automatically declared variable with the @propery declaration.
    // You need to do this any time you create a custom setter.
    self.movie = movie;
    self.titleLabel.text = self.movie.title;
    self.synopsisLabel.text = self.movie.overview;
    self.posterView.alpha = 0;
    self.titleLabel.alpha = 0;
    self.synopsisLabel.alpha = 0;
    self.posterView.layer.cornerRadius = 35;
    self.posterView.layer.masksToBounds = true;
    self.descView.layer.cornerRadius = 35;
    self.descView.layer.masksToBounds = true;
    self.delegate = self.delegate;
    self.posterView.image = nil;
    [UIView animateWithDuration:0.5 animations:^{
        if (self.movie.posterUrl != nil) {
            [self.posterView setImageWithURL:self.movie.posterUrl];
        }
        self.posterView.alpha = 1;
        self.titleLabel.alpha = 1;
        self.synopsisLabel.alpha = 1;
        self.titleLabel.text = movie.title;
        self.synopsisLabel.text = movie.overview;
    }];
    [self.favBtn addTarget:self action:@selector(favBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    UIView *backgroundView = [[UIView alloc] init];
    backgroundView.backgroundColor = UIColor.whiteColor;
    self.selectedBackgroundView = backgroundView;
}

@end

//
//  CellDelegate.h
//  Filmzilla
//
//  Created by Githel Lynn Suico on 6/27/20.
//  Copyright © 2020 Githel Lynn Suico. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol CellDelegate <NSObject>
- (void)didClickOnCellAtIndex:(NSInteger)cellIndex withData:(id)data;
@end

NS_ASSUME_NONNULL_END

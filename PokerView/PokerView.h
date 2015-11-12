//
//  PokerView.h
//
//  Created by zuckchen on 11/11/15.
//  Copyright © 2015 zuckchen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PokerView : UIScrollView

@property(nonatomic, assign) BOOL isHorizontalLayout;
@property(nonatomic, assign) CGSize itemSize;;

- (instancetype)initWithFrame:(CGRect)frame itemViews:(NSArray *)itemViews;

@end

//
//  PokerView.m
//
//  Created by zuckchen on 11/11/15.
//  Copyright © 2015 zuckchen. All rights reserved.
//

#import "PokerView.h"

// logorithm base
#define LogBase                          2.0f
// minimum scale
#define MinScale                         0.8f
// maxmum scale
#define MaxScale                         1.0f

#define VectorBase                       200

@implementation PokerView {
    NSMutableArray  *_itemViews;
}

- (instancetype)initWithFrame:(CGRect)frame itemViews:(NSArray *)itemViews {
    self = [super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        
        _itemViews = [NSMutableArray arrayWithArray:itemViews];
        for (UIView *itemView in itemViews) {
            [self addSubview:itemView];
        }
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    [self updateContentSize];
    
    CGSize size = self.itemSize;
    NSInteger count = _itemViews.count;
    for (NSInteger i = 0; i < count; i++) {
        UIView *itemView = _itemViews[i];
        CGRect frame = CGRectMake(0, 0, size.width, size.height);
        CGFloat tmp = 0.0f;
        CGFloat scale = 0.0f;
        if (_isHorizontalLayout) {
            tmp = VectorBase * pow(LogBase, (i * size.width - self.contentOffset.x) / size.width);
            scale = MinScale + (MaxScale - MinScale) * tmp / self.frame.size.width;
        } else {
            tmp = VectorBase * pow(LogBase, (i * size.height - self.contentOffset.y) / size.height);
            scale = MinScale + (MaxScale - MinScale) * tmp / self.frame.size.height;
        }
        
        if (scale > MaxScale) {
            scale = MaxScale;
        }
        if (scale < MinScale) {
            scale = MinScale;
        }
        
        frame.size.width = frame.size.width * scale;
        frame.size.height = frame.size.height * scale;
        
        if (_isHorizontalLayout) {
            frame.origin.x = tmp + self.contentOffset.x;
            frame.origin.y = (self.frame.size.height - frame.size.height) / 2;
        } else {
            frame.origin.x = (self.frame.size.width - frame.size.width) / 2;
            frame.origin.y = tmp + self.contentOffset.y;
        }

        
        itemView.frame = frame;
        [itemView layoutIfNeeded];
    }
}

- (void)updateContentSize {
    NSInteger count = _itemViews.count;
    if (count > 0) {
        CGSize size = self.itemSize;
        CGFloat itemHeight = 0.0f;
        if (_isHorizontalLayout) {
            itemHeight = size.width;
        } else {
            itemHeight = size.height;
        }
        
        CGFloat tmp = 0.0f;
        CGSize contentSize = CGSizeZero;
        if (_isHorizontalLayout) {
            tmp = [self logarithmFor:(self.frame.size.width - itemHeight) / VectorBase];
            contentSize = CGSizeMake(self.frame.size.width +(count - 1) * itemHeight - tmp * itemHeight, 0);
        } else {
            tmp = [self logarithmFor:(self.frame.size.height - itemHeight) / VectorBase];
            contentSize = CGSizeMake(self.frame.size.width, self.frame.size.height + (count - 1) * itemHeight - tmp * itemHeight);
        }
        
        if (!CGSizeEqualToSize(self.contentSize, contentSize)) {
            self.contentSize = contentSize;
        }
    }
}

- (CGSize)itemSize {
    CGSize size = _itemSize;
    if (CGSizeEqualToSize(size, CGSizeZero)) {
        size = CGSizeMake(self.frame.size.width / 2, self.frame.size.height / 2);
    }
    return size;
}

- (CGFloat)logarithmFor:(CGFloat)n {
    return logf(n) / logf(LogBase);
}

- (void)setIsHorizontalLayout:(BOOL)isHorizontalLayout {
    [self setContentOffset:CGPointZero animated:NO];
    _isHorizontalLayout = isHorizontalLayout;
    [self layoutSubviews];
}

@end

//
//  InsetsTextField.m
//  InverseLearn
//
//  Created by 大知 on 14-7-24.
//  Copyright (c) 2014年 DaZhi. All rights reserved.
//

#import "InsetsTextField.h"

@implementation InsetsTextField

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

//控制 placeHolder 的位置，左右缩 20
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 160 , 0 );
}

// 控制文本的位置，左右缩 20
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset( bounds , 160 , 0 );
}

@end

//
//  MyGLView.m
//  shadowExample
//
//  Created by Ben Van Citters on 2/27/17.
//  Copyright © 2017 Algorithms & Beauty. All rights reserved.
//

#import "MyGLView.h"

@implementation MyGLView

-(void)drawRect:(CGRect)rect
{
    [self.delegate glkView:self drawInRect:rect];
}
@end

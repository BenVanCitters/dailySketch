//
//  GLSketchPad.h
//  shadowExample
//
//  Created by Ben Van Citters on 2/27/17.
//  Copyright © 2017 Algorithms & Beauty. All rights reserved.
//

#import "MyGLView.h"

@import GLKit;

@interface GLSketchPad : UIView<GLKViewDelegate>
@property MyGLView* glView;
@property  EAGLContext* glContext;
@property NSTimer* updateTimer;

@property GLuint framebufferName;
@end

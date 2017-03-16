//
//  glHelpers.h
//  shadowExample
//
//  Created by Ben Van Citters on 3/2/17.
//  Copyright © 2017 Algorithms & Beauty. All rights reserved.
//
@import GLKit;

#ifndef glHelpers_h
#define glHelpers_h

void printFrameBufferStatus(GLenum fbStatus);

GLuint compileShader(NSString* string, GLenum type);

GLuint createVertFragShaderProg(NSString* fragSrc, NSString* vertSrc);

#endif /* glHelpers_h */

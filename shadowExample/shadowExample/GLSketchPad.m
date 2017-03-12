//
//  GLSketchPad.m
//  shadowExample
//
//  Created by Ben Van Citters on 2/27/17.
//  Copyright © 2017 Algorithms & Beauty. All rights reserved.
//

#import "GLSketchPad.h"
#import "glHelpers.h"

@implementation GLSketchPad

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super initWithCoder:aDecoder])
    {
        [self commonInit];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self commonInit];
    }
    return self;
}

-(void)commonInit
{
//    self.glView = [[GLKView alloc] init];
//    //    self.glView = [[GLKView alloc] initWithFrame:frame];
//    self.glView.delegate = self;
//    [self addSubview:self.glView];
//    
//    self.glView.enableSetNeedsDisplay = true;
//    [self.glView setNeedsDisplay];
//    [self.glView setNeedsLayout];
}

-(void)didMoveToSuperview
{
    [super didMoveToSuperview];
    [self initGLViewWithUpdate];
    [self initGL];
}

-(void)initGLViewWithUpdate
{
    self.glContext = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    [self.glView removeFromSuperview];
    self.glView = [[MyGLView alloc] initWithFrame:self.bounds
                                          context:self.glContext];
    self.glView.delegate = self;
    [self addSubview:self.glView];
    
    self.updateTimer = [NSTimer scheduledTimerWithTimeInterval:1/60.f
                                                  target:self
                                                selector:@selector(update)
                                                userInfo:nil
                                                 repeats:YES];
}

-(void)update
{
    [self.glView setNeedsDisplay];
}

-(void)initGL
{
    [EAGLContext setCurrentContext:self.glContext];
    self.framebufferName = 0;
    glGenFramebuffers(1, &_framebufferName);
    glBindFramebuffer(GL_FRAMEBUFFER, self.framebufferName);
    
    GLuint depthRenderbuffer;
    glGenRenderbuffers(1, &depthRenderbuffer);
    glBindRenderbuffer(GL_RENDERBUFFER, depthRenderbuffer);
    glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT16, 1024, 1024);
    glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, depthRenderbuffer);
    
    
    // Always check that our framebuffer is ok
    GLenum t = glCheckFramebufferStatus(GL_FRAMEBUFFER);
    if(t != GL_FRAMEBUFFER_COMPLETE)
    {
        printFrameBufferStatus(t);
    }
}

    
#pragma mark -
#pragma mark GLKViewDelegate
#pragma mark -

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    [EAGLContext setCurrentContext:self.glContext];
    GLint oldFboId = 0;
    glGetIntegerv(GL_FRAMEBUFFER_BINDING, &oldFboId);
    
    glBindFramebuffer(GL_FRAMEBUFFER, self.framebufferName);
    glClearDepthf([self rndF]*1000.f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    //re-bind the normal/main framebuffer
    glBindFramebuffer(GL_FRAMEBUFFER, oldFboId);
    
    [self performSelector:@selector(setNeedsDisplay) withObject:self.glView afterDelay:1/60.f];
}

-(float)rndF
{
    u_int32_t t = 70000;
    return arc4random_uniform(t)*1.f/t;
}



@end

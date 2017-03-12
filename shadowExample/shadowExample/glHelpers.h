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

//-(void)printFrameBufferStatus:(GLenum)fbStatus

void printFrameBufferStatus(GLenum fbStatus)
{
//    int fbStatus = glCheckFramebufferStatus(GL_FRAMEBUFFER);
    if(fbStatus == GL_FRAMEBUFFER_COMPLETE)
    {
        NSLog(@"GL_FRAMEBUFFER_COMPLETE: the specified framebuffer is complete." );
//        }else if(fbStatus == GL_FRAMEBUFFER_UNDEFINED)
//        {
//            NSLog(@"GL_FRAMEBUFFER_UNDEFINED: the specified framebuffer is the default read or draw framebuffer, but the default framebuffer does not exist." );
        }else if(fbStatus == GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT)
        {
            NSLog(@"GL_FRAMEBUFFER_INCOMPLETE_ATTACHMENT: the framebuffer attachment points are framebuffer incomplete. " );
        }else if(fbStatus == GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT)
        {
            NSLog(@"GL_FRAMEBUFFER_INCOMPLETE_MISSING_ATTACHMENT: the framebuffer does not have at least one image attached to it. " );
//        }else if(fbStatus == GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER)
//        {
//            NSLog(@"GL_FRAMEBUFFER_INCOMPLETE_DRAW_BUFFER: the value of GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE is GL_NONE for any color attachment point(s) named by GL_DRAW_BUFFERi. " );
//        }else if(fbStatus == GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER)
//        {
//            NSLog(@"GL_FRAMEBUFFER_INCOMPLETE_READ_BUFFER: GL_READ_BUFFER is not GL_NONE and the value of GL_FRAMEBUFFER_ATTACHMENT_OBJECT_TYPE is GL_NONE for the color attachment point named by GL_READ_BUFFER. " );
        }else if(fbStatus == GL_FRAMEBUFFER_UNSUPPORTED)
        {
            NSLog(@"GL_FRAMEBUFFER_UNSUPPORTED: the combination of internal formats of the attached images violates an implementation-dependent set of restrictions. " );
//        }else if(fbStatus == GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE)
//        {
//            NSLog(@"GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE: the value of GL_RENDERBUFFER_SAMPLES is not the same for all attached renderbuffers; if the value of GL_TEXTURE_SAMPLES is the not same for all attached textures; or, if the attached images are a mix of renderbuffers and textures, the value of GL_RENDERBUFFER_SAMPLES does not match the value of GL_TEXTURE_SAMPLES. " );
//        }else if(fbStatus == GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE)
//        {
//            NSLog(@"GL_FRAMEBUFFER_INCOMPLETE_MULTISAMPLE: if the value of GL_TEXTURE_FIXED_SAMPLE_LOCATIONS is not the same for all attached textures; or, if the attached images are a mix of renderbuffers and textures, the value of GL_TEXTURE_FIXED_SAMPLE_LOCATIONS is not GL_TRUE for all attached textures. " );
        }
}

GLuint compileShader(NSString* string, GLenum type)
{
    GLuint shadername = 0;

    shadername = glCreateShader(type);
    
    const GLchar* const shaderString = (GLchar*)[string UTF8String];
    glShaderSource(shadername, 1, &shaderString, NULL);
    glCompileShader(shadername);
    
    GLint success = 0;
    glGetShaderiv(shadername, GL_COMPILE_STATUS, &success);
    if(!success)
    {
        GLint logSize = 0;
        
        glGetShaderiv(shadername, GL_INFO_LOG_LENGTH, &logSize);
        GLchar* log = malloc(sizeof(GLchar)*logSize);
        glGetShaderInfoLog(shadername, logSize, &logSize, log);
        
        NSString* s = [NSString stringWithCString:log encoding:NSUTF8StringEncoding];
        free(log);
        NSLog(@"%@",s);
        glDeleteShader(shadername);
        return -1;
    }
    return shadername;
}

GLuint createVertFragShaderProg(NSString* fragSrc, NSString* vertSrc)
{
    GLuint vertShadername = compileShader(vertSrc, GL_VERTEX_SHADER);
    GLuint fragShadername = compileShader(fragSrc, GL_FRAGMENT_SHADER);
    
    GLuint prog = glCreateProgram();
    
    glAttachShader(prog, vertShadername);
    glAttachShader(prog, fragShadername);
    
    glLinkProgram(prog);
    
    //check status
    GLint isLinked = 0;
    glGetProgramiv(prog, GL_LINK_STATUS, (int *)&isLinked);
    if(isLinked == GL_FALSE)
    {
        GLint maxLength = 0;
        glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &maxLength);
        
        //The maxLength includes the NULL character
        GLchar* log = malloc(sizeof(GLchar)*maxLength);
        glGetProgramInfoLog(prog, maxLength, &maxLength, &log[0]);
        
        //We don't need the program anymore.
        glDeleteProgram(prog);
        //Don't leak shaders either.
        glDeleteShader(vertShadername);
        glDeleteShader(fragShadername);
        
        //Use the infoLog as you see fit.
        NSString* s = [NSString stringWithCString:log encoding:NSUTF8StringEncoding];
        free(log);
        NSLog(@"%@",s);
        //In this simple program, we'll just leave
        return -1;
    }
    
    //Always detach shaders after a successful link.
    glDetachShader(prog, vertShadername);
    glDetachShader(prog, fragShadername);
    //delete
    glDeleteShader(vertShadername);
    glDeleteShader(fragShadername);
    
    return prog;
}

#endif /* glHelpers_h */

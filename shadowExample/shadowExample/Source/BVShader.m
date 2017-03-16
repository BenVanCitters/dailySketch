//
//  BVShader.m
//  shadowExample
//
//  Created by Ben Van Citters on 3/14/17.
//  Copyright © 2017 Algorithms & Beauty. All rights reserved.
//

#import "BVShader.h"
#import "glHelpers.h"


@implementation BVShader

//***************************************************************************************
// preferred initializer
//***************************************************************************************
-(instancetype)initWithFrag:(NSString*)fragShaderName vert:(NSString*)vertShaderName context:(EAGLContext*) context
{
    if(self = [super init])
    {
        self.glContext = context;
        [self compileAndLinkVertShader:vertShaderName andFragName:fragShaderName];
    }
    return self;
}

//***************************************************************************************
//use to render with this shader
//***************************************************************************************
-(void)bind
{
//    store last shader prog??? possibly hurts performance due to sychronization??
//    GLint id;
//    glGetIntegerv(GL_CURRENT_PROGRAM,&id);
    
    [self setContext];
    glUseProgram(self.shaderName);
}
//****************************************************************************************
// use to pop back to the last shader, if that ever ends up making sense...
//****************************************************************************************
//-(void)unbindShader
//{
//    [self setContext];
//}

// it's very important to only ever attempt to operate on a gl construct within the
// approprite context, otherwise there is a good chance things will start to get weird
// when more than one context exists
-(void)setContext
{
    [EAGLContext setCurrentContext:self.glContext];
}

// assumes shader files have extensions ".frag" and ".vert"
-(void)compileAndLinkVertShader:(NSString*)vertFileName andFragName:(NSString*)fragFileName
{
    [self setContext];
    NSString *fragPath = [[NSBundle mainBundle] pathForResource:fragFileName
                                                         ofType:@"frag"];
    NSString *fragShaderCode = [NSString stringWithContentsOfFile:fragPath
                                                         encoding:NSUTF8StringEncoding error:nil];

    NSString *vertPath = [[NSBundle mainBundle] pathForResource:vertFileName
                                                         ofType:@"vert"];
    NSString *vertShaderCode = [NSString stringWithContentsOfFile:vertPath
                                                         encoding:NSUTF8StringEncoding error:nil];
    
    self.shaderName = createVertFragShaderProg(fragShaderCode, vertShaderCode);
}

//***************************************************************************************
// get the location of a uniform for this shader
//***************************************************************************************
-(GLuint)getUniformLocation:(NSString*)uniformName
{
    [self setContext];
    const char *name = [uniformName cStringUsingEncoding:NSASCIIStringEncoding];
    return glGetUniformLocation( self.shaderName, name );
}

//***************************************************************************************
// set a uniform float
//***************************************************************************************
-(void)setUniform1fAtLocation:(GLuint)uniformName withValue:(float)val
{
    [self setContext];
    glUniform1f(uniformName,val);
}

//***************************************************************************************
// set two uniform floats
//***************************************************************************************
-(void)setUniform2fAtLocation:(GLuint)uniformName withValue:(float)val andVal:(float)val2
{
    [self setContext];
    glUniform2f(uniformName,val,val2);
}

-(void)setMatrix4fv:(GLint)loc count:(GLsizei)count tran:(GLboolean)trans val:(GLfloat*)val
{
    [self setContext];
    glUniformMatrix4fv(loc, count, trans, val);
}

-(void)printUniforms
{
    [self setContext];
    GLint uniforms = -1;
    glGetProgramiv(self.shaderName, GL_ACTIVE_UNIFORMS, &uniforms);
    printf("Shader Handle #%d has %d GL_ACTIVE_UNIFORMS\n", self.shaderName, uniforms);
    for(int i = 0; i < uniforms; i++)
    {
        GLsizei bufsize=40; GLsizei length; GLint size; GLenum type;
        GLchar name[40];
        glGetActiveUniform(self.shaderName,i,bufsize,&length,&size,&type,name);
        printf("\tUniform Name: %s TypeEnum: %d\n",name,type);
    }
}

-(void)dealloc
{
    [self setContext];
    //delete shader
    glDeleteProgram(self.shaderName);
}

@end

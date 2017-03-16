//
//  BVShader.h
//  shadowExample
//
//  Created by Ben Van Citters on 3/14/17.
//  Copyright © 2017 Algorithms & Beauty. All rights reserved.
//

@import GLKit;

@interface BVShader : NSObject

@property GLuint shaderName;
@property  EAGLContext* glContext;

//***************************************************************************************
// preferred initializer
//***************************************************************************************
-(instancetype)initWithFrag:(NSString*)fragShaderName vert:(NSString*)vertShaderName context:(EAGLContext*) context;
//***************************************************************************************
//use to render with this shader
//***************************************************************************************
-(void)bind;

//-(void)compileAndLinkVertShader:(NSString*)vertFileName andFragName:(NSString*)fragFileName;
//***************************************************************************************
// get the location of a uniform for this shader
//***************************************************************************************
-(GLuint)getUniformLocation:(NSString*)uniformName;
//***************************************************************************************
// set a uniform float
//***************************************************************************************
-(void)setUniform1fAtLocation:(GLuint)uniformName withValue:(float)val;
//***************************************************************************************
// set two uniform floats
//***************************************************************************************
-(void)setUniform2fAtLocation:(GLuint)uniformName withValue:(float)val andVal:(float)val2;
-(void)setMatrix4fv:(GLint)loc count:(GLsizei)count tran:(GLboolean)trans val:(GLfloat*)val;
-(void)printUniforms;
@end

#include "Shader.h"
#include <iostream>

Shader::Shader(const char* vertexSource, const char* fragmentSource)
{
  // Create vertex shader
  GLuint vertexShader = glCreateShader(GL_VERTEX_SHADER);
  glShaderSource(vertexShader, 1, &vertexSource, NULL);
  glCompileShader(vertexShader);
  CompileErrors(vertexShader, "VERTEX");

  // Create fragment shader
  GLuint fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);
  glShaderSource(fragmentShader, 1, &fragmentSource, NULL);
  glCompileShader(fragmentShader);
  CompileErrors(fragmentShader, "FRAGMENT");

  // Create shader program and link shaders
  ID = glCreateProgram();
  glAttachShader(ID, vertexShader);
  glAttachShader(ID, fragmentShader);
  glLinkProgram(ID);
  CompileErrors(ID, "PROGRAM");

  // Delete shaders as they're now linked
  glDeleteShader(vertexShader);
  glDeleteShader(fragmentShader);
}

Shader::~Shader()
{
  // Destructor - cleanup handled by Delete()
}

void Shader::Activate()
{
  glUseProgram(ID);
}

void Shader::Delete()
{
  glDeleteProgram(ID);
}

void Shader::CompileErrors(unsigned int shader, const char* type)
{
  GLint hasCompiled;
  char infoLog[1024];

  if (std::string(type) != "PROGRAM")
  {
    glGetShaderiv(shader, GL_COMPILE_STATUS, &hasCompiled);
    if (hasCompiled == GL_FALSE)
    {
      glGetShaderInfoLog(shader, 1024, NULL, infoLog);
      std::cerr << "SHADER_COMPILATION_ERROR for: " << type << "\n" << infoLog << std::endl;
    }
  }
  else
  {
    glGetProgramiv(shader, GL_LINK_STATUS, &hasCompiled);
    if (hasCompiled == GL_FALSE)
    {
      glGetProgramInfoLog(shader, 1024, NULL, infoLog);
      std::cerr << "SHADER_LINKING_ERROR for: " << type << "\n" << infoLog << std::endl;
    }
  }
}

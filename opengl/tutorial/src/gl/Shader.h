#ifndef SHADER_H
#define SHADER_H

#include <glad/glad.h>
#include <string>

class Shader
{
public:
  unsigned int ID;

  Shader(const char* vertexSource, const char* fragmentSource);
  ~Shader();

  void Activate();
  void Delete();

private:
  void CompileErrors(unsigned int shader, const char* type);
};

#endif

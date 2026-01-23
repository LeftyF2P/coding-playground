#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <iostream>

#include "Shader.h"
#include "VAO.h"
#include "VBO.h"
#include "EBO.h"

// Vertex Shader source
const char* vertexShaderSource = R"(
#version 330 core
layout (location = 0) in vec3 aPos;
layout (location = 1) in vec3 aColor;

out vec3 ourColor;

void main()
{
    gl_Position = vec4(aPos, 1.0);
    ourColor = aColor;
}
)";

// Fragment Shader source
const char* fragmentShaderSource = R"(
#version 330 core
out vec4 FragColor;
in vec3 ourColor;

void main()
{
    FragColor = vec4(ourColor, 1.0);
}
)";

// Callback for window resize
void framebuffer_size_callback(GLFWwindow* window, int width, int height)
{
  glViewport(0, 0, width, height);
}

// Handle input
void processInput(GLFWwindow* window)
{
  if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS)
    glfwSetWindowShouldClose(window, true);
}

int main()
{
  // Initialize GLFW
  if (!glfwInit())
  {
    std::cerr << "Failed to initialize GLFW" << std::endl;
    return -1;
  }

  // Configure GLFW
  glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
  glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
  glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

  #ifdef __APPLE__
  glfwWindowHint(GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
  #endif

  // Create window
  GLFWwindow* window = glfwCreateWindow(800, 600, "OpenGL Triangle", NULL, NULL);
  if (window == NULL)
  {
    std::cerr << "Failed to create GLFW window" << std::endl;
    glfwTerminate();
    return -1;
  }
  glfwMakeContextCurrent(window);
  glfwSetFramebufferSizeCallback(window, framebuffer_size_callback);

  // Load OpenGL function pointers with GLAD
  if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress))
  {
    std::cerr << "Failed to initialize GLAD" << std::endl;
    return -1;
  }

  // Create shader program
  Shader shaderProgram(vertexShaderSource, fragmentShaderSource);

  // Triangle vertices (position + color)
  GLfloat vertices[] = {
    // positions         // colors
    -0.5f, -0.5f, 0.0f,  1.0f, 0.0f, 0.0f,  // bottom left (red)
    0.5f, -0.5f, 0.0f,  0.0f, 1.0f, 0.0f,  // bottom right (green)
    0.0f,  0.5f, 0.0f,  0.0f, 0.0f, 1.0f   // top (blue)
  };

  // Create VAO and VBO
  VAO vao;
  vao.Bind();

  VBO vbo(vertices, sizeof(vertices));

  // Link vertex attributes
  // Position attribute (location = 0)
  vao.LinkAttrib(vbo, 0, 3, GL_FLOAT, 6 * sizeof(float), (void*)0);
  // Color attribute (location = 1)
  vao.LinkAttrib(vbo, 1, 3, GL_FLOAT, 6 * sizeof(float), (void*)(3 * sizeof(float)));

  // Unbind to prevent accidental modifications
  vao.Unbind();
  vbo.Unbind();

  // Render loop
  while (!glfwWindowShouldClose(window))
  {
    // Input
    processInput(window);

    // Clear the screen
    glClearColor(0.2f, 0.3f, 0.3f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);

    // Draw the triangle
    shaderProgram.Activate();
    vao.Bind();
    glDrawArrays(GL_TRIANGLES, 0, 3);

    // Swap buffers and poll events
    glfwSwapBuffers(window);
    glfwPollEvents();
  }

  // Cleanup
  vao.Delete();
  vbo.Delete();
  shaderProgram.Delete();

  glfwTerminate();
  return 0;
}

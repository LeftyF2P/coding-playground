#include <iostream>
#include <cmath>

#include <glad/glad.h>
#include <GLFW/glfw3.h>

// Vertex Shader source code
const char *vertexShaderSource =
    "#version 330 core\n"
    "layout (location = 0) in vec3 aPos;\n"
    "void main()\n"
    "{\n"
    "   gl_Position = vec4(aPos.x, aPos.y, aPos.z, 1.0);\n"
    "}\0";
// Fragment Shader source code
const char *fragmentShaderSource =
    "#version 330 core\n"
    "out vec4 FragColor;\n"
    "void main()\n"
    "{\n"
    "   FragColor = vec4(0.8f, 0.3f, 0.02f, 1.0f);\n"
    "}\n\0";

int main() {

    // Initialize GLFW
    glfwInit();

    std::cout << "Starting Program" << std::endl;

    // Set the major version which is the first 3 in glfw 3.3
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);

    // Set the minor version which is the second 3 in glfw 3.3
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);

    // Set the opengl profile to the core profile
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

    // Vertices coordinates
    GLfloat vertices[] = {
        -0.5f,     -0.5f * float(sqrt(3)) / 3,    0.0f, // Lower left corner
        0.5f,      -0.5f * float(sqrt(3)) / 3,    0.0f, // Lower right corner
        0.0f,      0.5f * float(sqrt(3)) * 2 / 3, 0.0f, // Upper corner
        -0.5f / 2, 0.5f * float(sqrt(3)) / 6,     0.0f, // Inner left
        0.5f / 2,  0.5f * float(sqrt(3)) / 6,     0.0f, // Inner right
        0.0f,      -0.5f * float(sqrt(3)) / 3,    0.0f  // Inner down
    };

    // Indices for vertices order
    GLuint indices[] = {
        0, 3, 5, // Lower left triangle
        3, 2, 4, // Upper triangle
        5, 4, 1  // Lower right triangle
    };

    // Create the actual window
    int start_width = 800;
    int start_height = 800;
    GLFWwindow *window =
        glfwCreateWindow(start_width, start_height, "Hello Test!", NULL, NULL);

    if (window == NULL) {
        std::cout << "Failed to create GLFW window";
        glfwTerminate();
        return -1;
    }
    // Display the window that we just created
    glfwMakeContextCurrent(window);

    // Load glad and set the veiwport height and width
    gladLoadGL();
    glViewport(0, 0, start_width, start_height);

    // Create the vertex shader
    GLuint vertexShader = glCreateShader(GL_VERTEX_SHADER);
    glShaderSource(vertexShader, 1, &vertexShaderSource, NULL);
    glCompileShader(vertexShader);

    // Create the fragment shader
    GLuint fragmentShader = glCreateShader(GL_FRAGMENT_SHADER);
    glShaderSource(fragmentShader, 1, &fragmentShaderSource, NULL);
    glCompileShader(fragmentShader);

    // Initialize the shader program
    GLuint shaderProgram = glCreateProgram();

    // Attach the vertex and fragment shaders onto the shader program
    glAttachShader(shaderProgram, vertexShader);
    glAttachShader(shaderProgram, fragmentShader);

    // Link the shader program
    glLinkProgram(shaderProgram);

    // After we have linked the shader program we can delete the shaders
    glDeleteShader(vertexShader);
    glDeleteShader(fragmentShader);

    // Create reference containers for the Vertex Array Object (VAO) and the
    // Vertex Buffer Object (VBO) and Element Buffer Object (EBO)
    GLuint VAO, VBO, EBO;

    // Generate the VAO and VBO and in our case with only 1 object each
    glGenVertexArrays(1, &VAO);
    glGenBuffers(1, &VBO);
    glGenBuffers(1, &EBO);

    // Make our VAO the current vertex array object by binding it
    glBindVertexArray(VAO);

    // Bind the VBO specifying it's a GL_ARRAY_BUFFER
    glBindBuffer(GL_ARRAY_BUFFER, VBO);
    // Introduce our triangle vertices into our buffer object VBO
    glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);

    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, EBO);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(indices), indices,
                 GL_STATIC_DRAW);

    // Configure the vertex attribute so that OpenGL knows how to read the VBO
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(float),
                          (void *)0);
    // Enable the vertex attribute so that opengl knows how to use it
    glEnableVertexAttribArray(0);

    // Bind both the VBO and VAO to 0 so that we don't accidentally modify the
    // VAO and VBO we created
    glBindBuffer(GL_ARRAY_BUFFER, 0);
    glBindVertexArray(0);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, 0);

    // Set the color of the buffer
    glClearColor(0.07f, 0.13f, 0.17f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT);

    // Swap buffers so that the colored buffer is showing
    glfwSwapBuffers(window);

    // Create a while loop that keeps the program running as long as the window
    // is open
    while (!glfwWindowShouldClose(window)) {
        // Every frame set the background color of the buffer
        glClearColor(0.07f, 0.13f, 0.17f, 1.0f);
        glClear(GL_COLOR_BUFFER_BIT);

        // Tell OpenGL which shader program to use
        glUseProgram(shaderProgram);
        // Bind the VAO so OpenGL knows to use it
        glBindVertexArray(VAO);
        // Draw the triangle using opengl's triangle primitive
        glDrawElements(GL_TRIANGLES, 9, GL_UNSIGNED_INT, 0);

        // Swap the buffers so that we can see the changes that have been made
        // to the back buffer
        glfwSwapBuffers(window);

        // Run all the events that have happened every frame
        glfwPollEvents();
    }

    std::cout << "Program has closed successfully" << std::endl;

    glDeleteVertexArrays(1, &VAO);
    glDeleteBuffers(1, &VBO);
    glDeleteBuffers(1, &EBO);
    glDeleteProgram(shaderProgram);

    // Destroy and terminate the window and the GLFW that was initialized
    glfwDestroyWindow(window);
    glfwTerminate();
    return 0;
}

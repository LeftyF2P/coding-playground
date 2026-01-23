const std = @import("std");

const c = @cImport({
    @cDefine("GLFW_INCLUDE_NONE", "1");
    @cInclude("GLFW/glfw3.h");
    @cInclude("GL/gl.h");
});

pub fn main() !void {
    if (c.glfwInit() == 0) return error.GlfwInitFailed;
    defer c.glfwTerminate();

    // Request an OpenGL 2.1 context (fixed-function works here)
    c.glfwWindowHint(c.GLFW_CONTEXT_VERSION_MAJOR, 2);
    c.glfwWindowHint(c.GLFW_CONTEXT_VERSION_MINOR, 1);
    c.glfwWindowHint(c.GLFW_RESIZABLE, c.GLFW_TRUE);

    const window = c.glfwCreateWindow(800, 600, "Zig OpenGL Triangle", null, null) orelse return error.GlfwCreateWindowFailed;
    defer c.glfwDestroyWindow(window);

    c.glfwMakeContextCurrent(window);
    c.glfwSwapInterval(1);

    while (c.glfwWindowShouldClose(window) == 0) {
        var w: c_int = 0;
        var h: c_int = 0;
        c.glfwGetFramebufferSize(window, &w, &h);
        c.glViewport(0, 0, w, h);

        c.glClearColor(0.08, 0.08, 0.10, 1.0);
        c.glClear(c.GL_COLOR_BUFFER_BIT);

        c.glBegin(c.GL_TRIANGLES);
        c.glColor3f(1.0, 0.2, 0.2);
        c.glVertex2f(-0.6, -0.4);

        c.glColor3f(0.2, 1.0, 0.2);
        c.glVertex2f(0.6, -0.4);

        c.glColor3f(0.2, 0.4, 1.0);
        c.glVertex2f(0.0, 0.6);
        c.glEnd();

        c.glfwSwapBuffers(window);
        c.glfwPollEvents();
    }
}

const GlfwInitFailed = error{GlfwInitFailed};
const GlfwCreateWindowFailed = error{GlfwCreateWindowFailed};

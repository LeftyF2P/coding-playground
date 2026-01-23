#include "raylib.h"
#include <iostream>

class Ball {
    public:
        Vector2 position;
        Vector2 velocity;
        float radius;

        Ball(Vector2 pos, Vector2 vel, float r)
            : position(pos), velocity(vel), radius(r) {}

        void Update(float dt) {
            position.x += velocity.x * dt;
            position.y += velocity.y * dt;

            if (position.y + radius >= GetScreenHeight() || position.y - radius <= 0) {
                velocity.y *= -1;
            }
        }

        void Draw() {
            DrawCircleV(position, radius, WHITE);
        }
};

class Paddle {
    public:
        Vector2 position;
        Vector2 size;
        bool player;

        Paddle(Vector2 pos, Vector2 s, bool p)
            : position(pos), size(s), player(p) {}
        
        void Update(float movement, Vector2 ball_pos) {
            position.y += movement;

            if (position.y <= 0 || position.y >= GetScreenHeight() - size.y) {
                position.y -= movement;
            }

            if (!player) {
                position.x = GetScreenWidth() - 20 - size.x; // This magic number is the same as the paddle_buffer but I don't care to make a global variable lol
                if (ball_pos.y > position.y + (size.y/2) - 40) {
                    position.y += 10.0f;
                } else if (ball_pos.y < position.y + (size.y/2) + 40) {
                    position.y -= 10.0f;
                }
            }
        }

        void Draw() {
            DrawRectangleV(position, size,WHITE);
        }
};

int main() {
    std::cout << "Starting Game" << std::endl;

    // ----- Variables -----

    //Window Variables
    int screen_width = 1200;
    int screen_height = 800;

    //Ball Variables
    int ball_speed = 3;
    Vector2 ball_pos = {(float)screen_width / 2, (float)screen_height / 2};
    Vector2 ball_vel = {200.0f, 200.0f};
    float ball_radius = 25.0f;
    Color ball_color = {255, 15, 15, 255};

    Ball ball(ball_pos, ball_vel, ball_radius);

    //Paddle Variables
    int paddle_buffer = 20;
    float paddle_speed = 200.0f;
    Vector2 paddle_size = {25, 120};
    Vector2 rect_p1_pos = {(float)paddle_buffer, ((float)screen_height / 2) - (paddle_size.y / 2)};
    Vector2 rect_p2_pos = {(screen_width - paddle_buffer - paddle_size.x), ((float)screen_height / 2) - (paddle_size.y / 2)};

    Paddle player_1(rect_p1_pos, paddle_size, true);
    Paddle player_2(rect_p2_pos, paddle_size, false);

    // ----- Initialize Windows -----
    SetConfigFlags(FLAG_WINDOW_RESIZABLE);
    InitWindow(screen_width, screen_height, "First Raylib Game");
    SetTargetFPS(60);

    // ----- Game Loop -----
    while (!WindowShouldClose()) {
        // 1. Event Handeling
        float dt = GetFrameTime();
        float p1_movement = 0.0;
        float p2_movement = 0.0;

        if (IsKeyDown(KEY_W)) {
            p1_movement -= paddle_speed * dt;
        } else if (IsKeyDown(KEY_S)) {
            p1_movement += paddle_speed * dt;
        }

        // 2. Update Positions
        ball.Update(dt);
        player_1.Update(p1_movement, ball.position);
        player_2.Update(p2_movement, ball.position);
        
        // 3. Drawing
        BeginDrawing();
        ClearBackground(BLACK);

        screen_height = GetScreenHeight();
        screen_width = GetScreenWidth();
        DrawLine(screen_width/2, 0, screen_width/2, screen_height, WHITE);

        ball.Draw();
        player_1.Draw();
        player_2.Draw();

        EndDrawing();
    }

    // ----- Close Program -----
    CloseWindow();
    return 0;
}

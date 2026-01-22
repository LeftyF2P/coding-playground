#pragma once

#include <string>
#include <vector>

struct Task {
  int id;
  bool done;
  std::string text;
}

class TodoList {
public:
  void add(std::string text);
  bool mark_done(int id);
  bool remove(int id);

  const std::vector<Task> &items() const;

private:
  std::vector<Task> tasks_;

  int next_id() const;
  Task *find(int id);
};

import 'dart:math';

//! Question 934. Shortest Bridge

//* You are given an n x n binary matrix grid where 1 represents
//* land and 0 represents water. An island is a 4-directionally connected
//* group of 1's not connected to any other 1's. There are exactly two islands
//* in grid. You may change 0's to 1's to connect the two islands to form one island.

//* Return the smallest number of 0's you must flip to connect the two islands.

/*
Example 1:
    Input: grid = [[0,1],[1,0]]
    Output: 1

Example 2:
    Input: grid = [[0,1,0],[0,0,0],[0,0,1]]
    Output: 2

Example 3:
    Input: grid = [[1,1,1,1,1],[1,0,0,0,1],[1,0,1,0,1],[1,0,0,0,1],[1,1,1,1,1]]
    Output: 1

  Constraints:
  n == grid.length == grid[i].length
  2 <= n <= 100
  grid[i][j] is either 0 or 1.
  There are exactly two islands in grid.
*/
class MySolution {
  List<List<int>> q = []; // queue

  void dfs(List<List<int>> grid, int i, int j) {
    // for marking the 1st island visited
    int n = grid.length;
    int m = grid[0].length;

    if (i < 0 ||
        i >= n ||
        j < 0 ||
        j >= m ||
        grid[i][j] == 2 ||
        grid[i][j] == 0) return;

    grid[i][j] = 2; // marking them visited
    q.add([i, j]); // adding them to queue

    dfs(grid, i + 1, j);
    dfs(grid, i - 1, j);
    dfs(grid, i, j + 1);
    dfs(grid, i, j - 1);
  }

  int bfs(List<List<int>> grid) {
    // finding the nearest bridge between visited island and unvisited island
    int n = grid.length;
    int m = grid[0].length;

    int d = 0; // dist
    int mindist = 9223372036854775807; // to store minimum distance

    List<List<int>> dir = [
      [1, 0],
      [0, 1],
      [-1, 0],
      [0, -1]
    ];

    while (q.isNotEmpty) {
      int size = q.length;

      while (size-- > 0) {
        List<int> a = q.removeAt(0);

        for (int h = 0; h < 4; h++) {
          int x = dir[h][0] + a[0];
          int y = dir[h][1] + a[1];

          if (x >= 0 && x < n && y >= 0 && y < m && grid[x][y] == 1) {
            // if the neighbor is 1, then check if its minimum distance
            mindist = min(mindist, d);
          } else if (x >= 0 && x < n && y >= 0 && y < m && grid[x][y] == 0) {
            // if the neighbor is 0, then mark it visited and add it to queue
            q.add([x, y]);
            grid[x][y] = 2;
          }
        }
      }
      d++; // increasing each level by distance + 1
    }

    return mindist; // returning min dist found till end
  }

  int shortestBridge(List<List<int>> grid) {
    int n = grid.length;
    int m = grid[0].length;

    bool flag = false;

    for (int i = 0; i < n; i++) {
      for (int j = 0; j < m; j++) {
        if (grid[i][j] == 1 && !flag) {
          // found 1st '1' in the matrix
          dfs(grid, i, j); // dfs for marking the whole island visited
          q.add([i, j]);
          flag = true;
          break;
        }
      }
      if (flag) break;
    }

    return bfs(grid); // bfs for getting min dist and returning it
  }
}

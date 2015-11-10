Technical Exercise
---------------------------

Build a Rails application that generates and solves a Maze. You will be assessed primarily on your:
* Testing approach
* Solution design
* Code quality

We are keen to see your thought process and approach rather than the complete implementation.


Assumptions
------------

I will be skipping any typical requirements gathering or analysis phase.
Typically, we'd start a project by finding the motivations for the project and
eliminating the obvious solutions and skipping unnecessary features etc.

So let's assume that the business has a significantly good reason to generate mazes and
solve them. 
And that the best technology for this is a well tested rails app.

Given the artifical constraints of the project, I will be adding another one.
I won't be reading about mazes or how to solve them. I won't look for maze solving
ruby libraries, blog posts or maze solving rails apps.
I don't know a great deal of algorithms off the top of my head, so I also won't be
searching for shortest path algorithms or anything of that nature.

It may seem like unnecessary preamble, but the best solution for most coding tasks
is normally not to do them at all where possible. Secondly, I want to 
preempt any questions if I were being tested now on my requirements gathering skills.


OK so we need a maze
===================

I like README driven development, so I'm going to make the mazes ASCII art. It will
make them easier to write about, and testing will be more visual.

So let's start with maze generation. 
Once we can do that we can move onto solving mazes.

Firstly, what is a maze?
-----------------------
In this case it will be a grid with a single or multiple paths through the grid.
There is a single start point and a single end point.
Walls separate paths from each other.

So as an initial plan, let's make an easy maze.
We have a grid with a random start point, and a random entry point and we
need to draw a path between those.

w - wall
s - start
e - end
whitespace is path

```
wswwwwwwww
w wwwwwwww
w wwwwwwww
w wwwwwwww
w wwwwwwww
w wwwwwwww
w wwwwwwww
w        w
wwwwwwwwew
```



First pass through trying to generate a grid with a start point has resulted in 
discovering three classes.

```
MazeGenerator
EdgeSelector
Point
```

Second pass and we get
```
FinishPoint
Wall
```

Because of the keyword ruby `end`, I'll choose finish to represent end. So we now have
start point 's' and finish point (represented by 'f').

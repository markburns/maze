[![Code Climate](https://codeclimate.com/github/markburns/maze/badges/gpa.svg)](https://codeclimate.com/github/markburns/maze)

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

Tests
------

Please run the tests with spring. 

```
spring rspec spec                                                                                [2.2.2]
```

Resolving dependencies between files manually is not worth it
when we have `ActiveSupport::Dependencies` available anyway. The tests are fast enough.

```
markburns@Marks-MacBook-Air ~/code/maze (master●)$ time spring rspec spec                                                                    [2.2.2]
...............................................

Finished in 0.1919 seconds (files took 0.20495 seconds to load)
47 examples, 0 failures

spring rspec spec  0.23s user 0.08s system 34% cpu 0.893 total

markburns@Marks-MacBook-Air ~/code/maze (master●)$ time bundle exec spring rspec spec                                                                    [2.2.2]
...............................................

Finished in 0.24164 seconds (files took 0.28236 seconds to load)
47 examples, 0 failures

bundle exec spring rspec spec  0.68s user 0.17s system 49% cpu 1.702 total
```

Spec timeouts
-------------

As there are some `while`/`until`s in the code, sometimes when developing there may be a bug that
hangs the specs
Set the TIMEOUT environment variable when running specs to prevent this.

```
TIMEOUT=true spring rspec
```

Tip
----
Save yourself more time by aliasing
`sr='spring rspec'`

Bonus Tip
----
Save yourself even more time by using vim with [yadr](https://github.com/skwp/dotfiles)
and executing individual specs with

`,sl`

and the whole file with
`,ss`



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



first pass through trying to generate a grid with a start point has resulted in
discovering three classes.

```
MazeGenerator
EdgeSelector
Point
```

second pass and we get

```
FinishPoint
Wall
```

because of the keyword ruby `end`, i'll choose finish to represent end. so we now have
start point 's' and finish point (represented by 'f').


Now blank maze generation is working, time to find a path through the maze

The way it has been built means we can just overwrite the Wall in the grid.
So we just need a way to first
  * Generate paths from start to finish
  * Generate interesting paths


Progress
--------

So now we can generate paths from start to finish, but they look like this:

```
f



      w
      w  s
w     w
w     w
ww
wwww ww
```

Obviously we need walls in between our paths.
An alternative is to change the rendering so that each square has walls defined
around it, and when traversing the path you are removing walls


Visitor Pattern
--------------

Adding the visitor pattern allows us to display the maze in a different way.
I didn't want to end up doing tons of string manipulation so with this pattern,
we can display a single point as e.g.

`.`

or as

```
---
| |
---
```

This will allow for defining paths for left, right, up, down etc.

Path generation problem
----------------------
Random moving around the maze will not always result in a traversable path.

```
     PathGenerator::PathNotFound:
       no non traversed adjacent points found, for #<struct PathDown x=6, y=4> in #<struct Maze width=10, height=10, start=#<struct StartPoint x=9, y=5>, finish=#<struct FinishPoint x=0, y=0>>
 ```

What we need to do is record where we have been and then trace back to generate more 
alternative routes.

Using a stack will allow us to record paths, then go back if we hit a dead end.

Visitor pattern
---------------

Implementation of rendering of the grid/paths with the visitor pattern allows us
to decouple the display aspects from the logic of the maze generation.
We can then use an `HtmlVisitor` or something similar for rendering in the front end web app.

Missing space in grid
--------------------

The next challenge is to fill out the grid as they currently look like this:

```
  ◎   ▥   ▥   ▥   ▥   ▥   ▥ ▼11 ◀10   ▥
▲33 ▼28 ◀27   ▥   ▥   ▥   ▥ ▼12 ▲9    ▥
▲32 ▼29 ▲26   ▥   ▥ ▼15 ◀14 ◀13 ▲8  ◀7
▲31 ◀30 ▲25 ◀24   ▥ ▶16 ▼17 ▶4  ▶5  ▲6
  ▥   ▥   ▥ ▲23   ▥   ▥ ▼18 ▲3  ◀2    ▥
  ▥   ▥   ▥ ▲22 ◀21 ◀20 ◀19   ▥ ▲1  ◀0
  ▥   ▥   ▥   ▥   ▥   ▥   ▥   ▥   ▥   ▥
  ▥   ▥   ▥   ▥   ▥   ▥   ▥   ▥   ▥   ▥
  ▥   ▥   ▥   ▥   ▥   ▥   ▥   ▥   ▥   ▥
  ▥   ▥   ▥   ▥   ▥   ▥   ▥   ▥   ▥   ▥

```


The integers are the index of traversals round the grid, just to aid
debugging/understanding.
The arrows show the direction of traversal.


Luckily we have already created an `EdgeSelector` and a `PathGenerator` so this should be easy.

Twistiness
-----------

The maze is quite twisty. I think we need to change the probability of turning to be
a bit lower than the probability of continuing in the same direction.
We have an array of candidate adjacent points at each point in the maze


Deadends
--------

So even though the code will traverse back along a path one step, it can still block the exit 
or hit a deadend. So we need to be able to traverse back further and record where we have been.


Missing Space and Deadends are fixed
------------------------

and removing the debug info for paths the mazes look like this:

```
🚶   ▥  →  →  ↓  ▥  ←  →  ↓  ▥  ↓  ←  ▥  ↓  ←  ↓  ←  ←  ←  ←  ←  →  ↓  →  →  ↓  →  ←  ↓  ←
→  ↓  ↑  ▥  →  →  ↓  ↑  →  ←  ↓  ↑  ←  ←  ↑  ←  →  →  ↓  ▥  ↑  ↑  →  →  ↓  ↑  ↑  ▥  ↓  ↑
↓  ←  ↑  ↑  →  ↓  ↓  ↑  ←  ←  ←  ▥  →  →  →  →  ↑  ▥  →  →  ↑  ↑  ←  ▥  ↓  ▥  ↑  ←  ←  ↑
→  ↓  ↑  ←  ←  ←  ↓  →  ↓  →  ↓  →  ↑  ▥  ←  ←  ←  ↓  ▥  →  ▥  ↓  ←  ↑  ↓  →  →  ↓  ▥  ↑
▥  →  ↓  →  ↓  ▥  ↑  ↑  →  ↑  ↓  ↑  →  →  →  ↓  ↑  →  ↓  ↓  ←  ←  ↑  ↑  →  ↑  ▥  →  →  ↑
↓  ←  →  ↑  →  →  ↓  ↑  ←  ↓  →  ↑  ↑  ←  ↓  ←  ↑  ←  ←  ↓  →  →  ↓  ↓  ←  ←  ←  ↓  ←  ←
▥  ↑  →  →  ←  ▥  →  ↓  ↑  ▥  →  ↓  →  ↑  →  →  →  →  ↓  ↑  ↑  ▥  ↓  ↑  ▥  →  ↑  ↓  ↓  ←
→  ↑  ↑  ←  →  ↓  ↓  ←  ↑  →  ↑  ↓  ↑  ←  ↓  ←  →  ↓  ↓  ▥  ↑  ↑  →  ↓  →  ↑  ↓  ←  ↓  ▥
↑  ←  ←  ↑  ↑  ↓  →  ↓  →  ↑  ↓  ↓  ▥  ↑  ←  ↑  ↑  ↓  ↓  →  ↑  ↑  ▥  →  →  ↓  →  ↑  →  ↓
↓  ▥  ↑  ↑  ↑  →  ↓  →  ↑  ▥  ↑  →  ↓  →  →  ↑  ↑  ↓  →  ↑  →  ↓  →  ↓  ▥  →  ↓  ▥  ↓  ←
↓  →  ↑  ↑  ←  ▥  ↓  ▥  →  ←  ↓  ↓  ↓  ↑  ←  ↓  ←  ←  →  ←  ↑  →  ↑  ↓  ↑  ▥  →  ↓  →  ↓
↓  ↑  ←  →  ↑  ↓  ←  →  ↓  ↑  ←  ▥  →  →  ↑  →  →  ↓  ▥  →  ↑  ↓  ←  →  →  ↓  ↓  ←  ▥  ↓
→  ↓  ↑  ↑  ←  ←  ▥  ↑  →  →  ↓  →  →  →  ↓  →  ↓  →  →  ↑  ▥  ←  →  ↓  ↓  ←  ↓  ▥  ←  ↓
▥  ←  ↑  →  ▥  →  →  ↓  ▥  →  ←  ↑  ↓  ←  ←  ↑  ↓  ▥  →  →  →  →  ↑  ↓  ↓  ▥  →  ↓  ↑  ←
→  →  ↑  ↑  ←  ↑  ←  →  →  →  →  ↑  ↓  →  ▥  ↓  ←  →  ↑  →  ↓  ↓  ←  ←  ↓  ↓  ←  ←  ▥  ↓
↑  ←  ←  →  ↑  ↓  ←  →  →  ▥  ↓  ↓  ←  ↑  ←  ←  →  ↑  ▥  ↓  ←  →  ↓  ▥  ←  →  ↓  →  →  ↑
→  ↓  ↑  ↑  ←  ▥  ↓  ←  ←  ←  ↓  →  ↓  ▥  →  ↓  ↑  ←  ↓  ▥  →  ↓  ↓  →  ↓  ↓  ↓  ↑  ←  ←
↑  ▥  ↑  ▥  ↑  ↓  ←  ▥  →  ▥  ↓  ▥  ↓  →  ↑  →  →  ↑  →  →  ↑  ▥  →  ↑  ↓  ↓  ↓  ▥  →  ↓
↑  →  ↑  →  ↑  ↓  →  →  →  ↓  →  ↓  ↓  ↑  ←  →  →  →  →  →  →  ↓  →  ←  ↓  ↓  →  ↓  ▥  ↑
↑  ↑  ▥  ↑  ←  ←  ▥  ↓  ←  →  ↓  ↓  ↓  ▥  ↑  ←  ←  ▥  →  ←  ←  ←  ▥  ↓  ←  ↑  ▥  →  →  ↓
▥  ↑  ←  ←  ↓  ←  ←  ←  ↑  ▥  ↓  ↓  ↓  →  ↓  ▥  ↑  ↓  ←  ▥  ↓  ←  ←  ←  ▥  →  →  →  ↓  ↓
↓  ←  ▥  ↑  ←  ↓  ←  →  ↑  →  ←  ↓  ↓  ↑  ↑  →  ↑  ↓  ↑  ←  ↓  →  ↓  →  →  ↑  ▥  ↑  ←  ↓
↑  ↑  ↓  ←  ←  ↓  ↑  ▥  ←  ↓  ↓  ←  →  ↑  ▥  ↑  ▥  →  →  ↑  →  ↑  →  ↑  ▥  ↓  ←  ←  ←  ←
▥  ↓  ←  →  ↑  ↓  ↑  ←  ←  ↑  ↓  ↓  ←  ↓  ←  ↑  ←  ←  ▥  ↓  ↓  ←  ▥  →  ←  ↓  ▥  →  →  ↓
↓  ←  ↓  ←  ←  →  →  ←  ↑  ▥  ↓  ▥  ↑  ←  ↑  ←  ←  ↑  ←  ↑  ↓  ↑  ↓  ←  ←  →  ↓  →  ←  ↓
↓  ↓  ←  ▥  ↑  ←  ←  ▥  ↑  ←  →  →  →  →  →  →  ↑  →  ↑  ↑  ↓  ↑  ←  ▥  ↑  ←  ←  ▥  ↑  ←
↓  ↓  →  ↓  →  ↓  →  ↓  ▥  ↑  →  →  ↓  →  →  ↓  ▥  ↑  ←  ←  ↓  ▥  →  →  →  →  →  →  →  ↓
▥  ↓  ↑  →  ↑  →  ↑  →  →  ↑  ↑  ←  ↓  ↑  ▥  →  ↓  →  ↓  ↑  →  ↓  ↑  ←  ←  ←  ←  ↓  ↓  ←
↓  ←  ↑  ←  →  →  →  →  ↓  →  ▥  ↑  ↓  ↑  ←  ▥  ←  ↑  ↓  ↑  ↓  ←  →  →  →  →  ↑  ↓  ↓  ▥
→  →  →  →  ↑  →  →  ▥  →  →  →  ↑  →  →  →  →  →  ↑  →  ↑  →  →  ↑  ▥  ←  ←  ▥  ↑  →  🚪
```


Rendering to be more maze like
-------------------------------

Now that maze generation is working it would be nice to have an easier way to view them,
and for them to look prettier.


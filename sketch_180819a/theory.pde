/*
How does this all work anywhay?

I need to have a bunch of 'orientable' triabgles
these trianlges need to know about their neighbors and know how thei neighbors are positioned 
relatively to themselves

My first thought is that I want to define a single triangle, perhaps in the middle
of the screen and then use that to define the rest of the space.

I also need somehow to define a 'ruleset' - how triangles are oriented relative each
other somehow...

Another goals is to keep an orderly system of points, triangles, and segments -
I think getting the oriented triangle layout will be far easier if there is a notion
of a 'segment' - that is, a line between tow points. Thus a triangle is composed of
three segments which each have two points.

Triangles share ownership of segments, segments share ownership of points - it's
all about sharing, really.  

In this system each triangle has three segments. Eaach segment has two points and
up to two triangles. The points don't have any notion of which trianlges or segments
they are connected too because the system doesn't yet have a need to do that kind of
lookup.

How about this noition of orientation, then?
Triangles can be oriented in one of three ways. They can be flipped and rotated. 
There are two flips and three rotations - 2 * 3 = 6. 
In my design I shall define a ruleset as the orientaiton of a single trinagle and
the orientation of each adjacent riangle that shares a line segment. So, the triangle
itself and each of its three neighnors. If each of the triangle itself and its three 
neightbors have 6 possible orientations then the total number of distinct rulesets is
6*6*6*6 = 1296.
The purpose of the rule set is to answer the question: when I traverse the edge of 
this triangle and enter a new triangle, in which part of the new triangle will I be?

Hence, my notion of orientationshould depend only on the trianlge one is currently in.

There are therefore rules which lead to consistent and inconsistent orientations.



8?
/*

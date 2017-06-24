# UnityProjects
A collection of small unity projects and pacakages that anyone is free to use.
You can download the package or the indivdual assets.

What is included?
Shaders that have a funky cutout function.
Shaders that use world coordinates.
Some simple code to manage these shaders so they can do cool things.
A simple editor script to add emissive objects to the unity lightmap.
And some textures.

The shaders. 
There are five shaders with slight variations.
4 of the shaders have a cutout function that takes two positions.
By repeating a spherical cull between the two points you end up with a cylinderical shaped cull.
This is a funky effect I'm currently using in my game Sticky Baby.
There are many things that could get in the way of the player character so I use this shader to make the player character visable at all times.
You can move the camera and player cylinder in the example scene to see what kind of affect it has.

The other shader is a multi-cutout shader. 
By passing in many different positions to the shader we can cull by a radius around each position.
This could be useful in a RTS type game where your characters go under a bridge or trees but you wand them to be visable.

I'm no shader expert so feel free to use these and even improve them.
Would love to see if you can use these to make something other than an odd way to keep the player character visable.

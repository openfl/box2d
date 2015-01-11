[![MIT License](https://img.shields.io/badge/license-MIT-blue.svg?style=flat)](LICENSE.md) [![Haxelib Version](https://img.shields.io/github/tag/openfl/box2d.svg?style=flat&label=haxelib)](http://lib.haxe.org/p/box2d)

Box2D
=====

The Box2D rigid-body 2D physics engine, ported to Haxe from the Box2DFlash port by Boris the Brave.

The syntax has been updated to follow the standard Haxe convention, for example:

**ActionScript**

    var world:b2World = new b2World (new b2Vec2 (0, 10.0), true);
    var worldScale:int = 30;
    
    var body:b2BodyDef = new b2BodyDef ();
  	body.position.Set (250 / worldScale, 200 / worldScale);
  	body.type = b2Body.b2_dynamicBody;
  	
  	var circle:b2CircleShape = new b2CircleShape (10 / worldScale);
  	var fixture:b2FixtureDef = new b2FixtureDef ();
  	fixture.shape = circle;
  	
  	player = world.CreateBody (body);
  	player.CreateFixture (fixture);

The above ActionScript code would be written like this in Haxe:

**Haxe**

    var world = new B2World (new B2Vec2 (0, 10.0), true);
    var worldScale = 30;
    
    var body = new B2BodyDef ();
    body.position.set (250 / worldScale, 200 / worldScale);
    body.type = DYNAMIC_BODY;
    
    var circle = new B2CircleShape (10 / worldScale);
    var fixture = new B2FixtureDef ();
    fixture.shape = circle;
    
    player = world.createBody (body);
    player.createFixture (fixture);


Installation
============

You can easily install Box2D using haxelib:

    haxelib install box2d

To add it to a Lime or OpenFL project, add this to your project file:

    <haxelib name="box2d" />


Development Builds
==================

Clone the Box2D repository:

    git clone https://github.com/openfl/box2d

Tell haxelib where your development copy of Box2D is installed:

    haxelib dev box2d box2d

To return to release builds:

    haxelib dev box2d

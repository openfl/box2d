/*
* Copyright (c) 2006-2007 Erin Catto http://www.gphysics.com
*
* This software is provided 'as-is', without any express or implied
* warranty.  In no event will the authors be held liable for any damages
* arising from the use of this software.
* Permission is granted to anyone to use this software for any purpose,
* including commercial applications, and to alter it and redistribute it
* freely, subject to the following restrictions:
* 1. The origin of this software must not be misrepresented; you must not
* claim that you wrote the original software. If you use this software
* in a product, an acknowledgment in the product documentation would be
* appreciated but is not required.
* 2. Altered source versions must be plainly marked as such, and must not be
* misrepresented as being the original software.
* 3. This notice may not be removed or altered from any source distribution.
*/


	import lime.ui.KeyCode;
	import box2D.dynamics.*;
	import box2D.collision.*;
	import box2D.collision.shapes.*;
	import box2D.dynamics.joints.*;
	import box2D.dynamics.contacts.*;
	import box2D.common.*;
	import box2D.common.math.*;

class Test {
		
	 
		var m_physScale = 30;
	 	
		public function new(){
			
			var worldAABB:B2AABB = new B2AABB();
			worldAABB.lowerBound.set(-1000.0, -1000.0);
			worldAABB.upperBound.set(1000.0, 1000.0);
			
			// Define the gravity vector
			var gravity:B2Vec2 = new B2Vec2(0.0, 10.0);
			
			// Allow bodies to sleep
			var doSleep:Bool = true;
			
			// Construct a world object
			m_world = new B2World(gravity, doSleep);
			//m_world.setBroadPhase(new B2BroadPhase(worldAABB));
			m_world.setWarmStarting(true);
			// set debug draw
			var dbgDraw:IDebugDraw = Global.debugDraw;
			// dbgDraw.setSprite(m_sprite);
			dbgDraw.setDrawScale(30.0);
			dbgDraw.setFillAlpha(0.3);
			dbgDraw.setLineThickness(1.0);
			dbgDraw.setFlags(B2DebugDrawFlag.Shapes | B2DebugDrawFlag.Joints);
			m_world.setDebugDraw(dbgDraw);
			
			// Create border of boxes
			var wall:B2PolygonShape= new B2PolygonShape();
			var wallBd:B2BodyDef = new B2BodyDef();
			var wallB:B2Body;
			
			// Left
			wallBd.position.set( -95 / m_physScale, 360 / m_physScale / 2);
			wall.setAsBox(100/m_physScale, 400/m_physScale/2);
			wallB = m_world.createBody(wallBd);
			wallB.createFixture2(wall);
			// Right
			wallBd.position.set((640 + 95) / m_physScale, 360 / m_physScale / 2);
			wallB = m_world.createBody(wallBd);
			wallB.createFixture2(wall);
			// Top
			wallBd.position.set(640 / m_physScale / 2, -95 / m_physScale);
			wall.setAsBox(680/m_physScale/2, 100/m_physScale);
			wallB = m_world.createBody(wallBd);
			wallB.createFixture2(wall);
			// Bottom
			wallBd.position.set(640 / m_physScale / 2, (360 + 95) / m_physScale);
			wallB = m_world.createBody(wallBd);
			wallB.createFixture2(wall);
		}
		
		
		public function Update():Void {
			// Update mouse joint
			UpdateMouseWorld();
			MouseDestroy();
			MouseDrag();
			
			// Update physics
			m_world.step(m_timeStep, m_velocityIterations, m_positionIterations);
			m_world.clearForces();
			
			// Render
			m_world.drawDebugData();
			// joints
			/*for (var jj:B2Joint = m_world.m_jointList; jj; jj = jj.m_next){
				//DrawJoint(jj);
			}
			// bodies
			for (var bb:B2Body = m_world.m_bodyList; bb; bb = bb.m_next){
				for (var s:B2Shape = bb.GetShapeList(); s != null; s = s.GetNext()){
					//DrawShape(s);
				}
			}*/
			
			//DrawPairs();
			//DrawBounds();
			
		}
		
		
		//======================
		// Member Data 
		//======================
		public var m_world:B2World;
		public var m_bomb:B2Body;
		public var m_mouseJoint:B2MouseJoint;
		public var m_velocityIterations:Int = 10;
		public var m_positionIterations:Int = 10;
		public var m_timeStep:Float = 1.0/30.0;
// 		public var m_physScale:Float = 30;
		// world mouse position
		static public var mouseXWorldPhys:Float;
		static public var mouseYWorldPhys:Float;
		static public var mouseXWorld:Float;
		static public var mouseYWorld:Float;
		
		
		
		//======================
		// Update mouseWorld
		//======================
		public function UpdateMouseWorld():Void{
			mouseXWorldPhys = (Global.mouseX)/m_physScale; 
			mouseYWorldPhys = (Global.mouseY)/m_physScale; 
			
			mouseXWorld = (Global.mouseX); 
			mouseYWorld = (Global.mouseY); 
		}
		
		
		
		//======================
		// Mouse Drag 
		//======================
		public function MouseDrag():Void{
			// mouse press
			if (Global.mouseDown && m_mouseJoint==null){
				
				var body:B2Body = GetBodyAtMouse();
				
				if (body!=null)
				{
					var md:B2MouseJointDef = new B2MouseJointDef();
					md.bodyA = m_world.getGroundBody();
					md.bodyB = body;
					md.target.set(mouseXWorldPhys, mouseYWorldPhys);
					md.collideConnected = true;
					md.maxForce = 300.0 * body.getMass();
					m_mouseJoint = cast(m_world.createJoint(md), B2MouseJoint);
					body.setAwake(true);
				}
			}
			
			
			// mouse release
			if (!Global.mouseDown){
				if (m_mouseJoint!=null)
				{
					m_world.destroyJoint(m_mouseJoint);
					m_mouseJoint = null;
				}
			}
			
			
			// mouse move
			if (m_mouseJoint!=null)
			{
				var p2:B2Vec2 = new B2Vec2(mouseXWorldPhys, mouseYWorldPhys);
				m_mouseJoint.setTarget(p2);
			}
		}
		
		
		
		//======================
		// Mouse Destroy
		//======================
		public function MouseDestroy():Void{
			// mouse press
			if (!Global.mouseDown && Global.keysDown[KeyCode.D]){
				
				var body:B2Body = GetBodyAtMouse(true);
				
				if (body!=null)
				{
					m_world.destroyBody(body);
					return;
				}
			}
		}
		
		
		
		//======================
		// GetBodyAtMouse
		//======================
		private var mousePVec:B2Vec2 = new B2Vec2();
		public function GetBodyAtMouse(includeStatic:Bool = false):B2Body {
			// Make a small box.
			mousePVec.set(mouseXWorldPhys, mouseYWorldPhys);
			var aabb:B2AABB = new B2AABB();
			aabb.lowerBound.set(mouseXWorldPhys - 0.001, mouseYWorldPhys - 0.001);
			aabb.upperBound.set(mouseXWorldPhys + 0.001, mouseYWorldPhys + 0.001);
			var body:B2Body = null;
			var fixture:B2Fixture;
			
			// Query the world for overlapping shapes.
			function GetBodyCallback(fixture:B2Fixture):Bool
			{
				var shape:B2Shape = fixture.getShape();
				if (fixture.getBody().getType() != 0 || includeStatic)
				{
					var inside:Bool = shape.testPoint(fixture.getBody().getTransform(), mousePVec);
					if (inside)
					{
						body = fixture.getBody();
						return false;
					}
				}
				return true;
			}
			m_world.queryAABB(GetBodyCallback, aabb);
			return body;
		}
	}

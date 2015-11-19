package box2D.dynamics;

@:enum abstract B2DebugDrawFlag(UInt) from Int to Int from UInt to UInt {
    var Shapes        = 0x0001; // shapes
    var Joints        = 0x0002; // joint connections
    var AABBs         = 0x0004; // axis aligned bounding boxes
    var Pairs         = 0x0008; // broad-phase pairs
    var CentersOfMass = 0x0010; // center of mass frame
    var Controllers   = 0x0020; // controllers
}

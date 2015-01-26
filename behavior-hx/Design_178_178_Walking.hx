package scripts;

import com.stencyl.graphics.G;

import com.stencyl.behavior.Script;
import com.stencyl.behavior.ActorScript;
import com.stencyl.behavior.SceneScript;
import com.stencyl.behavior.TimedTask;

import com.stencyl.models.Actor;
import com.stencyl.models.GameModel;
import com.stencyl.models.actor.Animation;
import com.stencyl.models.actor.ActorType;
import com.stencyl.models.actor.Collision;
import com.stencyl.models.actor.Group;
import com.stencyl.models.Scene;
import com.stencyl.models.Sound;
import com.stencyl.models.Region;
import com.stencyl.models.Font;

import com.stencyl.Engine;
import com.stencyl.Input;
import com.stencyl.utils.Utils;

import nme.ui.Mouse;
import nme.display.Graphics;
import nme.display.BlendMode;
import nme.events.Event;
import nme.events.TouchEvent;
import nme.net.URLLoader;

import motion.Actuate;
import motion.easing.Back;
import motion.easing.Cubic;
import motion.easing.Elastic;
import motion.easing.Expo;
import motion.easing.Linear;
import motion.easing.Quad;
import motion.easing.Quart;
import motion.easing.Quint;
import motion.easing.Sine;



class Design_178_178_Walking extends ActorScript
{          	
	
public var _MoveRightKey:String;

public var _MoveLeftKey:String;

public var _Acceleration:Float;

public var _MaxWalkingSpeed:Float;

public var _LimitSpeed:Bool;

public var _WalkRightAnimation:String;

public var _WalkLeftAnimation:String;

public var _IdleRightAnimation:String;

public var _IdleLeftAnimation:String;

public var _PreventWalking:Bool;

public var _DisableStatuses:Array<Dynamic>;

public var _AnimationCategory:String;
    

/* Params are:__Self */
public function _customBlock_AtMaxWalkingSpeed():Bool
{
var __Self:Actor = actor;
        if((asBoolean(actor.getActorValue("Facing Right?")) && (actor.getXVelocity() >= _MaxWalkingSpeed)))
{
            if(_LimitSpeed)
{
                actor.setXVelocity(_MaxWalkingSpeed);
}

            return true;
}

        if((!(asBoolean(actor.getActorValue("Facing Right?"))) && (actor.getXVelocity() <= -(_MaxWalkingSpeed))))
{
            if(_LimitSpeed)
{
                actor.setXVelocity(-(_MaxWalkingSpeed));
}

            return true;
}

        return false;
}
    

/* Params are:__Self __Accel */
public function _customBlock_WalkAccel(__Accel:Float):Void
{
var __Self:Actor = actor;
        _Acceleration = asNumber(__Accel);
propertyChanged("_Acceleration", _Acceleration);
}
    

/* Params are:__Self */
public function _customBlock_GetWalkAccel():Float
{
var __Self:Actor = actor;
        return _Acceleration;
}
    

/* Params are:__Self __MaxSpeed */
public function _customBlock_MaxWalkSpeed(__MaxSpeed:Float):Void
{
var __Self:Actor = actor;
        _MaxWalkingSpeed = asNumber(__MaxSpeed);
propertyChanged("_MaxWalkingSpeed", _MaxWalkingSpeed);
}
    

/* Params are:__Self */
public function _customBlock_GetMaxWalkSpeed():Float
{
var __Self:Actor = actor;
        return _MaxWalkingSpeed;
}
    

/* Params are:__Self __Prevent */
public function _customBlock_PreventWalk(__Prevent:Bool):Void
{
var __Self:Actor = actor;
        _PreventWalking = __Prevent;
propertyChanged("_PreventWalking", _PreventWalking);
}
    

/* Params are:__Self __Limit */
public function _customBlock_LimitSpeed(__Limit:Bool):Void
{
var __Self:Actor = actor;
        _LimitSpeed = __Limit;
propertyChanged("_LimitSpeed", _LimitSpeed);
}
    

/* Params are:__Self __Rate */
public function _customBlock_SlowToMax(__Rate:Float):Void
{
var __Self:Actor = actor;
        if((Math.abs(__Self.getXVelocity()) > _MaxWalkingSpeed))
{
            actor.setXVelocity((actor.getXVelocity() * __Rate));
}

}

 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Move Right Key", "_MoveRightKey");
nameMap.set("Move Left Key", "_MoveLeftKey");
nameMap.set("Acceleration", "_Acceleration");
_Acceleration = 85.0;
nameMap.set("Max Walking Speed", "_MaxWalkingSpeed");
_MaxWalkingSpeed = 20.0;
nameMap.set("Limit Speed?", "_LimitSpeed");
_LimitSpeed = false;
nameMap.set("Walk Right Animation", "_WalkRightAnimation");
nameMap.set("Walk Left Animation", "_WalkLeftAnimation");
nameMap.set("Idle Right Animation", "_IdleRightAnimation");
nameMap.set("Idle Left Animation", "_IdleLeftAnimation");
nameMap.set("Prevent Walking?", "_PreventWalking");
_PreventWalking = false;
nameMap.set("Disable Statuses", "_DisableStatuses");
_DisableStatuses = [];
nameMap.set("Animation Category", "_AnimationCategory");
_AnimationCategory = "Walking";
nameMap.set("Actor", "actor");

	}
	
	override public function init()
	{
		            /* "Inputs: ----------------------" */
        /* "\"On Ground?\" -- <Boolean> Actor Level Attribute, from \"On Ground\" Behavior (required)" */
        /* "\"Is Running?\" -- <Boolean> Actor Level Attribute, from \"Jumping\" Behavior (NOT required)" */
        /* "\"Is Ducking?\" -- <Boolean> Actor Level Attribute, from \"Ducking\" Behavior (NOT required)" */
        /* "\"Is Slope Sliding?\" -- <Boolean> Actor Level Attribute, from \"Slope Detection\" Behavior (NOT required)" */
        /* "Outputs: ---------------------" */
        /* "\"Facing Right?\" -- <Boolean> Actor Level Attribute" */
        actor.setActorValue("Facing Right?", true);
    addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void {
if(wrapper.enabled){
        for(item in cast(_DisableStatuses, Array<Dynamic>))
{
            if(asBoolean(actor.getActorValue(("" + item))))
{
                return;
}

}

        if(_PreventWalking)
{
            return;
}

        if((isKeyDown(_MoveRightKey) && !(isKeyDown(_MoveLeftKey))))
{
            actor.setActorValue("Facing Right?", true);
            if(asBoolean(actor.getActorValue("On Ground?")))
{
                actor.say("Animation Manager", "_customBlock_LoopAnim", [_WalkRightAnimation,_AnimationCategory]);
}

            if(cast((actor.say("Walking", "_customBlock_AtMaxWalkingSpeed")), Bool))
{
                return;
}

            actor.push(1, 0, _Acceleration);
}

        if((isKeyDown(_MoveLeftKey) && !(isKeyDown(_MoveRightKey))))
{
            actor.setActorValue("Facing Right?", false);
            if(asBoolean(actor.getActorValue("On Ground?")))
{
                actor.say("Animation Manager", "_customBlock_LoopAnim", [_WalkLeftAnimation,_AnimationCategory]);
}

            if(cast((actor.say("Walking", "_customBlock_AtMaxWalkingSpeed")), Bool))
{
                return;
}

            actor.push(-1, 0, _Acceleration);
}

        if((!(isKeyDown(_MoveRightKey)) && !(isKeyDown(_MoveLeftKey))))
{
            if(asBoolean(actor.getActorValue("On Ground?")))
{
                if(asBoolean(actor.getActorValue("Facing Right?")))
{
                    actor.say("Animation Manager", "_customBlock_LoopAnim", [_IdleRightAnimation,_AnimationCategory]);
}

                else
{
                    actor.say("Animation Manager", "_customBlock_LoopAnim", [_IdleLeftAnimation,_AnimationCategory]);
}

}

}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}
package scripts;

import com.stencyl.graphics.G;
import com.stencyl.graphics.BitmapWrapper;

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
import com.stencyl.Key;
import com.stencyl.utils.Utils;

import nme.ui.Mouse;
import nme.display.Graphics;
import nme.display.BlendMode;
import nme.display.BitmapData;
import nme.display.Bitmap;
import nme.events.Event;
import nme.events.KeyboardEvent;
import nme.events.TouchEvent;
import nme.net.URLLoader;

import box2D.common.math.B2Vec2;
import box2D.dynamics.B2Body;
import box2D.dynamics.B2Fixture;
import box2D.dynamics.joints.B2Joint;

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

import com.stencyl.graphics.shaders.BasicShader;
import com.stencyl.graphics.shaders.GrayscaleShader;
import com.stencyl.graphics.shaders.SepiaShader;
import com.stencyl.graphics.shaders.InvertShader;
import com.stencyl.graphics.shaders.GrainShader;
import com.stencyl.graphics.shaders.ExternalShader;
import com.stencyl.graphics.shaders.InlineShader;
import com.stencyl.graphics.shaders.BlurShader;
import com.stencyl.graphics.shaders.SharpenShader;
import com.stencyl.graphics.shaders.ScanlineShader;
import com.stencyl.graphics.shaders.CSBShader;
import com.stencyl.graphics.shaders.HueShader;
import com.stencyl.graphics.shaders.TintShader;
import com.stencyl.graphics.shaders.BloomShader;



class Design_233_233_Patrol extends ActorScript
{          	
	
public var speed:Float;

public var leftanim:String;

public var rightanim:String;

public var dir:Float;
    public function _customEvent_left_to_right():Void
{
        actor.setXVelocity(speed);
        actor.setAnimation("" + rightanim);
}

    public function _customEvent_right_to_left():Void
{
        actor.setXVelocity(-(speed));
        actor.setAnimation("" + leftanim);
}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Actor", "actor");
nameMap.set("Walking Speed", "speed");
speed = 1.0;
nameMap.set("Left Animation", "leftanim");
nameMap.set("Right Animation", "rightanim");
nameMap.set("Initial Direction", "dir");
dir = -1.0;

	}
	
	override public function init()
	{
		    
/* ======================== When Creating ========================= */
        if((dir == 1))
{
            _customEvent_left_to_right();
}

        else
{
            _customEvent_right_to_left();
}

    
/* ======================== Something Else ======================== */
addCollisionListener(actor, function(event:Collision, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if(event.thisFromLeft)
{
            _customEvent_left_to_right();
}

        if(event.thisFromRight)
{
            _customEvent_right_to_left();
}

}
});
    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if((actor.getXVelocity() >= 0))
{
            actor.setXVelocity(speed);
}

        else
{
            actor.setXVelocity(-(speed));
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}
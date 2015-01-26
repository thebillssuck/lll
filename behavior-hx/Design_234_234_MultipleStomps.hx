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



class Design_234_234_MultipleStomps extends ActorScript
{          	
	
public var _alreadyCollided:Bool;

public var _JumpKey:String;

public var _PushPlayerForce:Float;

public var _PushPlayerJumpForce:Float;

public var _StompedAnimation:String;

public var _StompedSound:Sound;

public var _HP:Float;

public var _WalkingRight:String;

public var _WalkingLeft:String;
    public function _customEvent_stomped():Void
{
        if(!(asBoolean(actor.getActorValue("_BeingStomped"))))
{
            playSound(_StompedSound);
            actor.setActorValue("_BeingStomped", true);
            actor.setAnimation("" + _StompedAnimation);
            if((actor.getXVelocity() > 0))
{
                runLater(1000 * 0.2, function(timeTask:TimedTask):Void {
                            actor.setVelocity(0, 5);
                            actor.setAnimation("" + _WalkingRight);
}, actor);
}

}

        if((actor.getXVelocity() < 0))
{
            runLater(1000 * 0.2, function(timeTask:TimedTask):Void {
                        actor.setVelocity(180, 5);
                        actor.setAnimation("" + _WalkingLeft);
}, actor);
}

        actor.setXVelocity(0);
        actor.setActorValue("_DisallowMovement", true);
        runLater(1000 * 0.2, function(timeTask:TimedTask):Void {
                    _HP -= 1;
propertyChanged("_HP", _HP);
                    actor.setActorValue("_DisallowMovement", false);
                    actor.setActorValue("_BeingStomped", false);
}, actor);
}


 
 	public function new(dummy:Int, actor:Actor, engine:Engine)
	{
		super(actor, engine);	
		nameMap.set("Actor", "actor");
nameMap.set("alreadyCollided?", "_alreadyCollided");
_alreadyCollided = false;
nameMap.set("Jump Key", "_JumpKey");
nameMap.set("Push Player Force", "_PushPlayerForce");
_PushPlayerForce = 0.0;
nameMap.set("Push Player Jump Force", "_PushPlayerJumpForce");
_PushPlayerJumpForce = 0.0;
nameMap.set("Stomped Animation", "_StompedAnimation");
nameMap.set("Stomped Sound", "_StompedSound");
nameMap.set("HP", "_HP");
_HP = 0.0;
nameMap.set("Walking Right", "_WalkingRight");
nameMap.set("Walking Left", "_WalkingLeft");

	}
	
	override public function init()
	{
		    
/* ======================== When Updating ========================= */
addWhenUpdatedListener(null, function(elapsedTime:Float, list:Array<Dynamic>):Void
{
if(wrapper.enabled)
{
        if((_HP == 0))
{
            recycleActor(actor);
}

}
});

	}	      	
	
	override public function forwardMessage(msg:String)
	{
		
	}
}
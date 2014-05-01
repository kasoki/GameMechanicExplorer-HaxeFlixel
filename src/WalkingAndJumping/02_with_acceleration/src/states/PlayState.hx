// This simple example uses HaxeFlixel

// Copyright © 2014 John Watson (Example in JS and Assets)
// Copyright © 2014 Christopher Kaster (Port to HaxeFlixel)
// Licensed under the terms of the MIT License

package states;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.group.FlxGroup;

class PlayState extends FlxState {

	private var player:FlxSprite;
	private var ground:FlxGroup;
	
	// define movement constants
	private var MAX_SPEED:Int = 250;
	private var ACCELERATION:Int = 600;
	
	// setup the example
	public override function create():Void {
		super.create();
		
		// Set stage background to something sky colored
		FlxG.cameras.bgColor = 0xFF4488CC; // ARGB
		
		// create the player
		player = new FlxSprite();
		player.loadGraphic("assets/player.png");
		
		player.x = FlxG.width / 2;
		player.y = FlxG.height - 64;
		
		// set player maximum movement speed
		player.maxVelocity.x = this.MAX_SPEED;
		
		// create the ground
		ground = new FlxGroup();
		
		for(i in 0...Std.int(FlxG.width / 32)) {
			var x = i * 32;
			
			// create new ground block
			var groundBlock = new FlxSprite(x, FlxG.height - 32);
			groundBlock.loadGraphic("assets/ground.png");
			
			// make the block immovable
			groundBlock.immovable = true;
			
			// add ground block to ground group
			ground.add(groundBlock);
		}
		
		// add ground group and player to the stage
		this.add(ground);
		this.add(player);
	}
	
	public override function destroy():Void {
		super.destroy();
	}

	// update() method is called every frame
	public override function update():Void {
		super.update();
		
		if(FlxG.keys.anyPressed(["LEFT"])) {
			// If the LEFT key is down, set the players velocity to move left
			player.acceleration.x = -this.ACCELERATION;
		} else if(FlxG.keys.anyPressed(["RIGHT"])) {
			// If the RIGHT key is down, set the players velocity to move right
			player.acceleration.x = this.ACCELERATION;
		} else {
			// Stop the player from moving horizontally
			player.velocity.x = 0;
			player.acceleration.x = 0;
		}
		
		// Collide the player with the ground
		FlxG.collide(player, ground);
	}	
}
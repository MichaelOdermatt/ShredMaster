extends Node2D

@onready var globals = get_node("/root/Globals");
@onready var impactParticles = $ImpactParticles;
@onready var sparkParticles = $SparkParticles;
@onready var cloudParticles = $CloudParticles;

var impactParticleEffectOffsetY: float = 8;
var sparkParticleEffectOffsetY: float = 7;

func _process(delta):
	updateParticleVelocity();

## Emits the cloud particle effect.
func emitCloudParticles(emitPosition: Vector2):
	cloudParticles.restart();
	cloudParticles.transform.origin = emitPosition;
	cloudParticles.emitting = true;

## Emits the impact particle effect.
func emitImpactParticles(emitPosition: Vector2):
	impactParticles.restart();
	impactParticles.transform.origin = emitPosition;
	impactParticles.transform.origin.y += impactParticleEffectOffsetY;
	impactParticles.emitting = true;

## Starts emitting the spark particle effect at the given position.
func startEmittingSparkParticles(emitPosition: Vector2):
	sparkParticles.transform.origin = emitPosition;
	sparkParticles.transform.origin.y += sparkParticleEffectOffsetY;
	sparkParticles.emitting = true;

## Stops emitting the spark particle effect.
func stopEmittingSparkParticles():
	sparkParticles.emitting = false;

## Updates the velocity of all particle effects to match the global current base speed.
func updateParticleVelocity():
	impactParticles.material.set('initial_velocity_min', -globals.currentBaseSpeed);
	impactParticles.material.set('initial_velocity_max', -globals.currentBaseSpeed);
	cloudParticles.material.set('initial_velocity_min', -globals.currentBaseSpeed);
	cloudParticles.material.set('initial_velocity_max', -globals.currentBaseSpeed);
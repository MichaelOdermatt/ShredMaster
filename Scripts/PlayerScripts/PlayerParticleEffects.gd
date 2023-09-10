extends Node2D

const cloudParticlesResource = preload("res://Scenes/ParticleEffectScenes/CloudParticles.tscn");
const impactParticleEffectOffsetY: float = 8;
const sparkParticleEffectOffsetY: float = 7;

@onready var rootNode = get_node("/root");
@onready var globals = get_node("/root/Globals");
@onready var impactParticles = $ImpactParticles;
@onready var sparkParticles = $SparkParticles;

func _process(delta):
	updateParticleVelocity();

## Creates an instance of the cloud particle effect scene and emits the effect.
func CreateInstanceAndEmitCloudParticles(emitPosition: Vector2):
	var cloudParticles = cloudParticlesResource.instantiate();
	rootNode.add_child(cloudParticles);
	cloudParticles.material.set('initial_velocity_min', -globals.currentBaseSpeed);
	cloudParticles.material.set('initial_velocity_max', -globals.currentBaseSpeed);
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

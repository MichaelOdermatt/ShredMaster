extends Node2D

@onready var globals = get_node("/root/Globals");
@onready var impactParticles = $ImpactParticles;

var particleEffectOffsetY: float = 8;

func _process(delta):
	updateParticleVelocity();

## Emits the cloud particle effect.
func emitImpactParticles(emitPosition: Vector2):
	impactParticles.restart();
	impactParticles.transform.origin = emitPosition;
	impactParticles.transform.origin.y += particleEffectOffsetY;
	impactParticles.emitting = true;

## Updates the velocity of all particle effects to match the global current base speed.
func updateParticleVelocity():
	impactParticles.material.set('initial_velocity_min', -globals.currentBaseSpeed);
	impactParticles.material.set('initial_velocity_max', -globals.currentBaseSpeed);

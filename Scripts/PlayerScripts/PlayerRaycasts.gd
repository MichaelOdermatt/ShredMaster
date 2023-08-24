extends Node2D

@onready var railRaycast = $RailRayCast;
@onready var railRaycast2 = $RailRayCast2;
@onready var playerCharacterBody = get_node("..");

## Returns true if the player is colliding with a rail object. Otherwise returns false.
func isPlayerGrindingRail() -> bool:
	var isRearRaycastHittingRail = isRaycastHittingRail(railRaycast);
	var isFrontRaycastHittingRail = isRaycastHittingRail(railRaycast2);
	# return true if either of the raycasts are hitting the rail and if the player is not moving upwards
	return (isRearRaycastHittingRail || isFrontRaycastHittingRail) && playerCharacterBody.velocity.y >= 0;

## Returns true if the given raycast is colliding with an object of type Rail.
func isRaycastHittingRail(rayCast: RayCast2D) -> bool:
	if (!rayCast.is_colliding()):
		return false;
	
	var collider = rayCast.get_collider();
	var colliderType = collider.get_type() if collider.has_method("get_type") else null;

	if (colliderType == "Rail"):
		return true;

	return false;
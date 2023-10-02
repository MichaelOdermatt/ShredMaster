extends Node

## The base speed is the speed at which all seemingly stationary objects move.

const MIN_BASE_SPEED: int = 55;
const MAX_BASE_SPEED: int = 100;

## The max and min speed that basic enemies move.

const MIN_BASIC_ENEMY_SPEED: int = 30;
const MAX_BASIC_ENEMY_SPEED: int = 75;

## The max and min speed that flying enemies move.

const MIN_FLYING_ENEMY_SPEED: int = 65;
const MAX_FLYING_ENEMY_SPEED: int = 110;

const MIN_BASIC_ENEMY_SPAWN_INTERVAL: Vector2 = Vector2(3, 5);
const MAX_BASIC_ENEMY_SPAWN_INTERVAL: Vector2 = Vector2(4, 8);

const MIN_STATIONARY_ENEMY_SPAWN_INTERVAL: Vector2 = Vector2(2, 8);
const MAX_STATIONARY_ENEMY_SPAWN_INTERVAL: Vector2 = Vector2(4, 10);

const MIN_FLYING_ENEMY_SPAWN_INTERVAL: Vector2 = Vector2(2, 5);
const MAX_FLYING_ENEMY_SPAWN_INTERVAL: Vector2 = Vector2(3, 6);

## The speeds at which each object is currently moving.

var currentBaseSpeed: int = MIN_BASE_SPEED;
var basicEnemySpeed: int = MIN_BASIC_ENEMY_SPEED;
var flyingEnemySpeed: int = MIN_FLYING_ENEMY_SPEED;

## The current spawn intervals that are being used.

var basicEnemySpawnInterval: Vector2 = MAX_BASIC_ENEMY_SPAWN_INTERVAL;
var stationaryEnemySpawnInterval: Vector2 = MAX_STATIONARY_ENEMY_SPAWN_INTERVAL;
var flyingEnemySpawnInterval: Vector2 = MAX_FLYING_ENEMY_SPAWN_INTERVAL;

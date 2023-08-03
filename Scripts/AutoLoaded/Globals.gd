extends Node

## The base speed is the speed at which all seemingly stationary objects move.

const MIN_BASE_SPEED: int = 55;
const MAX_BASE_SPEED: int = 90;

## The max and min speed that basic enemies move.

const MIN_BASIC_ENEMY_SPEED: int = 50;
const MAX_BASIC_ENEMY_SPEED: int = 85;

## The max and min speed that flying enemies move.

const MIN_FLYING_ENEMY_SPEED: int = 65;
const MAX_FLYING_ENEMY_SPEED: int = 100;

## The speeds at which each object is currently moving.

var railSpeed: int = MIN_BASE_SPEED;
var coinSpeed: int = MIN_BASE_SPEED;
var basicEnemySpeed: int = MIN_BASIC_ENEMY_SPEED;
var flyingEnemySpeed: int = MIN_FLYING_ENEMY_SPEED;
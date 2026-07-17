extends Node

enum Skills {
	UNDEFINED,
	BELLS,
	KITTENS,
	CANDLES,
	FLOWERS,
	RAIN
}

enum ResultTypes{
	POSITIVE, 
	NEUTRAL,
	NEGATIVE
}


enum ItemTypes{
	UNDEFINED,
	MONEY,
	FISH,
	GOSSIP,
	MILK,
	TEA,
	CINNAMON,
	OIL,
	BLOSSOMS,
	PUMPKINS_MAGIC_STICK
}


enum DieActionOutcomeTypes {
	BAD,
	NEUTRAL,
	GOOD,
}

enum GameMode {
	GAME,
	MENU
}


enum GameplayMode {
	MAINMENU,
	MAP,
	LOCATION,
	NARRATIVE,
	CONVERSATION, # currently unused
	CAMERA_MOVEMENT
}

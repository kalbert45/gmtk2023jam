extends Node

# enums everything. used for recipes
enum OBJECTS {COFFEE_BEAN, BREAD, TOMATO, LETTUCE, CUCUMBER, PLATE, CUP, KNIFE, KEURIG}

# enums for functionality
enum OBJECT_TYPES {INGREDIENT, PLATE, TOOL, DEVICE}
enum INGREDIENTS {COFFEE_BEAN, BREAD, TOMATO, LETTUCE, CUCUMBER}
enum PLATES {PLATE, CUP}
enum TOOLS {KNIFE}
enum DEVICES {KEURIG}

# enum to change object states
enum OBJECT_STATES {BREWED, CHOPPED, BREWING, DEFAULT, SANDWICH_BREAD, IN_WASHER_DIRTY, IN_WASHER_CLEAN, DIRTY}

# enum for player actions
enum PLAYER_ACTIONS {CHOP, BREW, PLACE, PICK_UP, NOTHING}

# enum for various recipes
enum RECIPES {COFFEE, SANDWICH, SALAD}

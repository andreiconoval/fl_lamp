library globals.constants;

const DEFAULT_LAMP_PORT = 8888;

enum COMMANDS {
  DEB,
  GET,
  EFF,
  BRI,
  SPD,
  SCA,
  P_ON,
  P_OFF,
  ALM_SET,
  ALM_GET,
  DAWN,
  DISCOVER,
  TMR_GET,
  TMR_SET,
  FAV_GET,
  FAV_SET,
  OTA,
  BTN,
}

String commandToString(COMMANDS command) {
  return command.toString().substring(command.toString().indexOf('.') + 1);
}

const EFFECTS = [
  "SPARKLES",
  "FIRE",
  "WHITTE_FIRE",
  "RAINBOW_VER",
  "RAINBOW_HOR",
  "RAINBOW_DIAG",
  "COLORS",
  "MADNESS",
  "CLOUDS",
  "LAVA",
  "PLASMA",
  "RAINBOW",
  "RAINBOW_STRIPE",
  "ZEBRA",
  "FOREST",
  "OCEAN",
  "COLOR",
  "SNOW",
  "SNOWSTORM",
  "STARFALL",
  "MATRIX",
  "LIGHTERS",
  "LIGHTER_TRACES",
  "PAINTBALL",
  "CUBE",
  "WHITE_COLOR",
];

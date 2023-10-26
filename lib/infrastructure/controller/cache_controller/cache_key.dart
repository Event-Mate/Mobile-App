enum CacheKey {
  //* BOOL
  LOGGED_IN("logged_in"),

  //* INT
  COLOR_THEME("color_theme");

  const CacheKey(this.value);
  final String value;
}

enum CacheKey {
  //* BOOL

  //* INT
  COLOR_THEME("color_theme"),

  //* STRING
  ACCESS_TOKEN("access_token");

  const CacheKey(this.value);
  final String value;
}

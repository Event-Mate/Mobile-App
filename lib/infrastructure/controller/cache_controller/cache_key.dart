enum CacheKey {
  //* BOOL
  UID("event_mate_user_id123"),

  //* INT
  COLOR_THEME("color_theme"),

  //* STRING
  ACCESS_TOKEN("access_token");

  const CacheKey(this.value);
  final String value;
}

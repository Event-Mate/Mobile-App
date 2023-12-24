enum CacheKey {
  //* BOOL
  UID("event_mate_user_id2324"),

  //* INT
  COLOR_THEME("color_theme"),

  //* STRING
  ACCESS_TOKEN("access_token");

  const CacheKey(this.value);
  final String value;
}

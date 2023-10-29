enum CacheKey {
  //* BOOL
  UID("event_mate_user_id"),

  //* INT
  COLOR_THEME("color_theme");

  const CacheKey(this.value);
  final String value;
}

# Bodacious Sources

Valid fields for sources:
* Track, artist, album names, track #, disc # `metadataSource`
* Cover art `coverSource`
* Descriptions `descriptionSource`
* Audio `source` (on tracks only)
* Release dates or years `releaseDateSource` (on albums and tracks only)

Known sources:
* `manual` (Custom): A field is edited manually. NOT applicable to Audio `source`.
* `local` (Local File): A file was found on the local file system. ONLY applicable to Audio `source`.
* `inferred` (Inferred from Context): A field was inferred from context. When `metadataSource` field is set to this value Last.fm will not scrobble them by default, and an icon will display next to the track name on the Now Playing screen to indicate this. ONLY applicable to `metadataSource`.
* `ripped`: A file was ripped from a CD. ONLY applicable to Audio `source`.
* `spotify`: A field or track is sourced from Spotify. For Audio `source`, this means the track is to be played on Spotify using its `uri` or `spotifyId`. Applicable to all fields.
* `lastfm`: A field is sourced from Last.fm. NOT applicable to Audio `source`.
* `genius`: A field is sourced from Genius.  NOT applicable to Audio `source`.
* `youtube`: A field or track is sourced from Genius. For Audio `source`, this means the track is to be played on Spotify using its `uri`. Applicable to all fields.
* `album` (Same as album): A field is sourced from its album. This is the track's assigned `album`, and so it's only applicable to `coverSource` and `releaseDateSource` on tracks with albums.
* `playlist`: A track or field is sourced from a playlist.
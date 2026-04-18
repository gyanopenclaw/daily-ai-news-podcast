#!/bin/bash
# Usage: ./publish.sh <title> <audio_url> <description> [date]
set -e
TITLE="$1"
AUDIO_URL="$2"
DESC="$3"
DATE="${4:-$(date -R)}"
GUID=$(uuidgen | tr '[:upper:]' '[:lower:]')

EPISODE="    <item>
      <title>${TITLE}</title>
      <description><![CDATA[${DESC}]]></description>
      <enclosure url=\"${AUDIO_URL}\" type=\"audio/x-m4a\"/>
      <guid isPermaLink=\"false\">${GUID}</guid>
      <pubDate>${DATE}</pubDate>
      <itunes:duration>00:05:00</itunes:duration>
      <itunes:explicit>false</itunes:explicit>
    </item>"

# Insert episode after EPISODES_START marker
sed -i '' "/<!-- EPISODES_START -->/a\\
${EPISODE}
" feed.xml

echo "Added episode: ${TITLE}"

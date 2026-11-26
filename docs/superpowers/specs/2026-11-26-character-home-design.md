# Character home redesign

The supplied mockup guides the Flutter home screen: cream canvas, plum outlines and shadows, pink welcome panel, four colorful animal cards, and a rounded dark navigation bar. Improve spacing and typography while preserving existing skill routes, tab state and accessibility.

Approach: adapt the existing Flutter widgets. A literal copy would depend on unfinished character assets; a broader app rebuild would exceed this visual change. Use temporary emoji artwork through CharacterAvatar with an optional assetPath for later replacement. Show actual catalog counts and coming-soon status instead of invented activity statistics.

Keep all content scrollable, allow enlarged text to wrap, and retain keyboard activation and reduced motion through AppPressable. No dependencies or network images are required.

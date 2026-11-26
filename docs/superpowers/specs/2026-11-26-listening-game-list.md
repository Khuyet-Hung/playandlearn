# Listening game list

Implement the user's supplied screen in the existing Flutter app for Chuột Nghe Lén only. Open it through the existing listening skill detail route from home and the skills catalog. Other skills retain their existing screens.

Use the generated transparent mouse with purple headphones in the greeting header. Include a back button, blue Luyện nghe title, zero-day streak indicator, speech bubble, character title, two mock games and headphone footer. Match the cream, plum, blue, yellow and lavender reference palette. Game cards show the supplied names, descriptions, difficulty and duration. Their banners use simple colored icon placeholders; the user explicitly postponed game artwork until gameplay implementation. Tapping either card explains that the game is coming soon.

## Approach

Build native responsive Flutter widgets using existing theme and AppPressable. This preserves keyboard, accessibility and motion support and gives responsive text. A flattened screenshot cannot provide those behaviors. No gameplay, backend, network fonts or new dependencies are needed.

Preserve Vietnamese text, scrolling, readable enlarged text and the existing navigation guard. Keep the image locally bundled with no runtime network request.

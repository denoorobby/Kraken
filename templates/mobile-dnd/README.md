Template name: mobile-dnd
Type: iOS-Friendly
Description: A drag-and-drop interface that desktop and iOS both like.

Dependencies:

- jQuery
- Bootstrap
- [Hammer.js](http://eightmedia.github.com/hammer.js/)

Limitations:

- javascript
- Touch events per Hammer.js

overview:

- two `.windows`, each containing a `.container`
- `.container`s contain `.draggable`s
- `.draggable` can be picked up with a hold event of N ms
- `.container` can be scrolled if `.draggable` isn't picked up
- `.draggable` snaps:
    - it's easiest to implement the `.container`s similarly to each other, so shit doesn't get real
    - when a `.draggable` is held over another `.draggable`, the latter moves out of the way.
    - essentially when hold-drag happens we insert a `.draggable-insert`
    - the `.draggable-insert` will "snap" to the grid of `.draggable`s such that its center is closest to the center of the currently-held `.draggable`
    - when a `.draggable` is dropped, the `.draggable-insert` disappears
- we'll have to tie into the `drop` event so we can autosave menus
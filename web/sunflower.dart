// Copyright (c) 2012, the Dart project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

library sunflower;

import 'dart:html';
import 'dart:math';

const String ORANGE = "orange";
const String WHITE = "white";
const String BLACK = "black";
const int SEED_RADIUS = 4;
const int SCALE_FACTOR = 4;
const num TAU = PI * 2;

num centerX = window.innerWidth / 2;
num centerY = window.innerHeight / 2;

final InputElement slider = querySelector("#slider");
final Element notes = querySelector("#notes");
final num PHI = (sqrt(5) + 1) / 2;
int width =  window.innerWidth;
int height =  window.innerHeight;
int seeds = 0;

final CanvasElement canvas = querySelector("#canvas");

final CanvasRenderingContext2D context =
  (querySelector("#canvas") as CanvasElement).context2D;

void main() {
  canvas.width = width;
  canvas.height = height;
  window.onResize.listen((_) {
       resize();
       draw();
     });
  slider.onInput.listen((e) => draw());
  draw();
}

/// Draw the complete figure for the current number of seeds.
void draw([int seedsCount]) {
  if (seedsCount == null)
    {seeds = int.parse(slider.value);}
    else {seeds = seedsCount;}
  context.clearRect(0, 0, width, height);
  for (var i = 0; i < seeds; i++) {
    final num theta = i * TAU / PHI;
    final num r = sqrt(i) * SCALE_FACTOR;
    drawSeed(centerX + r * cos(theta), centerY - r * sin(theta));
  }
  notes.text = "${seeds} seeds.";
}

/// Draw a small circle representing a seed centered at (x,y).
void drawSeed(num x, num y) {
  context..beginPath()
         ..lineWidth = 1
         ..fillStyle = WHITE
         ..strokeStyle = BLACK
         ..arc(x, y, SEED_RADIUS, 0, TAU, false)
         ..fill()
         ..closePath()
         ..stroke();
}

void resize() {
    if (window.innerWidth == 0)
      return;
    context.clearRect(0, 0, width, height);
    width = window.innerWidth;
    height = window.innerHeight;
    canvas.width = width;
    canvas.height = height;
    centerX = width / 2;
    centerY = height / 2;
  }

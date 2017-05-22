# Layout Tests
Various layout tests for text and images in various Genero clients.


# Spacer / padding element
The best way I've found so far is a transparent 2 pixel square image, used like this:
```
IMAGE spacer1 : spacer1, IMAGE="spacer", STRETCH=Y, STYLE="noborder";
```
The issue with this is you still need to set the height in the actually grid, just using the HEIGHT attribute on the widget is okay on GDC and GBC but doesn't work right on a GMA.

I did try with TEXTEDIT but the background colour is wrong on GDC & GBC and on GMA it has the underline for a 'field' and on GMI it has a border.
```
TEXTEDIT spacer=FORMONLY.spacer, NOENTRY, SCROLLBARS=NONE, SIZEPOLICY=FIXED, STRETCH=BOTH;
```


## Simple
A simple centered icon with a title below it.

![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_1_simple_gbc.png "Simple GBC")
![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_1_simple_gdc.png "Simple GDC")
![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_1_simple_gma.png "Simple GMA")

## Title
A title area with a logo, title and date. The text should be centered the image to left and the date to the right

![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_2_title_gbc.png "Title GBC")
![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_2_title_gdc.png "Title GDC")
![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_2_title_gma.png "Title GMA")

## Footer
An icon and date to the right of the screen and a title to the left.

![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_3_footer_gbc.png "Footer GBC")
![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_3_footer_gdc.png "Footer GDC")
![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_3_footer_gma2.png "Footer GMA")
![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_3_footer_gma.png "Footer GMA")

## Multi
Various icons and text tests in a a single form. 

![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_4_multi_gbc.png "Mutli GBC")
![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_4_multi_gdc.png "Mutli GDC")
![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_4_multi_gma.png "Mutli GMA")

## Padding 1
Add paddng elements to the form to force buttons to the bottom of the screen.
![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_5_padding_gbc.png "Padding GBC")
![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_5_padding_gdc.png "Padding GDC")
![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_5_padding_gma.png "Padding GMA")

## Padding 2
Pad form with centered items and bottom of the screen.
![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_6_padding_gbc.png "Padding GBC")
![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_6_padding_gdc.png "Padding GDC")
![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_6_padding_gma.png "Padding GMA")

## Image Sizing 1
7 Image Sizing tests.
![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_7_sizing_gbc.png "Image Sizing")
![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_7_sizing_gdc.png "Image Sizing")
![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_7_sizing_gma.png "Image Sizing")

## Image Centered
Centering an image in the current window/page/screen
![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_8_center_gbc.png "Image Center")
![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_8_center_gdc.png "Image Center")
![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_8_center_gma.png "Image Center")


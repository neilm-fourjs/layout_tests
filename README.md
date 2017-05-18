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

## Right
An icon and date to the right of the screen and a title to the left.

![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_3_right_gbc.png "Right GBC")
![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_3_right_gdc.png "Right GDC")
![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_3_right_gma2.png "Right GMA")
![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_3_right_gma.png "Right GMA")

## Multi
Various icons and text tests in a a single form. 

![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_4_multi_gbc.png "Mutli GBC")
![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_4_multi_gdc.png "Mutli GDC")
![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_4_multi_gma2.png "Mutli GMA")
![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_4_multi_gma.png "Mutli GMA")

## Padding
Add paddng elements to the form to force buttons to the bottom of the screen.
![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_5_padding_gbc.png "Padding GBC")
![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_5_padding_gdc.png "Padding GDC")
![scr1](https://github.com/neilm-fourjs/layout_tests/raw/master/screenshots/layouts_5_padding_gma.png "Padding GMA")

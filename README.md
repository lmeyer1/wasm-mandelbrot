# wasm-mandelbrot

## Build
When using shared memory, use `wat2wasm file.wat -o file.wasm --enable-threads`

## Architecture

### Images in memory

There are two arrays, one represents the image that is displayed, one is a square grid
containing the image. It has a size of 2^n, at least 2d-1 (where d is the diameter of the image in pixels).
The image can be moved, turned and zoomed smoothly, while the grid is always aligned to the axes
of the complex numbers, with zoom steps of 2.

The image array is a UInt32 array, and stores the color of a pixel at index i, where

    i = y * width + x

x and y being 0 indexed coordinates of the image, x left to right and y top down.

The grid array is a UInt16 array, it stores the iteration count of a point. The iterations
are encoded as :
- 0 : not determined
- 1 to n : iteration count
- n + 1 : more than max iterations

This encoding allows for skipping known values and later recalculation if max iteration is
increased.

The index of the grid is calculated in a special manner such that
- moving is changing the offset
- zooming is setting pixels to 0
- never existing data has to be copied

To translate x and y coordinates to the index, we need three parameters: x offset `dx`, y offset `dy` and
zoom factor `z`. The zoom factor is in steps of 2. Zooming 2x is factor 1, zooming 4x is factor 2, etc.
With zoom factor 0, the index is calculated as :

    i = (y + dy) * width + x + dx



### Calculation of the grid
The pixels are calculated in a special order: instead of advancing in the array 1 by 1,
we advance by p, where p is the next prime number to the smaller golden fraction.

| side x | (2-phi) * x^2 | closest prime number |
|--------|---------------|----------------------|
| 1024   | 400520        | 400523               |
| 2048   | 1602081       | 1602079              |
| 4096   | 6408326       | 6408323              |
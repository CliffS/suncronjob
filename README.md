[cron]: https://www.npmjs.com/package/cron

# suncronjob

This is a version of the [cron][cron] library that
is based around sunrise and sunset rather than a fixed
time of day.

## Instalation

    npm install suncronjob


## Example

```javascript
SunCronJob = require('suncronjob');

options = {
  latitude: 59.436962,      // Tallinn, Estonia
  longitude: 24.753574,
  hours: 1,             // One hour,
  minutes: 10,          // ten minutes
  seconds: 30,          // and 30 seconds
  offset: 'after',      // after
  riseset: 'sunrise',   // sunrise
  once: false           // every day.
};

const job = new SunCronJob(options);
```

## Usage

### Constructor

```javascript
SunCronJob = require('suncronjob');

const job = new SunCronJob(options);
```

#### Options

**latitude**    *(Default: London, Greenwich)*

**longitude**   *(Default: London, Greenwich)*

These must be set in order for the sunrise and sunset times
to be calculated correctly.  They are expressed as positive
decimals for North and East, negative for South and West.

**hours**       *(Default: zero)*

**minutes**     *(Default: zero)*

**seconds**     *(Default: zero)*

This is the time before or after sunrise or sunset that the
job should run.

**offset**      *(Default: before)*

This must be set to "before" or "after" (or left unset).

**riseset**     *(Default: sunrise)*

This must be set to "sunrise" or "sunset" (or left unset).

**once**        *(Default: false)*

If set to *true*, this job will only run once.

**onTick**      (*Required*)

The function to fire at the specified time.

**onComplete**  (*Optional*)

A function that will fire when the job is complete, when it is stopped.

**start**       *(Default: false)*

Specifies whether to start the job just before exiting the constructor.

### Functions

```javascript
job.start();
```

This runs your job if `start` was not passed to the constructor.

```javascript
job.stop()
```

This stops the job from running.

```javascript
job.next()
```

This calculates the next time this job will (or would) run.

## Acknowlegements

Many thanks to [Kelektiv](https://github.com/kelektiv) for his
excellent [cron][cron] package.

## Author

Cliff Stanford <<cliff@may.be>>

## Issues

Please report all issues via the [Github issues page](https://github.com/CliffS/suncronjob/issues).

## Licence

This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author
of this software dedicates any and all copyright interest in the
software to the public domain. I make this dedication for the benefit
of the public at large and to the detriment of my heirs and
successors. I intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <http://unlicense.org>


SunCalc = require 'suncalc'

tomorrow = =>
  date = new Date
  date.setDate date.getDate() + 1
  date

class SunCronJob

  constructor: (params, @job) ->
    throw new TypeError unless typeof @job is 'function'
    defaults =
      latitude: 51.4826
      longitude: 0
      hours: 0
      minutes: 0
      seconds: 0
      offset: 'before'
      riseset: 'sunrise'
      once: false
    Object.assign @, defaults, params
    delay = (((@hours * 60) + @minutes) * 60 + @seconds) * 1000
    # delay is milliseconds after
    @delay = switch @offset
      when 'before'
        -delay
      when 'after'
        delay
      else
        throw new TypeError 'offset must be "before" or "after"'
    unless @riseset in ['sunrise', 'sunset']
      throw new TypeError 'riseset must be "sunrise" or "sunset"'
    @runAt @next()

  runAt: (date) ->
    delay = date.valueOf() - new Date().valueOf()
    # Use setImmediate to prevent infinite recursion on runAt()
    setImmediate =>
      @timer = setTimeout =>
        @job()
        @runAt @next tomorrow() unless @once
      , delay

  next: (date = new Date()) ->
    times = SunCalc.getTimes date, @latitude, @longitude
    time = new Date times[@riseset].valueOf() + @delay
    if time.valueOf() <= new Date().valueOf()
      @next tomorrow()
    else time

  cancel: ->
    clearTimeout @timer if @timer
    delete @timer

module.exports = SunCronJob

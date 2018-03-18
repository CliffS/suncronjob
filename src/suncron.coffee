
{ CronJob, CronTime } = require 'cron'
SunCalc = require 'suncalc'

class SunCronJob

  constructor: (params) ->
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
    @cronTime = @next()
    @onComplete = if @once then =>
        params.onComplete?()
        running = false
      else =>
        params.onComplete?()
        @cronTime = @next()
        @job = new CronJob @
    @job = new CronJob @

  next: (date = new Date()) ->
    times = SunCalc.getTimes date, @latitude, @longitude
    time = new Date times[@riseset].valueOf() + @delay
    if time <= new Date
      date.setDate date.getDate() + 1
      @next date
    else time

  start: ->
    @job.start()
    @running = true

  stop: ->
    @job.stop()
    @running = false

module.exports = SunCronJob

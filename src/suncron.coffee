
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
    @params = Object.assign {}, defaults, params
    delay = (((@params.hours * 60) + @params.minutes) * 60 + @params.seconds) * 1000
    # delay is milliseconds after
    @delay = switch @params.offset
      when 'before'
        -delay
      when 'after'
        delay
      else
        throw new TypeError 'offset must be "before" or "after"'
    unless @params.riseset in ['sunrise', 'sunset']
      throw new TypeError 'riseset must be "sunrise" or "sunset"'
    throw new TypeError 'onTick is required' unless typeof params.ontick is 'function'
    cronJob =
      cronTime: @next()
      onTick: (complete) =>
        @params.onTick complete
        tomorrow = new Date
        tomorrow.setDate tomorrow.getDate() + 1
        @job.setTime @next tomorrow
      onComplete: @params.onComplete
      start: @params.start
      utcOffset: 0
      unrefTimeout: @params.unrefTimeout
    @job = new CronJob cronJob

  next: (date = new Date()) ->
    times = SunCalc.getTimes date, @params.latitude, @params.longitude
    time = new Date times[@params.riseset].valueOf() + @delay
    if time <= new Date
      date.setDate date.getDate() + 1
      @next date
    else time

  start: ->
    @job.start()

  stop: ->
    @job.stop()

module.exports = SunCronJob

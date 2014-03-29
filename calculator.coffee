_ = require "underscore"

class Calculator
    constructor: ->
        @salaries  = require "./data/salaries.json"                 

    getSalary: (jobId, sex, age)=>
        # Find the job
        job   = _.findWhere @salaries, id_metier: jobId
        # On letter convertion of the sex
        sex   = if sex is "male" then "m" else "f"
        # Get the range of the given age
        range = @getAgeRange(age)
        # Stop here if a part of the key is missing
        return unless job? and sex? and range?
        # Create the key to get the data and get them
        job[ range + "_" + sex ]

    getAgeRanges: =>
        # No range until @salaries isn't empty
        return [] unless @salaries? and @salaries.length
        # Get keys from the first element
        keys = _.keys @salaries[0]
        # Filter keys by keeping the one stating by a number
        keys = _.filter keys, (k)-> /^\d*_/.test(k)
        # Map value to only key number
        keys = _.map keys, (k)-> k.match(/^\d*/)[0]
        # Keep each number once and returns the list        
        _.unique(keys).sort()

    getAgeRange: (age)=>
        ranges  = @getAgeRanges()
        # Take the younger by default
        res     = ranges[0]
        lastIdx = ranges.length - 1
        # Fetch all range
        for range, idx in ranges  
            # Is the older one
            if res > ranges[0] and idx is lastIdx
                res = ranges[lastIdx]
                break
            # Current range is smaller than the age and next range is bigger
            if range <= age and ranges[idx+1] > age
                res = range 
                break
        res

module.exports = Calculator
_ = require "underscore"

class Calculator
    constructor: ->
        @salaries  = require "./data/salaries.json"                 
        @coeffs    = require "./data/coeff-cities.json"  
        @spo       = require "./data/spo.json"  

    getSalary: (jobId, sex, age, city)=>
        # Find the job
        job   = _.findWhere @salaries, id_metier: jobId
        # On letter convertion of the sex
        sex   = if sex is "male" then "m" else "f"
        # Get the range of the given age
        range = @getAgeRange(age)
        # Stop here if a part of the key is missing
        return unless job? and sex? and range?        
        # If a city is given we look for the its coefficient for this SPO
        coeff = if city? then 1*@getCitySpoCoeff(city, sex, job.id_spo) else 1
        # Create the key to get the data and get them        
        salary : job[ range + "_" + sex ] * coeff, spo : job.id_spo, coeff: coeff
            
    getCitySpoCoeff: (cityId, sex, spoId)=>
        # File nomenclature adaptation
        sex  = if sex is "m" then "h" else sex
        # Build the slug to retreive the coeff 
        slug = sex.toUpperCase() + "_" + @spo[spoId]
        # Find the city
        city = _.findWhere @coeffs, CODGEO: cityId     
        # Convert french number format to machine readable format         
        if city? then city[slug].replace(",", ".") else 1        


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
cors       = require('cors')
express    = require('express')
# The Calculator class manages every calculations
Calculator = require("./calculator")
# Create an instance of the calcultor (that does calculation for us...)
calculator = new Calculator()
# Create a simple express app
app = do express
# This application allows CORS
app.use cors() 
# Main (and only) route
app.get '/:job/:sex/:age/:cityOrRegion', (req, res)->    
    # Params shortcuts
    params = req.params
    # Use the calculator
    salary = calculator.getSalary params.job, params.sex, params.age, params.cityOrRegion
    # Returns 404 if we didn't find the salary
    if salary? then res.json(salary) else res.json error: "Unkown profile"

# Then start listening
server = app.listen process.env.PORT or 3000

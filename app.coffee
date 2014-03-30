express    = require('express');
# The Calculator class manages every calculations
Calculator = require("./calculator")
# Create an instance of the calcultor (that does calculation for us...)
calculator = new Calculator()
# Create a simple express app
app = do express
# Main getSalary(and only) route
app.get '/:job/:sex/:age/:city?', (req, res)->    
    # Params shortcuts
    params = req.params
    # Use the calculator
    salary = calculator.getSalary params.job, params.sex, params.age, params.city
    # Returns 404 if we didn't find the salary
    if salary? then res.json(salary) else res.send 404, "Unkown profile"

# Then start listening
server = app.listen process.env.PORT or 3000

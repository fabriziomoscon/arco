http = require 'src/controller/helper/httpResponse'


class Controller

# ----------

  @index: (req, res, next) ->

    res.status 200
    return next()


module.exports = Controller

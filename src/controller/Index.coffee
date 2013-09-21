http = require 'src/middleware/HttpResponse'


class Controller

# ----------

  @index: (req, res, next) ->

    res.status 200
    return next()


module.exports = Controller

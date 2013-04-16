http = require 'src/controller/helper/httpResponse'

class Controller

# ----------

  @index: (req, res, next) ->

    res.status 200
    return res.onion.peel()

module.exports = Controller
should = require 'should'

Geolocation = require 'src/model/Geolocation'


describe 'geolocation model', ->

  describe 'contructor', ->

    describe 'success', ->

      it 'should set lat', ->
        g = new Geolocation 1, 20
        g.lat.should.equal 1

      it 'should set long', ->
        g = new Geolocation 1, 20
        g.long.should.equal 20

# -------------------------------------------------

  describe 'lat setter/getter', ->

    describe 'failures', ->

      call() for call in allNotNumbersTypes.concat([-90.1, 90.1]).map (invalid) ->
        () ->
          it "should not accept #{invalid} as lat", ->
            g = new Geolocation 1, 20
            (-> g.lat = invalid).should.throw "Invalid latitude: #{invalid}"

    describe 'success', ->

      call() for call in [-90, -10, 0.0, 1.5, 56, 90].map (valid) ->
        () ->
          it "should not accept #{valid} as lat", ->
            g = new Geolocation 1, 20
            g.lat = valid
            g.lat.should.equal valid

# -------------------------------------------------

  describe 'long setter/getter', ->

    describe 'failures', ->

      call() for call in allNotNumbersTypes.concat([-180.1, 180.1]).map (invalid) ->
        () ->
          it "should not accept #{invalid} as long", ->
            g = new Geolocation 1, 20
            (-> g.long = invalid).should.throw "Invalid longitude: #{invalid}"

    describe 'success', ->

      call() for call in [-180, -10, 0.0, 1.5, 56, 180].map (valid) ->
        () ->
          it "should not accept #{valid} as long", ->
            g = new Geolocation 1, 20
            g.long = valid
            g.long.should.equal valid

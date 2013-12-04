should = require 'should'

Place       = require 'src/model/Place'
Geolocation = require 'src/model/Geolocation'


describe 'place model', ->

  describe 'contructor', ->

    describe 'failures', ->

      call() for call in allNotObjectTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as geolocation", ->
            (-> new Place invalid).should.throw 'Invalid geolocation'

    describe 'success', ->

      it 'should set the geolocation', ->
        g = new Geolocation 1, 20
        p = new Place g
        p.geolocation = g
        p.geolocation.should.eql g

# --------------------------------------------------

  describe 'id setter/getter', ->

    describe 'failures', ->

      call() for call in allTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as id", ->
            g = new Geolocation 1, 20
            p = new Place g
            (-> p.id = invalid).should.throw 'Invalid id'

    describe 'success', ->

      it 'should accept a valid id', ->
        g = new Geolocation 1, 20
        p = new Place g
        p.id = '50b896ddc814556766000999'
        p.id.should.equal '50b896ddc814556766000999'


# --------------------------------------------------

  describe 'geolocation setter/getter', ->

    describe 'failures', ->

      call() for call in allTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as geolocation", ->
            g = new Geolocation 1, 20
            p = new Place g
            (-> p.geolocation = invalid).should.throw 'Invalid geolocation'

    describe 'success', ->

      it 'should accept a valid geolocation', ->
        g = new Geolocation 1, 20
        p = new Place g
        p.geolocation = g
        p.geolocation.should.eql g

# --------------------------------------------------

  describe 'country setter/getter', ->

    describe 'failures', ->

      call() for call in allNotStringTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as country", ->
            g = new Geolocation 1, 20
            p = new Place g
            (-> p.country = invalid).should.throw 'Invalid country'

    describe 'success', ->

      it 'should accept a valid country', ->
        g = new Geolocation 1, 20
        p = new Place g
        p.country = 'United States'
        p.country.should.equal 'United States'

# --------------------------------------------------

  describe 'city setter/getter', ->

    describe 'failures', ->

      call() for call in allNotStringTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as city", ->
            g = new Geolocation 1, 20
            p = new Place g
            (-> p.city = invalid).should.throw 'Invalid city'

    describe 'success', ->

      it 'should accept a valid city', ->
        g = new Geolocation 1, 20
        p = new Place g
        p.city = 'London'
        p.city.should.equal 'London'

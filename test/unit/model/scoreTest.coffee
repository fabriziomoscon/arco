should = require 'should'

Score = require 'src/model/Score'
Match = require 'src/model/Match'

mockRules = {
  max_arrows: 60
  min_per_arrow: 0
  max_per_arrow: 10
  partials: ['first', 'second']
}

describe 'user model', ->

  describe 'contructor', ->

    describe 'defaults', ->

      it 'should have rules', ->
        s = new Score 'Indoor 18m', mockRules
        should.exist s.rules

    describe 'success', ->

      it 'should have times', ->
        s = new Score 'Indoor 18m', mockRules
        should.exist s.times

      it 'should have places', ->
        s = new Score 'Indoor 18m', mockRules
        should.exist s.places

      it 'should have arrows', ->
        s = new Score 'Indoor 18m', mockRules
        should.exist s.arrows

# -------------------------------------------------

  describe 'rules setter/getter', ->

    describe 'failures', ->

      call() for call in allNotObjectTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as rules", ->
            s = new Score 'Indoor 18m', mockRules
            (-> s.rules = invalid).should.throw 'Invalid rules'

    describe 'success', ->

      it 'should accept a valid rules', ->
        rules = {
          max_arrows: 2
          min_per_arrow: 4
          max_per_arrow: 10
          partials: ['first', 'second']
        }

        s = new Score 'Indoor 18m', mockRules
        s.rules = rules
        s.rules.should.eql rules

# -------------------------------------------------

  describe 'id setter/getter', ->

    describe 'failures', ->

      call() for call in allTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as id", ->
            s = new Score 'Indoor 18m', mockRules
            (-> s.id = invalid).should.throw 'Invalid id'

    describe 'success', ->

      it 'should accept a valid id', ->
        s = new Score 'Indoor 18m', mockRules
        s.id = '50b896ddc814556766000999'
        s.id.should.equal '50b896ddc814556766000999'

# -------------------------------------------------

  describe 'type setter/getter', ->

    describe 'failures', ->

      call() for call in allTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as type", ->
            s = new Score 'Indoor 18m', mockRules
            (-> s.type = invalid).should.throw 'Invalid type'

    describe 'success', ->

      call() for call in Object.keys(Match.TYPES).map (valid) ->
        () ->
          it "should accept #{valid} as type", ->
            s = new Score 'Indoor 18m', mockRules
            s.type = valid
            s.type.should.equal valid

# -------------------------------------------------

  describe 'total setter/getter', ->

    describe 'failures', ->

      call() for call in allNotNumbersTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as total", ->
            s = new Score 'Indoor 18m', mockRules
            (-> s.total = invalid).should.throw 'Invalid total'

    describe 'success', ->

      call() for call in [0, 1, 2000, 100000000].map (valid) ->
        () ->
          it "should accept #{valid} as total", ->
            s = new Score 'Indoor 18m', mockRules
            s.total = valid
            s.total.should.equal valid

# -------------------------------------------------

  describe 'user id setter/getter', ->

    describe 'failures', ->

      call() for call in allTypes.map (invalid) ->
        () ->
          it "should not accept #{invalid} as user id", ->
            s = new Score 'Indoor 18m', mockRules
            (-> s.user_id = invalid).should.throw 'Invalid user id'

    describe 'success', ->

      it 'should accept a valid user id', ->
        s = new Score 'Indoor 18m', mockRules
        s.user_id = '50b896ddc814556766000999'
        s.user_id.should.equal '50b896ddc814556766000999'

# ---------------------------------------------------

  describe 'addPoint', ->

    describe 'failures', ->

      call() for call in (allNotNumbersTypes.concat([-1])).map (invalid) ->
        () ->
          it "should not accept #{invalid} as point", ->
            s = new Score 'Indoor 18m', mockRules
            (-> s.addPoint invalid, 'first').should.throw 'Invalid point'

      call() for call in (allNotStringTypes.concat('')).map (invalid) ->
        () ->
          it "should not accept #{invalid} as partial name", ->
            s = new Score 'Indoor 18m', mockRules
            (-> s.addPoint 1, invalid).should.throw 'Invalid partial name'

      it 'should not accept a point below the min per arrow for the match type', ->
        s = new Score 'Indoor 18m', {
          max_arrows: 1
          min_per_arrow: 4
          max_per_arrow: 10
          partials: ['first', 'second']
        }
        (-> s.addPoint 1, 'first').should.throw '1 is below the minimum for Indoor 18m'

      it 'should not accept a point above the max per arrow for the match type', ->
        s = new Score 'Indoor 18m', {
          max_arrows: 1
          min_per_arrow: 4
          max_per_arrow: 10
          partials: ['first', 'second']
        }
        (-> s.addPoint 11, 'first').should.throw '11 is above the maximum for Indoor 18m'

      it 'should not accept an invalid partial name', ->
        s = new Score 'Indoor 18m', {
          max_arrows: 1
          min_per_arrow: 4
          max_per_arrow: 10
          partials: ['first', 'second']
        }
        (-> s.addPoint 9, 'fourth').should.throw 'fourth is not a valid partial for Indoor 18m score'

      it 'should not accept more point over the max arrow for the score', ->
        s = new Score 'Indoor 18m', {
          max_arrows: 2
          min_per_arrow: 4
          max_per_arrow: 10
          partials: ['first', 'second']
        }
        s.addPoint 9, 'first'
        s.addPoint 9, 'first'
        (-> s.addPoint 9, 'first').should.throw 'this score has already 2 arrows'

    describe 'success', ->

      it 'should add points', ->
        s = new Score 'Indoor 18m', mockRules
        s.addPoint 10, 'first'
        s.addPoint 6, 'first'
        s.addPoint 9, 'first'
        s.arrows.first.should.eql [10, 6, 9]

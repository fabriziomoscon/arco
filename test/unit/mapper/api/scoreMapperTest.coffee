should = require 'should'
Hash  = require 'node-hash'

apiScoreMapper = require 'src/mapper/api/score'

Match = require 'src/model/Match'
Score = require 'src/model/Score'

describe 'api score mapper', ->

  describe 'marshall', ->

    describe 'failures', ->

      call() for call in allTypes.map (invalid) ->
        () ->
          it "should not marshall #{invalid}", ->
            (-> apiScoreMapper.marshall invalid).should.throw 'Invalid score'

    describe 'success', ->

      it 'should marshall the id', ->
        s = scoreFactory()
        data = apiScoreMapper.marshall s
        data.id.should.equal s.id

      it 'should marshall the user id', ->
        s = scoreFactory()
        data = apiScoreMapper.marshall s
        data.user_id.should.equal s.user_id

      it 'should marshall the type', ->
        s = scoreFactory()
        data = apiScoreMapper.marshall s
        data.type.should.equal s.type

      it 'should marshall the total', ->
        s = scoreFactory()
        data = apiScoreMapper.marshall s
        data.total.should.equal s.total

      it 'should marshall any set time within score times', ->
        s = scoreFactory()
        s.times = new Hash ['created', 'half', 'empty'], Hash.comparator.Date

        s.times.created = new Date 2010, 0, 1
        s.times.half = new Date 2010, 0, 1

        data = apiScoreMapper.marshall s
        data.times.created.should.eql Math.floor s.times.created.getTime()/1000
        data.times.half.should.eql Math.floor s.times.half.getTime()/1000

        should.not.exist data.times.empty

      it 'should marshall the arrows', ->
        s = scoreFactory()
        data = apiScoreMapper.marshall s
        should.exist data.arrows.first
        data.arrows.first.should.eql s.arrows.first
        should.exist data.arrows.second
        data.arrows.second.should.eql s.arrows.second

# ------------------------------------------------------------------------------------

  describe 'unmarshallForCreating', ->

    describe 'failures', ->

      call() for call in allNotObjectTypes.map (invalid) ->
        () ->
          it "should not unmarshall #{invalid}", ->
            (-> apiScoreMapper.unmarshallForCreating invalid).should.throw 'Invalid score data'

      call() for call in [{}, {x:1}].map (invalid) ->
        () ->
          it "should not unmarshall #{invalid} as user_id", ->
            (-> apiScoreMapper.unmarshallForCreating invalid).should.throw 'Invalid score user_id'

      call() for call in [{user_id:10}].map (invalid) ->
        () ->
          it "should not unmarshall #{invalid} as type", ->
            (-> apiScoreMapper.unmarshallForCreating invalid).should.throw 'Invalid score type'

    describe 'success', ->

      mandatoryData =
        user_id:'5aa896ddc814556766002001'
        type: Object.keys(Match.TYPES)[0]

      it 'should unmarshall the user_id', ->
        score = apiScoreMapper.unmarshallForCreating mandatoryData
        score.should.be.instanceof Score
        score.user_id.should.equal mandatoryData.user_id

      it 'should unmarshall the type', ->
        score = apiScoreMapper.unmarshallForCreating mandatoryData
        score.should.be.instanceof Score
        score.type.should.equal mandatoryData.type
